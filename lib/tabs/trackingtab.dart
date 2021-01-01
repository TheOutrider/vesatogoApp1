import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackingTab extends StatefulWidget {
  @override
  _TrackingTabState createState() => _TrackingTabState();
}

class _TrackingTabState extends State<TrackingTab> {

  Set<Marker> markers = new HashSet<Marker>();
  Set<Polyline> polylines = new HashSet<Polyline>();
  GoogleMapController _googleMapController;
  BitmapDescriptor markerIcon;

  String userLat = "", userLon = "";
  double lat, lon;
  double destLat = 18.5204, destLon = 73.8567;

  PermissionStatus _permissionStatus;

  @override
  void initState() {
    super.initState();
    // Permission.checkPermissionStatus(PermissionGroup.locationWhenInUse).then(updateStatus);
    getUserCoords();
  }

  // void askPermission() {
  //   PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]).then(onStatusRequested);
  // }

  // void onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
  //   final status = statuses[PermissionGroup.locationWhenInUse];
  //   if(status != PermissionStatus.granted){
  //     PermissionHandler().openAppSettings();
  //   }
  //   else {
  //     updateStatus(status);
  //   }
  // }
  //
  // void updateStatus(PermissionStatus status) {
  //   if(status != _permissionStatus) {
  //     setState(() {
  //       _permissionStatus = status;
  //     });
  //   }
  // }

   getUserCoords() async {
    final geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLat = '${geoposition.latitude}';
      userLon = '${geoposition.longitude}';
      lat = double.parse(userLat);
      lon = double.parse(userLon);
      setPolyLine(lat , lon);
      print('My User Lat Lon[$lat, $lon]');
    });
  }


  void setPolyLine(double lat, double lon) {
    List<LatLng> polylineLatLngs = new List<LatLng>();
    polylineLatLngs.add(LatLng(lat, lon));
    polylineLatLngs.add(LatLng(20.7865, 77.8791));
    polylineLatLngs.add(LatLng(20.7865, 76.8891));
    polylineLatLngs.add(LatLng(19.7865, 75.8992));
    polylineLatLngs.add(LatLng(destLat, destLon));

    polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLngs,
        width: 3,
        color: Colors.blue,
      )
    );
  }


  void _onMapCreated(GoogleMapController controller){
    _googleMapController = controller;
    setState(() {
      markers.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(destLat, destLon),
        infoWindow: InfoWindow(title: "Destination", snippet: "Final Destination to reach",),
        // icon: markerIcon,
      ),
      );
    });

  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: LatLng(destLat, destLon), zoom: 12
          ),
          markers: markers,
          // polygons: polygons,
          polylines: polylines,
          // circles: circles,
          myLocationEnabled: true,

        ),
        // Container(
        //     alignment: Alignment.bottomRight,
        //     margin: EdgeInsets.all(20),
        //     child: FloatingActionButton(onPressed: askPermission, child: Icon(Icons.gps_fixed_outlined),))
      ],
    );
  }
}
