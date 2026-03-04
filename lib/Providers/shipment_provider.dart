import 'package:flutter/material.dart';
import 'package:logistics_driver_app/data/model/shipment_model.dart';
import 'package:logistics_driver_app/data/model/shipment_details_model.dart';
import 'package:logistics_driver_app/data/raw_datas/shipment.dart';
import 'package:logistics_driver_app/data/raw_datas/shipment_details.dart';

class ShipmentProvider extends ChangeNotifier {
  final List<Shipment> _shipments = shipments;

  List<Shipment> get shipmentList => _shipments;

  Shipment? _selectedShipment;

  Shipment? get selectedShipment => _selectedShipment;

  void selectShipment(Shipment shipment) {
    _selectedShipment = shipment;
    notifyListeners();
  }

  final List<ShipmentDetailsModel> _shipmentDetails = shipmentDetailsList;

  List<ShipmentDetailsModel> get shipmentDetails => _shipmentDetails;

  ShipmentDetailsModel getShipmentDetailsById(String id) {
    return _shipmentDetails.firstWhere((item) => item.id == id);
  }
}
