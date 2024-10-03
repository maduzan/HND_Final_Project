import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Confermorder extends StatefulWidget {
  const Confermorder({super.key});

  @override
  State<Confermorder> createState() => _ConfermorderState();
}

class _ConfermorderState extends State<Confermorder> {
  GoogleMapController? _googleMapController;
  LatLng? _currentLocation;
  LatLng? _destination;
  String _currentAddress = '';
  String _destinationAddress = '';

  // List of possible locations for dropdown selection
  List<String> _locations = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4'
  ];

  String? _selectedCurrentLocation;
  String? _selectedDestination;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Check and request location permission
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when the user denied the permission
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Location permission is required to use this feature.")));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Location permissions are permanently denied. Please enable them in the app settings.")));
      return;
    }

    // If permission is granted, fetch current location
    _getCurrentLocation();
  }

  // Fetch user's current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _locations[0] =
            'Your Current Location: (${position.latitude}, ${position.longitude})'; // Update first location
        _selectedCurrentLocation =
            _locations[0]; // Auto-select current location
      });
    } catch (e) {
      // Handle the error if fetching location fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Failed to fetch location. Make sure location services are enabled.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use null-aware operators and provide default values

    // Ensure the keys match what you passed exactly

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) =>
                        _googleMapController = controller,
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 14.0,
                    ),
                    markers: _createMarkers(),
                    myLocationEnabled: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(55.0),
                  child: Column(
                    children: [
                      // Dropdown for Current Location
                      Text(
                        "Select Current Location:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: _selectedCurrentLocation,
                        items: _locations.map((location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Container(
                              width: 150, // Set a max width
                              child: Text(
                                location,
                                overflow: TextOverflow
                                    .ellipsis, // Add ellipsis for overflow
                                softWrap: false,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCurrentLocation = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 30),

                      // Dropdown for Destination
                      Text(
                        "Select Destination:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      // or a specific width
                      DropdownButton<String>(
                        value: _selectedDestination,
                        items: _locations.map((location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Container(
                              width: 150, // Set a max width
                              child: Text(
                                location,
                                overflow: TextOverflow
                                    .ellipsis, // Add ellipsis for overflow
                                softWrap: false,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDestination = value!;
                          });
                        },
                      ),

                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async {
                          final args = ModalRoute.of(context)!
                              .settings
                              .arguments as Map<String, dynamic>;

                          // Print the keys to debug
                          debugPrint('Arguments keys: ${args.keys.toList()}');

                          // Log the entire arguments map
                          debugPrint('Arguments: $args');

                          // Ensure you access the keys correctly
                          String email = args.containsKey('email')
                              ? args['email'] as String
                              : ''; // No need for String? here since it's already checked
                          String jobRole = args.containsKey(
                                  'jobrall') // Make sure the key matches what you pushed
                              ? args['jobrall'] as String
                              : '';
                          String name = args.containsKey('name')
                              ? args['name'] as String
                              : '';

                          // Log the email and other variables
                          debugPrint("Email before sending: $email");
                          debugPrint("Job Role: $jobRole");
                          debugPrint("Name: $name");

                          if (email.isEmpty) {
                            debugPrint("Email is empty!");
                            return; // Early return if the email is empty
                          }

                          // Call sendEmail with the email variable
                          bool result = await sendEmail(
                              {'email': email}); // Pass email as a map

                          if (result) {
                            Navigator.of(context).pushNamed('/payment');
                          } else {
                            debugPrint("Email sending failed.");
                          }
                          await dtodatabase(
                              email, _currentLocation!, _destinationAddress);
                        },
                        child: Text("Confirm Order"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Set<Marker> _createMarkers() {
    final markers = <Marker>{};

    // Marker for the current location
    if (_currentLocation != null) {
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: _currentLocation!,
        infoWindow: InfoWindow(title: 'Your Location'),
      ));
    }

    // Marker for the destination
    if (_selectedDestination != null) {
      // Assume destination LatLng is added to simulate a real location
      markers.add(Marker(
        markerId: MarkerId('destination'),
        position:
            _currentLocation!, // You would replace this with actual LatLng based on selection
        infoWindow: InfoWindow(title: _selectedDestination),
      ));
    }

    return markers;
  }

  Future<bool> sendEmail(Map<String, String> args) async {
    String email = args['email'] ?? '';
    if (email.isEmpty) {
      print("Email is empty!");
      return false;
    }

    print("Email passed: $email");

    final url = 'https://api.emailjs.com/api/v1.0/email/send';

    // API credentials
    final publicKey = 'NoQHvq6Ycch6Nhdkw';
    final serviceId = 'service_d5hh245';
    final templateId = 'template_2gixh5i';
    final privateKey = '4wxMK5xRqVK73YtMnlT7X';

    // Template parameters
    final templateParams = {
      'to_email': email, // Use the dynamic email variable
      'from_email': 'madup133@gmail.com',
      'subject': 'Booking Request',
      'message': 'Hello, I would like to book your services.',
    };

    print("Template Params: $templateParams");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'accessToken': privateKey,
          'template_params': templateParams,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Email sent successfully');
        return true;
      } else {
        print('Failed to send email: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (error) {
      print('ERROR: $error');
      return false;
    }
  }

  Future<void> dtodatabase(
      String email, LatLng currentLocation, String _destinationAddress) async {
    try {
      final ordersCollection = FirebaseFirestore.instance.collection('orders');
      await ordersCollection.add({
        'email': email,
        'currentLocation': {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
        },
        'timestamp': FieldValue.serverTimestamp(), // Optionally add a timestamp
      });
      debugPrint("Order added to Firestore successfully.");
    } catch (e) {
      debugPrint("Failed to add order: $e");
    }
  }
}
