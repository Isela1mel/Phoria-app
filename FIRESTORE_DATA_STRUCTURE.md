# Estructura de Datos en Firestore

## 📋 Descripción General

**UserSchedule** = Datos generales fijos del usuario (escuela, traslado, descanso)
**ActivityBlockModel** = Actividades variables que crea el usuario con horarios específicos

---

## 1️⃣ UserSchedule (Horario Fijo del Usuario)

**Colección:** `schedules`  
**Documento:** `{userId}`  
**Propósito:** Guardar datos generales y bloques diarios fijos

### Campos:
```dart
{
  "userId": "uid123",                  // ID del usuario
  "entradaClases": "07:00",           // Entrada a clases (formato HH:MM)
  "salidaClases": "14:00",            // Salida de clases (formato HH:MM)
  "traslado": 30,                     // Minutos de traslado
  "suenioMinimo": 8,                  // Horas mínimas de sueño (descanso)
  "horaLevantarse": "06:00",          // Hora de levantarse (formato HH:MM, descanso)
  "createdAt": Timestamp              // Fecha de creación
}
```

### Uso:
- ✅ Se guarda **una sola vez** por usuario en `schedules/{uid}`
- ✅ Incluye datos de descanso: `suenioMinimo` + `horaLevantarse`
- ✅ Si el usuario actualiza, se sobrescribe con `set()`

### En Code:
```dart
final schedule = UserSchedule(
  userId: uid,
  entradaClases: '07:00',
  salidaClases: '14:00',
  traslado: 30,
  suenioMinimo: 8,
  horaLevantarse: '06:00',
  createdAt: Timestamp.now(),
);
await userService.guardarHorario(schedule);
```

---

## 2️⃣ ActivityBlockModel (Actividades Específicas)

**Colección:** `usuarios/{uid}/activity_blocks`  
**Documentos:** Múltiples (uno por cada actividad)  
**Propósito:** Guardar actividades predefinidas y creadas por el usuario con horarios

### Estructura:
```
usuarios/
  {uid}/
    activity_blocks/
      {docId1}: ActivityBlockModel
      {docId2}: ActivityBlockModel
      {docId3}: ActivityBlockModel
```

### Campos por Actividad:
```dart
{
  "userId": "uid123",                 // ID del usuario (para referencia)
  "nombre": "Estudiar Java",          // Nombre de la actividad
  "horaInicio": "15:30",              // Hora inicio (formato HH:MM)
  "horaFin": "17:00",                 // Hora fin (formato HH:MM)
  "createdAt": Timestamp              // Fecha de creación
}
```

### Ejemplo Real:
Si el usuario crea 3 actividades en el onboarding:
- Estudiar Java (15:30-17:00)
- Desayunar (07:00-07:30)
- Hacer ejercicio (18:00-19:00)

Se guardan así en Firestore:
```
usuarios/uid123/activity_blocks/
  ├─ doc1: {nombre: "Estudiar Java", horaInicio: "15:30", horaFin: "17:00", ...}
  ├─ doc2: {nombre: "Desayunar", horaInicio: "07:00", horaFin: "07:30", ...}
  └─ doc3: {nombre: "Hacer ejercicio", horaInicio: "18:00", horaFin: "19:00", ...}
```

### Uso:
```dart
// Guardar múltiples actividades (se crean 3 documentos)
List<ActivityBlockModel> actividades = [
  ActivityBlockModel(userId: uid, nombre: "Java", horaInicio: "15:30", horaFin: "17:00", createdAt: Timestamp.now()),
  ActivityBlockModel(userId: uid, nombre: "Desayunar", horaInicio: "07:00", horaFin: "07:30", createdAt: Timestamp.now()),
  ActivityBlockModel(userId: uid, nombre: "Ejercicio", horaInicio: "18:00", horaFin: "19:00", createdAt: Timestamp.now()),
];
await userService.guardarMultiplesActividades(actividades);

// Leer todas
List<ActivityBlockModel> acts = await userService.leerActividades();
```

---

## 📱 Flujo en Onboarding

### Pantalla 1: Crear Actividad
- Usuario crea forma: nombre, horaInicio, horaFin
- Retorna: `Map<String, String> {nombre, horaInicio, horaFin}`

### Pantalla 2: Agregar Descanso
- Recibe lista de actividades del Paso 1
- Usuario ingresa: horaSueño (número), horaLevantarse (time picker)
- **GUARDA ACTIVIDADES** → `usuarios/{uid}/activity_blocks/` (N documentos)
- Retorna: horaSueño, horaLevantarse a pantalla Listo

### Pantalla 3: Listo
- Recibe: horaSueño, horaLevantarse
- **GUARDA HORARIO** → `schedules/{uid}` (1 documento UserSchedule)
- Navega a Dashboard

```
crear_actividad.dart
    ↓ (retorna actividades)
agregar_descanso.dart
    ↓ (guarda activity_blocks + retorna horasSueño)
listo.dart
    ↓ (guarda schedules)
Dashboard
```

---

## 🔧 Servicios (UserService)

### Métodos para UserSchedule:
```dart
guardarHorario(UserSchedule)     // Guarda en schedules/{uid}
leerHorario()                     // Lee del usuario actual
leerHorarioPorUserId(userId)      // Lee de otro usuario
actualizarCampoHorario(campo, valor)
eliminarHorario()
```

### Métodos para ActivityBlockModel:
```dart
guardarActividad(ActivityBlockModel)              // 1 actividad → 1 doc
guardarMultiplesActividades(List<ActivityBlockModel>)  // N actividades → N docs
leerActividades()                 // Lee todas del usuario actual
leerActividadesPorUserId(userId)  // Lee de otro usuario
leerActividad(actividadId)        // Lee una específica
actualizarActividad(id, modelo)
eliminarActividad(actividadId)
eliminarTodasLasActividades()     // CUIDADO: borra todo
```

---

## 💾 Formato de Horas

Todas las horas se guardan en formato **24h string "HH:MM"**:
- ✅ "06:00" (mañana)
- ✅ "15:30" (tarde)
- ✅ "23:59" (noche)
- ❌ "3:30 PM" (NO usar)
- ❌ "3:30 am" (NO usar)

Función helper:
```dart
String _formatearHora(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
```

---

## 🚨 Consideraciones Importantes

### ✅ Diseño Separado:
- **UserSchedule** = 1 documento fijo por usuario (datos generales + descanso)
- **ActivityBlockModel** = N documentos por usuario (actividades variables)

### ⚠️ Duplicados:
Si el usuario re-entra en onboarding:
- Las nuevas actividades se **AÑADEN** (no reemplazan)
- Para limpiar: `eliminarTodasLasActividades()` antes de crear nuevas

### 📊 Escalabilidad:
- UserSchedule: O(1) lectura/escritura
- Activities: O(n) pero optimizado con índices en Firestore
- Subcoleción mantiene datos del usuario aislados

---

## 🗂️ Archivos Relacionados

| Archivo | Propósito |
|---------|-----------|
| `lib/backend/models/user_scheduel.dart` | Modelo UserSchedule |
| `lib/backend/models/activity_block_model.dart` | Modelo ActivityBlockModel |
| `lib/backend/services/user_service.dart` | Servicio centralizado |
| `lib/Screens/bloque_inicio/crear_actividad.dart` | Pantalla 1: crear |
| `lib/Screens/bloque_inicio/agregar_descanso.dart` | Pantalla 2: guardar activities + descanso |
| `lib/Screens/bloque_inicio/listo.dart` | Pantalla 3: guardar schedule |
