import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  //Es un future que contiene el controlodor del googlemap
  Completer<GoogleMapController> _controller = Completer();
  MapType maptype = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    //Posicion inicial del mapa
    final CameraPosition puntoInicial = CameraPosition(
        target: scan.getLatLng(), zoom: 17, tilt: 50, bearing: 45.0);

    //Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLatLng(), zoom: 17.5, tilt: 50),
                  ),
                );
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: maptype,
        initialCameraPosition: puntoInicial,
        markers: markers,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            if (maptype == MapType.normal) {
              maptype = MapType.hybrid;
            } else {
              maptype = MapType.normal;
            }
            setState(() {});
          }),
    );
  }
}
