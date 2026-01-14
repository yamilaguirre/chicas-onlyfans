# 📊 Estructura de Base de Datos - Firestore

## 🎯 Visión General

Esta es la estructura completa de colecciones de Firestore para la aplicación ChicasApp, optimizada para escalabilidad y consultas eficientes.

---

## 📁 Colecciones Principales

### 1. 👤 **users** (Colección Root)

**Path:** `/users/{userId}`

Almacena toda la información de usuarios (hombres y mujeres).

```json
{
  "id": "user123",
  "phone": "+591 78945612",
  "email": "usuario@example.com",
  "username": "maria_bella",
  "name": "María González",
  "profileImageUrl": "https://storage.firebase.com/...",
  "bio": "Creadora de contenido 💕",
  "birthDate": "1998-05-15T00:00:00.000Z",

  "userType": "female", // "male" o "female"
  "role": "creator", // "subscriber", "creator", "premium", "admin"
  "isVerified": true, // Verificado por la plataforma
  "isOnline": true, // Estado en línea
  "lastSeen": "2026-01-13T10:30:00.000Z",

  "interests": ["fitness", "música", "cocina"],
  "followers": ["user456", "user789"], // IDs de seguidores
  "following": ["user999", "user888"], // IDs de usuarios que sigue
  "blockedUsers": ["user333"], // Usuarios bloqueados

  "stats": {
    "totalFollowers": 1250,
    "totalFollowing": 45,
    "totalLikes": 5800,
    "totalPosts": 120,
    "totalLives": 45
  },

  "settings": {
    "allowNotifications": true,
    "allowMessages": true, // Solo de seguidores o todos
    "privateAccount": false
  },

  "createdAt": "2025-12-01T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `userType` + `isOnline` (para buscar creadoras online)
- `role` + `createdAt` (para analytics)
- `username` (para búsquedas)

---

### 2. 💰 **wallets** (Colección Root)

**Path:** `/wallets/{userId}`

Una wallet por usuario (principalmente para hombres, pero puede aplicar a mujeres con créditos).

```json
{
  "userId": "user123",
  "availableMinutes": 145,          // Minutos disponibles actualmente
  "totalPurchased": 500,            // Total de minutos comprados históricamente
  "totalSpent": 355,                // Total de minutos gastados
  "totalAmount": 250.50,            // Total de dinero gastado (Bs)

  "lastPurchase": {
    "amount": 60,
    "minutes": 60,
    "date": "2026-01-10T15:20:00.000Z"
  },

  "pendingCharges": 0,              // Minutos pendientes de cobrar
  "
": "active",                 // "active", "suspended", "frozen"

  "createdAt": "2025-12-01T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `userId` (único)
- `status` + `availableMinutes`

---

### 3. 💳 **transactions** (Colección Root)

**Path:** `/transactions/{transactionId}`

Registro de todas las transacciones (compras y gastos).

```json
{
  "id": "txn_abc123",
  "userId": "user123", // Quien realizó la transacción
  "type": "purchase", // "purchase" (compra), "spent" (gasto), "refund" (reembolso)

  "minutes": 60, // Cantidad de minutos
  "amount": 40.0, // Monto en Bs
  "currency": "BOB",

  "description": "Compra de 60 minutos",
  "paymentMethod": "credit_card", // "credit_card", "debit_card", "paypal", "manual"
  "paymentStatus": "completed", // "pending", "completed", "failed", "refunded"

  // Solo para gastos (type: spent)
  "relatedTo": {
    "type": "live", // "live", "post", "message"
    "id": "live_xyz789", // ID del live/post
    "creatorId": "user456", // Creadora que recibió el pago
    "creatorEarnings": 28.0, // Ganancia de la creadora (70%)
    "platformFee": 12.0 // Comisión de la plataforma (30%)
  },

  "metadata": {
    "deviceId": "iPhone14",
    "ipAddress": "192.168.1.10",
    "appVersion": "1.0.5"
  },

  "createdAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `userId` + `createdAt` (para historial de usuario)
- `userId` + `type` + `createdAt`
- `relatedTo.creatorId` + `createdAt` (para ganancias de creadoras)
- `paymentStatus` + `createdAt`

---

### 4. 📹 **live_streams** (Colección Root)

**Path:** `/live_streams/{liveId}`

Transmisiones en vivo activas e históricas.

```json
{
  "id": "live_xyz789",
  "creatorId": "user456",
  "creatorName": "María González",
  "creatorAvatar": "https://storage.firebase.com/...",

  "title": "Cocina junto a mi 🍳",
  "description": "Hoy preparamos pasta italiana",
  "thumbnailUrl": "https://storage.firebase.com/...",

  "isActive": true, // Si está en vivo ahora
  "isPublic": true, // Público o privado
  "pricePerMinute": 1, // Minutos que cuesta por minuto de visualización

  "agoraChannelName": "channel_123", // Canal de Agora
  "agoraToken": "token_abc...", // Token temporal

  "viewers": {
    "current": 45, // Viewers actuales
    "peak": 120, // Pico máximo
    "total": 350 // Total de viewers únicos
  },

  "activeViewers": {
    // Viewers conectados ahora
    "user123": {
      "joinedAt": "2026-01-13T10:30:00.000Z",
      "username": "carlos_pro"
    }
  },

  "stats": {
    "totalDuration": 3600, // Duración total en segundos
    "totalLikes": 450,
    "totalComments": 120,
    "totalGifts": 35,
    "totalEarnings": 450.0 // Ganancias totales del live
  },

  "settings": {
    "allowComments": true,
    "allowGifts": true,
    "recordStream": true
  },

  "startedAt": "2026-01-13T10:00:00.000Z",
  "endedAt": null, // null si sigue activo
  "createdAt": "2026-01-13T09:55:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `isActive` + `createdAt` (para lives activos)
- `creatorId` + `createdAt` (historial de lives de una creadora)
- `isActive` + `viewers.current` (lives populares)

---

### 5. 📸 **posts** (Colección Root)

**Path:** `/posts/{postId}`

Publicaciones de fotos y videos de las creadoras.

```json
{
  "id": "post_abc123",
  "creatorId": "user456",
  "creatorName": "María González",
  "creatorAvatar": "https://storage.firebase.com/...",

  "type": "photo", // "photo", "video"
  "mediaUrl": "https://storage.firebase.com/posts/...",
  "thumbnailUrl": "https://storage.firebase.com/thumbs/...",

  "title": "Día de playa 🏖️",
  "description": "Disfrutando del sol y mar",
  "price": 10, // Minutos necesarios para ver
  "isFree": false, // Si es gratis o de pago

  "duration": 30, // Solo para videos (segundos)
  "resolution": "1080p",

  "stats": {
    "views": 1250,
    "likes": 450,
    "comments": 85,
    "shares": 20,
    "earnings": 125.0 // Ganancias por este post
  },

  "tags": ["playa", "verano", "bikini"],

  "viewedBy": ["user123", "user789"], // IDs que ya vieron el post
  "likedBy": ["user123"],

  "isActive": true, // Si está visible
  "isReported": false, // Si fue reportado
  "reportCount": 0,

  "createdAt": "2026-01-13T08:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `creatorId` + `createdAt` (posts de una creadora)
- `isActive` + `createdAt` (feed global)
- `type` + `createdAt`
- `tags` (array-contains) + `createdAt`

---

### 6. 💬 **conversations** (Colección Root)

**Path:** `/conversations/{conversationId}`

Conversaciones entre usuarios.

```json
{
  "id": "conv_abc123",
  "participantIds": ["user123", "user456"], // Siempre 2 usuarios
  "participants": {
    "user123": {
      "name": "Carlos López",
      "avatar": "https://storage.firebase.com/...",
      "role": "subscriber",
      "unreadCount": 0
    },
    "user456": {
      "name": "María González",
      "avatar": "https://storage.firebase.com/...",
      "role": "creator",
      "unreadCount": 2
    }
  },

  "lastMessage": {
    "text": "Gracias por el regalo! 💝",
    "senderId": "user456",
    "sentAt": "2026-01-13T10:25:00.000Z",
    "type": "text" // "text", "image", "gift"
  },

  "isActive": true,
  "isBlocked": false,
  "blockedBy": null, // userId de quien bloqueó

  "createdAt": "2026-01-10T15:00:00.000Z",
  "updatedAt": "2026-01-13T10:25:00.000Z"
}
```

**Subcolección:** `/conversations/{conversationId}/messages/{messageId}`

```json
{
  "id": "msg_xyz123",
  "conversationId": "conv_abc123",
  "senderId": "user456",
  "senderName": "María González",

  "type": "text", // "text", "image", "gift", "system"
  "text": "Gracias por el regalo! 💝",
  "imageUrl": null,

  "gift": {
    // Solo si type: gift
    "type": "roses",
    "value": 5, // Minutos de valor
    "imageUrl": "https://..."
  },

  "isRead": false,
  "readAt": null,

  "sentAt": "2026-01-13T10:25:00.000Z"
}
```

**Índices necesarios:**

- `participantIds` (array-contains) + `updatedAt` (conversaciones de un usuario)
- `conversationId` + `sentAt` (mensajes de una conversación)

---

### 7. 🔔 **notifications** (Colección Root)

**Path:** `/notifications/{notificationId}`

Notificaciones para usuarios.

```json
{
  "id": "notif_abc123",
  "userId": "user123", // Usuario que recibe la notificación

  "type": "live_started", // "live_started", "new_post", "new_message", "new_follower", "gift_received"
  "title": "María está en vivo!",
  "body": "Tu creadora favorita acaba de iniciar un live",
  "imageUrl": "https://storage.firebase.com/...",

  "relatedTo": {
    "type": "live", // "live", "post", "message", "user"
    "id": "live_xyz789",
    "userId": "user456" // Usuario relacionado
  },

  "isRead": false,
  "readAt": null,

  "action": {
    "type": "navigate", // "navigate", "open_url"
    "screen": "live_screen",
    "params": { "liveId": "live_xyz789" }
  },

  "createdAt": "2026-01-13T10:00:00.000Z"
}
```

**Índices necesarios:**

- `userId` + `isRead` + `createdAt`
- `userId` + `type` + `createdAt`

---

### 8. 💵 **earnings** (Colección Root)

**Path:** `/earnings/{userId}`

Ganancias de las creadoras (agregación por períodos).

```json
{
  "userId": "user456", // Creadora

  "total": {
    "gross": 5250.0, // Ganancia bruta total
    "net": 3675.0, // Ganancia neta (después de comisión 30%)
    "withdrawn": 2000.0, // Ya retirado
    "available": 1675.0 // Disponible para retirar
  },

  "thisMonth": {
    "gross": 850.0,
    "net": 595.0,
    "lives": 420.0,
    "posts": 175.0
  },

  "lastMonth": {
    "gross": 1200.0,
    "net": 840.0
  },

  "breakdown": {
    "lives": 2450.0,
    "posts": 1050.0,
    "gifts": 175.0
  },

  "topDonors": [
    {
      "userId": "user123",
      "name": "Carlos_VIP",
      "avatar": "https://...",
      "totalDonated": 450.0,
      "rank": 1
    }
  ],

  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `userId` (único)

---

### 9. 💸 **withdrawals** (Colección Root)

**Path:** `/withdrawals/{withdrawalId}`

Solicitudes de retiro de dinero de las creadoras.

```json
{
  "id": "withdraw_abc123",
  "userId": "user456",
  "amount": 500.0,
  "currency": "BOB",

  "status": "pending", // "pending", "processing", "completed", "rejected"
  "method": "bank_transfer", // "bank_transfer", "paypal"

  "bankDetails": {
    "accountNumber": "1234567890",
    "accountName": "María González",
    "bankName": "Banco Nacional"
  },

  "processedBy": null, // Admin userId
  "processedAt": null,
  "rejectionReason": null,

  "createdAt": "2026-01-13T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `userId` + `createdAt`
- `status` + `createdAt`

---

### 10. 👥 **subscriptions** (Colección Root)

**Path:** `/subscriptions/{subscriptionId}`

Relaciones de seguimiento entre usuarios.

```json
{
  "id": "sub_abc123",
  "subscriberId": "user123", // Quien sigue
  "creatorId": "user456", // A quien sigue

  "tier": "free", // "free", "vip", "premium"
  "isActive": true,

  "notifications": {
    "lives": true,
    "posts": true,
    "messages": false
  },

  "stats": {
    "totalSpent": 250.0, // Total gastado en esta creadora
    "totalMinutesWatched": 180,
    "lastInteraction": "2026-01-13T10:00:00.000Z"
  },

  "createdAt": "2025-12-15T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

**Índices necesarios:**

- `subscriberId` + `createdAt` (seguimientos de un usuario)
- `creatorId` + `createdAt` (seguidores de una creadora)
- `subscriberId` + `creatorId` (único compuesto)

---

### 11. 🚫 **reports** (Colección Root)

**Path:** `/reports/{reportId}`

Reportes de contenido/usuarios inapropiados.

```json
{
  "id": "report_abc123",
  "reporterId": "user123",
  "reportedType": "post", // "user", "post", "live", "message"
  "reportedId": "post_xyz789",

  "reason": "inappropriate_content", // "spam", "harassment", "nudity", "violence", "other"
  "description": "Contenido explícito no permitido",

  "status": "pending", // "pending", "reviewing", "resolved", "dismissed"
  "reviewedBy": null, // Admin userId
  "reviewedAt": null,
  "action": null, // "warning", "suspension", "ban", "content_removed"

  "createdAt": "2026-01-13T10:00:00.000Z",
  "updatedAt": "2026-01-13T10:30:00.000Z"
}
```

---

## 🔐 Reglas de Seguridad Recomendadas

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Función helper para verificar autenticación
    function isSignedIn() {
      return request.auth != null;
    }

    // Función helper para verificar si es el usuario
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }

    // Función helper para verificar si es creadora
    function isCreator() {
      return isSignedIn() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'creator';
    }

    // Users: lectura pública, escritura solo el dueño
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isOwner(userId);
      allow update: if isOwner(userId);
      allow delete: if false;
    }

    // Wallets: solo el dueño puede leer/escribir
    match /wallets/{userId} {
      allow read: if isOwner(userId);
      allow write: if false; // Solo via Cloud Functions
    }

    // Transactions: solo el dueño puede leer
    match /transactions/{transactionId} {
      allow read: if isOwner(resource.data.userId);
      allow write: if false; // Solo via Cloud Functions
    }

    // Live Streams: lectura pública, escritura solo la creadora
    match /live_streams/{liveId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isCreator();
      allow update: if isOwner(resource.data.creatorId);
      allow delete: if isOwner(resource.data.creatorId);
    }

    // Posts: lectura pública, escritura solo la creadora
    match /posts/{postId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isCreator();
      allow update: if isOwner(resource.data.creatorId);
      allow delete: if isOwner(resource.data.creatorId);
    }

    // Conversations: solo participantes pueden leer/escribir
    match /conversations/{conversationId} {
      allow read: if isSignedIn() &&
                     request.auth.uid in resource.data.participantIds;
      allow create: if isSignedIn();
      allow update: if isSignedIn() &&
                       request.auth.uid in resource.data.participantIds;

      // Messages subcollection
      match /messages/{messageId} {
        allow read: if isSignedIn() &&
                       request.auth.uid in get(/databases/$(database)/documents/conversations/$(conversationId)).data.participantIds;
        allow create: if isSignedIn() &&
                         request.auth.uid in get(/databases/$(database)/documents/conversations/$(conversationId)).data.participantIds;
      }
    }

    // Notifications: solo el usuario puede leer
    match /notifications/{notificationId} {
      allow read: if isOwner(resource.data.userId);
      allow write: if false; // Solo via Cloud Functions
    }

    // Earnings: solo la creadora puede leer
    match /earnings/{userId} {
      allow read: if isOwner(userId);
      allow write: if false; // Solo via Cloud Functions
    }

    // Withdrawals: solo la creadora puede crear y leer las suyas
    match /withdrawals/{withdrawalId} {
      allow read: if isOwner(resource.data.userId);
      allow create: if isSignedIn() && isCreator();
      allow update: if false; // Solo via admin
    }

    // Subscriptions: lectura pública, escritura autenticado
    match /subscriptions/{subscriptionId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.subscriberId);
      allow delete: if isOwner(resource.data.subscriberId);
    }

    // Reports: solo el reportero puede crear, solo admin puede leer
    match /reports/{reportId} {
      allow read: if false; // Solo via admin panel
      allow create: if isSignedIn();
      allow update: if false; // Solo via admin
    }
  }
}
```

---

## 📈 Consideraciones de Escalabilidad

### 1. **Denormalización Estratégica**

- Duplicar datos de usuario (nombre, avatar) en posts/lives para evitar múltiples lecturas
- Mantener contadores (`stats`) en documentos principales en lugar de contar subcollections

### 2. **Subcollections vs Arrays**

- **Messages:** Usar subcolecciones (escala infinitamente)
- **Followers/Following:** Arrays hasta 1000, luego migrar a subcolecciones

### 3. **Índices Compuestos**

Crear en Firebase Console:

- `live_streams`: `isActive` ASC, `viewers.current` DESC
- `posts`: `creatorId` ASC, `createdAt` DESC
- `transactions`: `userId` ASC, `type` ASC, `createdAt` DESC

### 4. **Cloud Functions Recomendadas**

- **onLiveStreamEnd:** Calcular earnings y actualizar wallet de creadora
- **onTransactionCreate:** Actualizar wallet del usuario
- **onMessageCreate:** Incrementar unreadCount en conversation
- **onFollowCreate:** Incrementar followers/following count

### 5. **Paginación**

Limitar queries a 20-50 documentos usando `.limit()` y cursor pagination

---

## 🎯 Próximos Pasos

1. ✅ Implementar modelos Dart para cada colección
2. ✅ Crear servicios con métodos CRUD
3. ✅ Implementar Cloud Functions para lógica de negocio
4. ✅ Configurar índices en Firebase Console
5. ✅ Aplicar reglas de seguridad

---

Esta estructura está lista para soportar **miles de usuarios concurrentes** y **millones de transacciones**. 🚀
