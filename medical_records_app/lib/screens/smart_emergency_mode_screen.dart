import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SmartEmergencyModeScreen extends StatefulWidget {
  const SmartEmergencyModeScreen({super.key});

  @override
  State<SmartEmergencyModeScreen> createState() => _SmartEmergencyModeScreenState();
}

class _SmartEmergencyModeScreenState extends State<SmartEmergencyModeScreen> {
  late GoogleMapController _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "SMART EMERGENCY MODE",
          style: GoogleFonts.sora(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Animated Pulse Header
          Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              "❤️‍🔥 PULSE ACTIVE",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1400.ms),
          ),

          // VITALS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "VITALS",
                  style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildVitalCard("O+", Icons.water_drop),
                    _buildVitalCard("Penicillin", Icons.block),
                    _buildVitalCard("Aspirin", Icons.medication),
                    _buildVitalCard("Metformin", Icons.medication_outlined),
                  ],
                ),
              ],
            ),
          ),

          // Google Map (Live Location)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(14),
              ),
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator(color: Colors.redAccent))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _currentPosition!,
                          zoom: 16,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('me'),
                            position: _currentPosition!,
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                          )
                        },
                        onMapCreated: (controller) => _mapController = controller,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                      ),
                    ),
            ),
          ),

          // QR CODE placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  "QR CODE HERE\nScan for ICE (In Case of Emergency)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),

          const Spacer(),

          // SOS Button
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: GestureDetector(
              onTap: () {
                // TODO: Integrate SOS logic (call/send)
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.7),
                      blurRadius: 20,
                      spreadRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 800.ms)
                  .then()
                  .shake(hz: 1, offset: const Offset(2, 0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.redAccent.withOpacity(0.1),
        border: Border.all(color: Colors.redAccent, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}
