import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> sendOTP(String phoneNumber) async {
    final Completer<String> completer = Completer<String>();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Autenticación automática en algunos dispositivos Android
          await _auth.signInWithCredential(credential);
          if (!completer.isCompleted) {
            completer.complete('auto-verified');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            completer.completeError(
              Exception('Error de verificación: ${e.message}'),
            );
          }
        },
        codeSent: (String verId, int? resendToken) {
          if (!completer.isCompleted) {
            completer.complete(verId);
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          // Timeout alcanzado, si no se completó antes, completar ahora
          if (!completer.isCompleted) {
            completer.complete(verId);
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return await completer.future;
    } catch (e) {
      throw Exception('Error al enviar OTP: $e');
    }
  }

  Future<User?> verifyOTP({
    required String verificationId,
    required String otp,
    required String phoneNumber,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await _saveOrUpdateUser(user, phoneNumber);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Código inválido o expirado: ${e.message}');
    } catch (e) {
      throw Exception('Error al verificar código: $e');
    }
  }

  Future<void> _saveOrUpdateUser(User user, String phoneNumber) async {
    try {
      final phoneWithCode = phoneNumber.startsWith('+')
          ? phoneNumber
          : '+591$phoneNumber';

      final existingQuery = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneWithCode)
          .limit(1)
          .get();

      if (existingQuery.docs.isNotEmpty) {
        final existingDoc = existingQuery.docs.first;
        final oldUid = existingDoc.id;

        if (oldUid != user.uid) {
          final existingData = existingDoc.data();

          await _firestore.collection('users').doc(user.uid).set({
            ...existingData,
            'uid': user.uid,
            'lastLogin': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            'phoneNumber': phoneWithCode,
          });

          await _firestore.collection('users').doc(oldUid).delete();
        } else {
          await _firestore.collection('users').doc(user.uid).update({
            'lastLogin': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      } else {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'phoneNumber': phoneWithCode,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'isActive': true,
          'isVerified': false,
        });
      }
    } catch (e) {
      throw Exception('Error guardando usuario: $e');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
