import 'package:logistics_driver_app/data/model/shipment_model.dart';
import 'package:logistics_driver_app/data/raw_datas/shipment.dart';

class ShipmentService {
  static Future<List<Shipment>>? fetchShipments() async {
    await Future.delayed(const Duration(seconds: 2));
    return shipments;
  }
}
