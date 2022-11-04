import 'package:background_location/background_location.dart';
import 'package:latlong2/latlong.dart';

Location current_location=Location(longitude: 0, latitude: 0, altitude: 0, accuracy: 0, bearing: 0, speed: 0, time: 0, isMock: true);
LatLng current_LatLng=LatLng(0, 0);
void init_location(){
  BackgroundLocation.setAndroidNotification(
    title: "Hiking_app background location service",
    message: "Monitors hiking path",
    icon: "@mipmap/ic_launcher",
  );
  BackgroundLocation.setAndroidConfiguration(5000);
  BackgroundLocation.startLocationService();
  BackgroundLocation.getLocationUpdates((location) {
    current_location=location;
    current_LatLng=LatLng(current_location.latitude!,current_location.longitude!);
  });
}

