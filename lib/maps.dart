import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;

  LatLng _currentPosition = const LatLng(0, 0);
  LatLng? _previousPosition;

  BitmapDescriptor? _busIcon;

  @override
  void initState() {
    super.initState();
    _loadBusIcon();
    _startLocationStream();
  }

  Future<void> _loadBusIcon() async {
    _busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/icons/bus.png',
    );
    setState(() {});
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
            accuracy: LocationAccuracy.high,
            distanceFilter: 5,
          ),
        ).listen((Position position) {
          LatLng newPosition = LatLng(position.latitude, position.longitude);

          _previousPosition = _currentPosition;
          _currentPosition = newPosition;

          _animateCameraSmooth(newPosition);

          setState(() {});
        });
  }

  void _animateCameraSmooth(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 17,
          bearing: _calculateBearing(),
          tilt: 45,
        ),
      ),
    );
  }

  double _calculateBearing() {
    if (_previousPosition == null) return 0;

    double lat1 = _previousPosition!.latitude;
    double lon1 = _previousPosition!.longitude;
    double lat2 = _currentPosition.latitude;
    double lon2 = _currentPosition.longitude;

    double dLon = (lon2 - lon1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double bearing = atan2(y, x);

    return bearing * 180 / pi;
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 15,
        ),
        myLocationEnabled: false,
        markers: {
          Marker(
            markerId: const MarkerId("driver"),
            position: _currentPosition,
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
