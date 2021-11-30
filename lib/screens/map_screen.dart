import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/services/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'details_screen.dart';

class MapScreen extends StatefulWidget {
  List<Restaurant> restaurantsList;

  MapScreen({required this.restaurantsList});

  LatLng? currentLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController = MapController();

  List<Marker> _buildMarkers(
      BuildContext context, List<Restaurant> restaurants) {
    List<Marker> markers = [];

    restaurants.forEach((restaurant) {
      markers.add(Marker(
          width: 55,
          height: 55,
          point:
              LatLng(restaurant.address.latitude, restaurant.address.longitude),
          builder: (ctx) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(restaurant: restaurant)));
              },
              child: Image(
                image: NetworkImage('https://bit.ly/3llRID1'),
                fit: BoxFit.contain,
              ))));
    });

    return markers;
  }

  _getCurrentLocation() {
    _mapController.onReady.then((value) => _mapController.move(
        LatLng(widget.currentLocation!.latitude,
            widget.currentLocation!.longitude),
        15));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocListener<LocationCubit, LocationState>(
            listener: (previousState, currentState) {
              if (currentState is LocationLoaded) {
                setState(() {
                  _mapController.onReady.then((value) => _mapController.move(
                      LatLng(currentState.latitude, currentState.longitude),
                      15));
                  widget.currentLocation =
                      LatLng(currentState.latitude, currentState.longitude);
                });
              }
            },
            child: Stack(
              children:[
                FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(43.238949, 76.889709),
                  zoom: 12,
                  maxZoom: 17,
                  minZoom: 3.5,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    retinaMode: true,
                  ),
                  MarkerLayerOptions(
                    markers: [
                      if (widget.currentLocation != null)
                        Marker(
                            width: 55,
                            height: 55,
                            point: LatLng(widget.currentLocation!.latitude,
                                widget.currentLocation!.longitude),
                            builder: (ctx) => GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 55,
                                ))),
                      ..._buildMarkers(context, widget.restaurantsList)
                    ],
                  ),
                ],
              ),

              ]
            )),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.location_on),
            backgroundColor: new Color(0xFFE57373),
            onPressed: _getCurrentLocation));
  }
}
