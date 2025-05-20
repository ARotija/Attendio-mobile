class Device {
  final String id;         // UUID del dispositivo BLE
  final int userId;        // ID del usuario al que está vinculado
  final bool active;       // Si el dispositivo está activo o no

  Device({
    required this.id,
    required this.userId,
    required this.active,
  });

  /// Crea una instancia de [Device] desde un JSON
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      userId: json['user_id'] as int,
      active: json['active'] as bool,
    );
  }

  /// Convierte una instancia de [Device] a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'active': active,
    };
  }
}
