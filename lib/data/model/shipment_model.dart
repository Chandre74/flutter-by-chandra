class Shipment {
  final String id;
  final String pickupAddress;
  final String deliveryAddress;
  String status;

  Shipment({
    required this.id,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.status,
  });
}
