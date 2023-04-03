import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  late MapboxMapController mapController;

  String selectedTheme =
      "mapbox://styles/frankito123/clg17n1ax001u01k5e37vo5ul";

  final center = const LatLng(37.810575, -122.477124);

  final satelliteStreets =
      'mapbox://styles/frankito123/clg17n1ax001u01k5e37vo5ul';

  final navigation = 'mapbox://styles/frankito123/clg183qfu007v01pew7mqv86s';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    // _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(Uri.parse(url));
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Box"),
      ),
      body: MapboxMap(
        styleString: selectedTheme,
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _onStyleLoaded,
        accessToken:
            "sk.eyJ1IjoiZnJhbmtpdG8xMjMiLCJhIjoiY2xnMTV0cXFkMDkxcjNncnEzMjhpNWN2diJ9.NH0bTpfwHwZmie8pZ2UU_A",
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 14,
        ),
      ),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Símbolos
        FloatingActionButton(
            child: const Icon(Icons.sentiment_very_dissatisfied),
            onPressed: () {
              mapController.addSymbol(SymbolOptions(
                  geometry: center,
                  iconSize: 2,
                  iconImage: "assetImage",
                  textField: 'Montaña creada aquí',
                  textOffset: const Offset(0, 2)));
            }),

        const SizedBox(height: 5),

        // ZoomIn
        FloatingActionButton(
            child: const Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            }),

        const SizedBox(height: 5),

        // ZoomOut
        FloatingActionButton(
            child: const Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            }),

        const SizedBox(height: 5),

        // Cambiar Estilos
        FloatingActionButton(
            child: const Icon(Icons.add_to_home_screen),
            onPressed: () {
              if (selectedTheme == satelliteStreets) {
                selectedTheme = navigation;
              } else {
                selectedTheme = satelliteStreets;
              }
              _onStyleLoaded();

              setState(() {});
            })
      ],
    );
  }
}
