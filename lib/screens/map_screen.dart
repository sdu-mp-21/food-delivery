import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as location;


class MapScreen extends StatefulWidget {
  List<Restaurant> restaurantsList;

  MapScreen(this.restaurantsList);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  location.Location currentLocation =  location.Location();
  Set<Marker> _markers = {};

  void getMarkers() {
    //markers to place on map
    setState(() {
      widget.restaurantsList.forEach((restaurant) {
        _markers.add(
          Marker(
            markerId: MarkerId(restaurant.id.toString()),
            position: LatLng(restaurant.address.latitude, restaurant.address.longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow( //popup info
              title: restaurant.name,
              snippet: restaurant.address.text_address,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(restaurant: restaurant)));
              },
            ),
          ),
        );
      });
      //add more markers here
    });
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();

    _controller
        ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      target: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
      zoom: 17.0,
    )));
    print(location.latitude);
    print(location.longitude);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('Home'),
          position:
              LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0)));
    });
    //
    // List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude?? 45.25, location.longitude?? 76.23);
    // print(placemarks);
    // Placemark place = placemarks[0];
    // print('${place.street}');
    GetAddressFromLatLong(location);
  }

  Future<void> GetAddressFromLatLong(var location)async {
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(location.latitude, location.longitude);
    geocoding.Placemark place = placemarks[0];
    var Address = '${place.street}';
    print(Address);

  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(43.238949, 76.889709),
          zoom: 11.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          getLocation();
        },
      ),
    );
  }
}
