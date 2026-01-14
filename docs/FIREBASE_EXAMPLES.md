# 🔥 Ejemplos de Datos en Firebase Firestore

Este documento muestra cómo se verán los datos reales en Firebase Firestore cuando se guarden usando los modelos creados.

---

## 📁 Colección: `users`

**Path:** `/users/user123`

```json
{
  "id": "user123",
  "phone": "+591 78945612",
  "email": "maria@example.com",
  "username": "maria_bella",
  "name": "María González",
  "profileImageUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser123.jpg",
  "bio": "Creadora de contenido 💕 Lives cada noche",
  "birthDate": "1998-05-15T00:00:00.000Z",

  "userType": "female",
  "role": "creator",
  "isVerified": true,
  "isOnline": true,
  "lastSeen": "2026-01-13T10:30:00.000Z",

  "interests": ["fitness", "música", "cocina"],
  "followers": ["user456", "user789", "user101"],
  "following": ["user999"],
  "blockedUsers": [],

  "createdAt": "2025-12-01T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Ejemplo Usuario Hombre:**

```json
{
  "id": "user456",
  "phone": "+591 79812345",
  "username": "carlos_pro",
  "name": "Carlos López",
  "profileImageUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser456.jpg",

  "userType": "male",
  "role": "subscriber",
  "isVerified": false,
  "isOnline": true,

  "followers": [],
  "following": ["user123", "user888"],

  "createdAt": "2026-01-01T08:00:00.000Z",
  "updatedAt": "2026-01-13T10:25:00.000Z"
}
```

---

## 💰 Colección: `wallets`

**Path:** `/wallets/user456`

```json
{
  "userId": "user456",
  "availableMinutes": 145,
  "totalPurchased": 500,
  "totalSpent": 355,
  "totalAmount": 250.5,

  "lastPurchase": {
    "amount": 40.0,
    "minutes": 60,
    "date": "2026-01-10T15:20:00.000Z"
  },

  "pendingCharges": 0,
  "status": "active",

  "createdAt": "2026-01-01T08:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Visualización en Firebase Console:**

```
wallets/
├── user456/
│   ├── userId: "user456"
│   ├── availableMinutes: 145
│   ├── totalPurchased: 500
│   ├── totalSpent: 355
│   └── lastPurchase: (map)
│       ├── amount: 40.00
│       ├── minutes: 60
│       └── date: "2026-01-10T15:20:00.000Z"
```

---

## 💳 Colección: `transactions`

**Path:** `/transactions/txn_abc123`

### Ejemplo 1: Compra de minutos

```json
{
  "id": "txn_abc123",
  "userId": "user456",
  "type": "purchase",

  "minutes": 60,
  "amount": 40.0,
  "currency": "BOB",

  "description": "Compra de 60 minutos - Paquete Mejor Valor",
  "paymentMethod": "creditCard",
  "paymentStatus": "completed",

  "relatedTo": null,

  "metadata": {
    "deviceId": "iPhone14",
    "ipAddress": "192.168.1.10",
    "appVersion": "1.0.5"
  },

  "createdAt": "2026-01-10T15:20:00.000Z"
}
```

### Ejemplo 2: Gasto en live

```json
{
  "id": "txn_xyz789",
  "userId": "user456",
  "type": "spent",

  "minutes": 30,
  "amount": 30.0,
  "currency": "BOB",

  "description": "Visualización de live - Cocina junto a mi",
  "paymentMethod": "manual",
  "paymentStatus": "completed",

  "relatedTo": {
    "type": "live",
    "id": "live_xyz789",
    "creatorId": "user123",
    "creatorEarnings": 21.0,
    "platformFee": 9.0
  },

  "createdAt": "2026-01-13T10:00:00.000Z"
}
```

**Visualización en Firebase Console:**

```
transactions/
├── txn_abc123/
│   ├── type: "purchase"
│   ├── minutes: 60
│   ├── amount: 40.00
│   └── paymentStatus: "completed"
├── txn_xyz789/
│   ├── type: "spent"
│   ├── minutes: 30
│   ├── relatedTo: (map)
│   │   ├── type: "live"
│   │   ├── creatorId: "user123"
│   │   ├── creatorEarnings: 21.00
│   │   └── platformFee: 9.00
```

---

## 📹 Colección: `live_streams`

**Path:** `/live_streams/live_xyz789`

```json
{
  "id": "live_xyz789",
  "creatorId": "user123",
  "creatorName": "María González",
  "creatorAvatar": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser123.jpg",

  "title": "Cocina junto a mi 🍳",
  "description": "Hoy preparamos pasta italiana casera",
  "thumbnailUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/thumbnails%2Flive_xyz789.jpg",

  "isActive": true,
  "isPublic": true,
  "pricePerMinute": 1,

  "agoraChannelName": "channel_live_xyz789",
  "agoraToken": "006abc123...",

  "viewers": {
    "current": 45,
    "peak": 120,
    "total": 350
  },

  "activeViewers": {
    "user456": {
      "joinedAt": "2026-01-13T10:30:00.000Z",
      "username": "carlos_pro"
    },
    "user789": {
      "joinedAt": "2026-01-13T10:25:00.000Z",
      "username": "diego_vip"
    }
  },

  "stats": {
    "totalDuration": 3600,
    "totalLikes": 450,
    "totalComments": 120,
    "totalGifts": 35,
    "totalEarnings": 450.0
  },

  "settings": {
    "allowComments": true,
    "allowGifts": true,
    "recordStream": true
  },

  "startedAt": "2026-01-13T10:00:00.000Z",
  "endedAt": null,
  "createdAt": "2026-01-13T09:55:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Visualización en Firebase Console:**

```
live_streams/
├── live_xyz789/
│   ├── title: "Cocina junto a mi 🍳"
│   ├── isActive: true
│   ├── viewers: (map)
│   │   ├── current: 45
│   │   ├── peak: 120
│   │   └── total: 350
│   ├── activeViewers: (map)
│   │   ├── user456: (map)
│   │   │   ├── joinedAt: "2026-01-13T10:30:00.000Z"
│   │   │   └── username: "carlos_pro"
│   └── stats: (map)
│       ├── totalEarnings: 450.00
│       └── totalLikes: 450
```

---

## 📸 Colección: `posts`

**Path:** `/posts/post_abc123`

### Ejemplo 1: Foto

```json
{
  "id": "post_abc123",
  "creatorId": "user123",
  "creatorName": "María González",
  "creatorAvatar": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser123.jpg",

  "type": "photo",
  "mediaUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/posts%2Fpost_abc123.jpg",
  "thumbnailUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/thumbs%2Fpost_abc123.jpg",

  "title": "Día de playa 🏖️",
  "description": "Disfrutando del sol y mar con mis amigas",
  "price": 10,
  "isFree": false,

  "duration": null,
  "resolution": "1080p",

  "stats": {
    "views": 1250,
    "likes": 450,
    "comments": 85,
    "shares": 20,
    "earnings": 125.0
  },

  "tags": ["playa", "verano", "bikini"],

  "viewedBy": ["user456", "user789", "user101"],
  "likedBy": ["user456", "user101"],

  "isActive": true,
  "isReported": false,
  "reportCount": 0,

  "createdAt": "2026-01-13T08:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

### Ejemplo 2: Video

```json
{
  "id": "post_xyz456",
  "creatorId": "user123",
  "creatorName": "María González",
  "creatorAvatar": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser123.jpg",

  "type": "video",
  "mediaUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/posts%2Fpost_xyz456.mp4",
  "thumbnailUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/thumbs%2Fpost_xyz456.jpg",

  "title": "Rutina de ejercicios matutina 💪",
  "description": "Empieza el día con energía",
  "price": 15,
  "isFree": false,

  "duration": 180,
  "resolution": "1080p",

  "stats": {
    "views": 850,
    "likes": 320,
    "comments": 45,
    "shares": 12,
    "earnings": 127.5
  },

  "tags": ["fitness", "ejercicio", "salud"],

  "viewedBy": ["user456", "user789"],
  "likedBy": ["user456"],

  "isActive": true,
  "isReported": false,
  "reportCount": 0,

  "createdAt": "2026-01-12T07:00:00.000Z",
  "updatedAt": "2026-01-13T10:00:00.000Z"
}
```

---

## 💬 Colección: `conversations`

**Path:** `/conversations/conv_abc123`

```json
{
  "id": "conv_abc123",
  "participantIds": ["user456", "user123"],

  "participants": {
    "user456": {
      "name": "Carlos López",
      "avatar": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser456.jpg",
      "role": "subscriber",
      "unreadCount": 0
    },
    "user123": {
      "name": "María González",
      "avatar": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/profiles%2Fuser123.jpg",
      "role": "creator",
      "unreadCount": 2
    }
  },

  "lastMessage": {
    "text": "Gracias por el regalo! 💝",
    "senderId": "user123",
    "sentAt": "2026-01-13T10:25:00.000Z",
    "type": "text"
  },

  "isActive": true,
  "isBlocked": false,
  "blockedBy": null,

  "createdAt": "2026-01-10T15:00:00.000Z",
  "updatedAt": "2026-01-13T10:25:00.000Z"
}
```

**Visualización en Firebase Console:**

```
conversations/
├── conv_abc123/
│   ├── participantIds: ["user456", "user123"]
│   ├── participants: (map)
│   │   ├── user456: (map)
│   │   │   ├── name: "Carlos López"
│   │   │   ├── role: "subscriber"
│   │   │   └── unreadCount: 0
│   │   └── user123: (map)
│   │       ├── name: "María González"
│   │       └── unreadCount: 2
│   └── lastMessage: (map)
│       ├── text: "Gracias por el regalo! 💝"
│       └── sentAt: "2026-01-13T10:25:00.000Z"
```

---

## 📩 Subcolección: `conversations/{convId}/messages`

**Path:** `/conversations/conv_abc123/messages/msg_xyz123`

### Ejemplo 1: Mensaje de texto

```json
{
  "id": "msg_xyz123",
  "conversationId": "conv_abc123",
  "senderId": "user123",
  "senderName": "María González",

  "type": "text",
  "text": "Gracias por el regalo! 💝",
  "imageUrl": null,
  "gift": null,

  "isRead": false,
  "readAt": null,

  "sentAt": "2026-01-13T10:25:00.000Z"
}
```

### Ejemplo 2: Mensaje con regalo

```json
{
  "id": "msg_abc456",
  "conversationId": "conv_abc123",
  "senderId": "user456",
  "senderName": "Carlos López",

  "type": "gift",
  "text": "Te envié unas rosas 🌹",
  "imageUrl": null,

  "gift": {
    "type": "roses",
    "value": 5,
    "imageUrl": "https://firebasestorage.googleapis.com/v0/b/chicasapp/o/gifts%2Froses.png"
  },

  "isRead": true,
  "readAt": "2026-01-13T10:26:00.000Z",

  "sentAt": "2026-01-13T10:24:00.000Z"
}
```

**Visualización en Firebase Console:**

```
conversations/
└── conv_abc123/
    ├── (datos de la conversación)
    └── messages/ (subcollection)
        ├── msg_xyz123/
        │   ├── type: "text"
        │   ├── text: "Gracias por el regalo! 💝"
        │   └── isRead: false
        └── msg_abc456/
            ├── type: "gift"
            ├── gift: (map)
            │   ├── type: "roses"
            │   ├── value: 5
            │   └── imageUrl: "https://..."
            └── isRead: true
```

---

## 🔍 Consultas Comunes en Firestore

### 1. Obtener wallet de un usuario

```dart
final walletDoc = await FirebaseFirestore.instance
    .collection('wallets')
    .doc(userId)
    .get();

final wallet = Wallet.fromJson(walletDoc.data()!);
```

### 2. Obtener lives activos

```dart
final activeLivesQuery = await FirebaseFirestore.instance
    .collection('live_streams')
    .where('isActive', isEqualTo: true)
    .orderBy('viewers.current', descending: true)
    .limit(20)
    .get();

final lives = activeLivesQuery.docs
    .map((doc) => LiveStream.fromJson(doc.data()))
    .toList();
```

### 3. Obtener posts de una creadora

```dart
final postsQuery = await FirebaseFirestore.instance
    .collection('posts')
    .where('creatorId', isEqualTo: creatorId)
    .where('isActive', isEqualTo: true)
    .orderBy('createdAt', descending: true)
    .limit(20)
    .get();

final posts = postsQuery.docs
    .map((doc) => Post.fromJson(doc.data()))
    .toList();
```

### 4. Escuchar mensajes en tiempo real

```dart
FirebaseFirestore.instance
    .collection('conversations')
    .doc(conversationId)
    .collection('messages')
    .orderBy('sentAt', descending: false)
    .snapshots()
    .listen((snapshot) {
      final messages = snapshot.docs
          .map((doc) => Message.fromJson(doc.data()))
          .toList();

      // Actualizar UI con mensajes
    });
```

### 5. Obtener conversaciones de un usuario

```dart
final conversationsQuery = await FirebaseFirestore.instance
    .collection('conversations')
    .where('participantIds', arrayContains: userId)
    .orderBy('updatedAt', descending: true)
    .get();

final conversations = conversationsQuery.docs
    .map((doc) => Conversation.fromJson(doc.data()))
    .toList();
```

---

## 📊 Estructura Visual en Firebase Console

```
📁 Firestore Database
├── 👤 users
│   ├── user123 (creadora)
│   ├── user456 (suscriptor)
│   └── user789 (suscriptor)
│
├── 💰 wallets
│   ├── user456
│   └── user789
│
├── 💳 transactions
│   ├── txn_abc123 (compra)
│   ├── txn_xyz789 (gasto en live)
│   └── txn_def456 (gasto en post)
│
├── 📹 live_streams
│   ├── live_xyz789 (activo)
│   └── live_abc123 (finalizado)
│
├── 📸 posts
│   ├── post_abc123 (foto)
│   ├── post_xyz456 (video)
│   └── post_def789 (foto)
│
└── 💬 conversations
    ├── conv_abc123
    │   └── 📩 messages (subcollection)
    │       ├── msg_001
    │       ├── msg_002
    │       └── msg_003
    └── conv_xyz456
        └── 📩 messages (subcollection)
            ├── msg_001
            └── msg_002
```

---

## ✅ Resumen de Modelos Creados

| Modelo          | Archivo             | Colección Firestore           |
| --------------- | ------------------- | ----------------------------- |
| ✅ User         | `user.dart`         | `users`                       |
| ✅ Wallet       | `wallet.dart`       | `wallets`                     |
| ✅ Transaction  | `transaction.dart`  | `transactions`                |
| ✅ LiveStream   | `live_stream.dart`  | `live_streams`                |
| ✅ Post         | `post.dart`         | `posts`                       |
| ✅ Conversation | `conversation.dart` | `conversations`               |
| ✅ Message      | `message.dart`      | `conversations/{id}/messages` |

Todos los modelos están listos para usar con Firebase Firestore! 🚀
