import 'package:background_location/background_location.dart';

Location current_location=Location(longitude: 0, latitude: 0, altitude: 0, accuracy: 0, bearing: 0, speed: 0, time: 0, isMock: true);

void init_location(){
  BackgroundLocation.setAndroidNotification(
    title: "Notification title",
    message: "Notification message",
    icon: "@mipmap/ic_launcher",
  );
  BackgroundLocation.setAndroidConfiguration(5000);
  BackgroundLocation.startLocationService();
  BackgroundLocation.getLocationUpdates((location) {
    current_location=location;
  });
}

