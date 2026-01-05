import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../home/controllers/home_controller.dart';

class MapController extends GetxController {
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Circle> circles = <Circle>{}.obs;

  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final RxBool isLoading = true.obs;
  final RxDouble radiusInMeters = 20000.0.obs; // 20 km radius

  final homeController = Get.find<HomeController>();
  StreamSubscription<Position>? positionStream;

  @override
  void onInit() {
    super.onInit();
    initializeLocation();
  }

  @override
  void onClose() {
    positionStream?.cancel();
    mapController.value?.dispose();
    super.onClose();
  }

  Future<void> initializeLocation() async {
    try {
      // Check location permission
      final permission = await _checkLocationPermission();
      if (!permission) {
        Get.snackbar(
          'Location Permission Required',
          'Please enable location permission to see restaurants near you',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation.value = LatLng(position.latitude, position.longitude);

      // Add current location marker
      _addCurrentLocationMarker();

      // Add 20km radius circle
      _addRadiusCircle();

      // Load restaurants within 20km
      _loadRestaurantsInRadius();

      // Start listening to location updates
      _startLocationUpdates();

      isLoading.value = false;
    } catch (e) {
      print('Error initializing location: $e');
      Get.snackbar(
        'Location Error',
        'Could not get your location. Please enable location services.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void _startLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100, // Update every 100 meters
    );

    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      final newLocation = LatLng(position.latitude, position.longitude);

      // Calculate distance moved
      if (currentLocation.value != null) {
        final distance = Geolocator.distanceBetween(
          currentLocation.value!.latitude,
          currentLocation.value!.longitude,
          newLocation.latitude,
          newLocation.longitude,
        );

        // If moved more than 500 meters, update restaurants
        if (distance > 500) {
          currentLocation.value = newLocation;
          _addCurrentLocationMarker();
          _addRadiusCircle();
          _loadRestaurantsInRadius();

          // Animate camera to new location
          mapController.value?.animateCamera(
            CameraUpdate.newLatLng(newLocation),
          );
        }
      }
    });
  }

  void _addCurrentLocationMarker() {
    if (currentLocation.value == null) return;

    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation.value!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'Your Location',
          snippet: 'You are here',
        ),
      ),
    );
  }

  void _addRadiusCircle() {
    if (currentLocation.value == null) return;

    circles.clear();
    circles.add(
      Circle(
        circleId: const CircleId('search_radius'),
        center: currentLocation.value!,
        radius: radiusInMeters.value,
        fillColor: Colors.blue.withValues(alpha: 0.1),
        strokeColor: Colors.blue.withValues(alpha: 0.5),
        strokeWidth: 2,
      ),
    );
  }

  void _loadRestaurantsInRadius() {
    if (currentLocation.value == null) return;

    // Clear existing restaurant markers
    markers.removeWhere((marker) => marker.markerId.value != 'current_location');

    // Filter restaurants within 20km radius
    final restaurantsInRadius = homeController.restaurants.where((restaurant) {
      // Calculate distance from current location
      final distance = Geolocator.distanceBetween(
        currentLocation.value!.latitude,
        currentLocation.value!.longitude,
        restaurant.latitude,
        restaurant.longitude,
      );

      return distance <= radiusInMeters.value;
    }).toList();

    // Add markers for each restaurant
    for (var restaurant in restaurantsInRadius) {
      markers.add(
        Marker(
          markerId: MarkerId(restaurant.id),
          position: LatLng(restaurant.latitude, restaurant.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            restaurant.isOpen ? BitmapDescriptor.hueRed : BitmapDescriptor.hueOrange,
          ),
          infoWindow: InfoWindow(
            title: restaurant.name,
            snippet: '${restaurant.rating} ⭐ • ${_formatDistance(_calculateDistance(restaurant))} • €${restaurant.deliveryFee}',
          ),
          onTap: () => _onRestaurantMarkerTap(restaurant),
        ),
      );
    }

    Get.snackbar(
      'Restaurants Found',
      'Found ${restaurantsInRadius.length} restaurants within 20km',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  double _calculateDistance(restaurant) {
    if (currentLocation.value == null) return 0;

    return Geolocator.distanceBetween(
      currentLocation.value!.latitude,
      currentLocation.value!.longitude,
      restaurant.latitude,
      restaurant.longitude,
    );
  }

  String _formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toInt()}m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)}km';
    }
  }

  void _onRestaurantMarkerTap(restaurant) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: restaurant.isOpen ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    restaurant.isOpen ? 'Open' : 'Closed',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              restaurant.description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text('${restaurant.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Text('(${restaurant.reviewCount}+)', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 20, color: Colors.red),
                const SizedBox(width: 4),
                Text(_formatDistance(_calculateDistance(restaurant))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed('/restaurant', arguments: restaurant);
                    },
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _navigateToRestaurant(restaurant),
                  icon: const Icon(Icons.directions),
                  label: const Text('Navigate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRestaurant(restaurant) {
    // Open Google Maps for navigation
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${restaurant.latitude},${restaurant.longitude}';
    Get.snackbar(
      'Navigation',
      'Opening Google Maps for directions',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Use url_launcher to open the URL
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;

    if (currentLocation.value != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation.value!, 12),
      );
    }
  }

  void zoomIn() {
    mapController.value?.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController.value?.animateCamera(CameraUpdate.zoomOut());
  }

  void centerToCurrentLocation() {
    if (currentLocation.value != null) {
      mapController.value?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation.value!, 12),
      );
    }
  }

  void updateRadius(double newRadius) {
    radiusInMeters.value = newRadius;
    _addRadiusCircle();
    _loadRestaurantsInRadius();
  }
}

