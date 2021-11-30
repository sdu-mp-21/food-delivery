import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:geolocator/geolocator.dart';part 'location_state.dart';

class LocationCubit extends Cubit<LocationState>{

  LocationCubit(): super(LocationInitial());

  Future<void> getLocation() async{

    LocationPermission permission = await Geolocator.checkPermission();

    if(permission != LocationPermission.denied || permission != LocationPermission.deniedForever){

      try{

        emit(LocationLoading());

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best
        );

        emit(LocationLoaded(latitude: position.latitude, longitude: position.longitude));

      }catch(error){

        print(error);

        emit(LocationError());
      }

    }



  }

}