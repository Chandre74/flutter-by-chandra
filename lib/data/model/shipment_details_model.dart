class ShipmentDetailsModel {
  final String id;
  final String pickupAddress;
  final String deliveryAddress;
  String status;

  final String senderName;
  final String receiverName;
  final double weight;
  final double price;
  final DateTime createdDate;
  final DateTime estimatedDelivery;
  final bool isFragile;
  final String notes;

  ShipmentDetailsModel({
    required this.id,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.status,
    required this.senderName,
    required this.receiverName,
    required this.weight,
    required this.price,
    required this.createdDate,
    required this.estimatedDelivery,
    required this.isFragile,
    required this.notes,
  });
}
