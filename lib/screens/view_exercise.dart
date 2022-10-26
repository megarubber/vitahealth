import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vitahealth/widgets/my_appbar.dart';

class ViewExercise extends StatefulWidget {
  @override
  State<ViewExercise> createState() => _ViewExerciseState();
}

class _ViewExerciseState extends State<ViewExercise> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5
  );
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: MyAppBar.textAppBar('Corrida'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: _initialCameraPosition,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                ExerciseButton(
                  diameter: 90.sp,
                  color: Colors.red,
                  message: 'Iniciar'
                )
              ]
            )
          )
        )
      )
    );
  }
}