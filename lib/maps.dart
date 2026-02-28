import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logistics_driver_app/app_colors.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;

  LatLng? _currentPosition;
  LatLng? _previousPosition;

  BitmapDescriptor? _busIcon;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadBusIcon();
    await _startLocationStream();
  }

  // assets\bus.png
  // assets\bus.png
  Future<void> _loadBusIcon() async {
    _busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(60, 60)),
      'assets/bus.png',
    );
  }

  Future<void> _startLocationStream() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.best,
            distanceFilter: 5,
          ),
        ).listen((Position position) {
          final newLatLng = LatLng(position.latitude, position.longitude);

          _previousPosition = _currentPosition;
          _currentPosition = newLatLng;

          if (_mapController != null) {
            _mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: newLatLng,
                  zoom: 17,
                  tilt: 45,
                  bearing: _calculateBearing(),
                ),
              ),
            );
          }

          setState(() {});
        });
  }

  double _calculateBearing() {
    if (_previousPosition == null || _currentPosition == null) return 0;

    final lat1 = _previousPosition!.latitude * pi / 180;
    final lon1 = _previousPosition!.longitude * pi / 180;
    final lat2 = _currentPosition!.latitude * pi / 180;
    final lon2 = _currentPosition!.longitude * pi / 180;

    final dLon = lon2 - lon1;

    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    final bearing = atan2(y, x);

    return (bearing * 180 / pi + 360) % 360;
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
        backgroundColor: AppColors.kGreen,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 17,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("driver"),
            position: _currentPosition!,
            icon: _busIcon ?? BitmapDescriptor.defaultMarker,
            rotation: _calculateBearing(),
            anchor: const Offset(0.5, 0.5),
          ),
        },
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
