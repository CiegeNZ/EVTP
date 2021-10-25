import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

google_maps.CameraPosition updateCamera(l) {
  return google_maps.CameraPosition(
      target: google_maps.LatLng(l.latitude!, l.longitude!), zoom: 16);
}
