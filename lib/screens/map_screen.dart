import 'package:delivery_app/models/address_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart' as location;
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  List<Restaurant> restaurantsList;
  Address userAddress = new Address(latitude: 0.0, longitude: 0.0, text_address: '');

  MapScreen(this.restaurantsList);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  location.Location currentLocation = location.Location();
  Set<Marker> _markers = {};

  void getMarkers() {
    //markers to place on map
    setState(() {
      widget.restaurantsList.forEach((restaurant) {
        _markers.add(
          Marker(
            markerId: MarkerId(restaurant.id.toString()),
            position: LatLng(
                restaurant.address.latitude, restaurant.address.longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              //popup info
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
    GetAddressFromLatLong(location);
  }

  Future<void> GetAddressFromLatLong(var location) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(location.latitude, location.longitude);
    geocoding.Placemark place = placemarks[0];
    var text_address = '${place.street}';
    print(text_address);

    widget.userAddress.latitude = location.latitude;
    widget.userAddress.longitude = location.longitude;
    widget.userAddress.text_address = text_address;
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
      body: Stack(children: [
        GoogleMap(
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
        MaterialButton(
          onPressed: () {},
          child: Text('Choose'),
        ),
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(
              Icons.location_searching,
              color: Colors.white,
            ),
            onPressed: () {
              getLocation();
            },
          ),
          SizedBox(height:5.0),
          FloatingActionButton(
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, widget.userAddress);
            },

          )
        ],
      ),
    );
  }
}
