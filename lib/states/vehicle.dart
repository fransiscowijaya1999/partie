import 'package:flutter/material.dart';
import 'package:partie/database.dart';

class VehicleState extends ChangeNotifier {
  set vehicle(Vehicle value) {
    vehicle = value;
    notifyListeners();
  }

  set parentVehicle(Vehicle value) {
    parentVehicle = value;
    notifyListeners();
  }

  set parts(List<Part> value) {
    parts = value;
    notifyListeners();
  }
}