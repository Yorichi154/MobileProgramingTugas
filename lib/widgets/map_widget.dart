import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../services/location_service.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final LocationService _locationService = LocationService();
  LatLng? _userLocation;
  bool _isLoading = true;
  String? _errorMessage;
  double _zoomLevel = 16.0;
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = "Lokasi tidak aktif. Harap aktifkan GPS Anda.";
        _isLoading = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = "Izin lokasi ditolak";
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage =
            "Izin lokasi ditolak permanen. Ubah di pengaturan perangkat.";
        _isLoading = false;
      });
      return;
    }

    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final locationData = await _locationService.getCurrentLocation();
      if (locationData != null) {
        setState(() {
          _userLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          _isLoading = false;
        });
        _mapController.move(_userLocation!, _zoomLevel);
      } else {
        setState(() {
          _errorMessage = "Gagal mendapatkan lokasi";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Saya"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _centerMapOnUserLocation,
            tooltip: 'Lokasi Saya',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchUserLocation,
            tooltip: 'Refresh Lokasi',
          ),
        ],
      ),
      body: _buildMapContent(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            mini: true,
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _zoomLevel += 1;
                _mapController.move(_mapController.center, _zoomLevel);
              });
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoomOut',
            mini: true,
            child: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _zoomLevel -= 1;
                _mapController.move(_mapController.center, _zoomLevel);
              });
            },
          ),
        ],
      ),
    );
  }

  void _centerMapOnUserLocation() {
    if (_userLocation != null) {
      _mapController.move(_userLocation!, _zoomLevel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lokasi belum tersedia')),
      );
    }
  }

  Widget _buildMapContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkLocationPermission,
              child: const Text("Coba Lagi"),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Geolocator.openAppSettings(),
              child: const Text("Buka Pengaturan"),
            ),
          ],
        ),
      );
    }

    if (_userLocation == null) {
      return const Center(child: Text("Lokasi tidak tersedia"));
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: _userLocation,
        zoom: _zoomLevel,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.tugas_mobile_programing',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _userLocation!,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: _userLocation!,
              color: Colors.blue.withOpacity(0.3),
              borderColor: Colors.blue,
              borderStrokeWidth: 2,
              radius: 100, // 100 meter
            ),
          ],
        ),
      ],
    );
  }
}
