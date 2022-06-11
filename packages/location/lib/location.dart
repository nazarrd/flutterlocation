import 'package:location_platform_interface/location_platform_interface.dart';

export 'package:location_platform_interface/location_platform_interface.dart'
    show LocationData, LocationAccuracy, LocationSettings, PermissionStatus;

LocationPlatform get _platform => LocationPlatform.instance;

/// Returns the current location.
Future<LocationData> getLocation({LocationSettings? settings}) async {
  final location = await _platform.getLocation(settings: settings);
  if (location == null) throw Exception('Unable to get location');
  return location;
}

/// Listen to the current location.
Stream<LocationData> get onLocationChanged {
  return _platform.onLocationChanged
      .where((event) => event != null)
      .cast<LocationData>();
}

/// Update global location settings.
/// The settings are a passthrought to the [LocationSettings] class.
Future<void> setLocationSettings({
  /// If set to true, the user will be prompted to grant permission to use location
  /// if not already granted.
  bool askForPermission = true,

  /// The message to display to the user when asking for permission to use location.
  /// Only valid on Android.
  /// For iOS, you have to change the permission in the Info.plist file.
  String rationaleMessageForPermissionRequest =
      'The app needs to access your location',

  /// The message to display to the user when asking for permission to use GPS.
  /// Only valid on Android.
  String rationaleMessageForGPSRequest =
      'The app needs to access your location',

  /// If set to true, the app will use Google Play Services to request location.
  /// If not available on the device, the app will fallback to GPS.
  /// Only valid on Android.
  bool useGooglePlayServices = true,

  /// If set to true, the app will request Google Play Services to request location.
  /// If not available on the device, the app will fallback to GPS.
  bool askForGooglePlayServices = false,

  /// If set to true, the app will request GPS to request location.
  /// Only valid on Android.
  bool askForGPS = true,

  /// If set to true, the app will fallback to GPS if Google Play Services is not
  /// available on the device.
  /// Only valid on Android.
  bool fallbackToGPS = true,

  /// If set to true, the app will ignore the last known position
  /// and request a fresh one
  bool ignoreLastKnownPosition = true,

  /// The duration of the location request.
  /// Only valid on Android.
  double? expirationDuration,

  /// The expiration time of the location request.
  /// Only valid on Android.
  double? expirationTime,

  /// The fastest interval between location updates.
  /// In milliseconds.
  /// Only valid on Android.
  double fastestInterval = 500,

  /// The interval between location updates.
  /// In milliseconds.
  double interval = 1000,

  /// The maximum amount of time the app will wait for a location.
  /// In milliseconds.
  double? maxWaitTime,

  /// The number of location updates to request.
  /// Only valid on Android.
  int? numUpdates,

  /// The accuracy of the location request.
  LocationAccuracy accuracy = LocationAccuracy.high,

  /// The smallest displacement between location updates.
  double smallestDisplacement = 0,

  /// If set to true, the app will wait for an accurate location.
  /// Only valid on Android.
  bool waitForAccurateLocation = true,

  /// The accptable accuracy of the location request.
  /// Only valid on Android.
  double? acceptableAccuracy,
}) async {
  final response = await _platform.setLocationSettings(
    LocationSettings(
      askForPermission: askForPermission,
      rationaleMessageForPermissionRequest:
          rationaleMessageForPermissionRequest,
      rationaleMessageForGPSRequest: rationaleMessageForGPSRequest,
      useGooglePlayServices: useGooglePlayServices,
      askForGooglePlayServices: askForGooglePlayServices,
      askForGPS: askForGPS,
      fallbackToGPS: fallbackToGPS,
      ignoreLastKnownPosition: ignoreLastKnownPosition,
      expirationDuration: expirationDuration,
      expirationTime: expirationTime,
      fastestInterval: fastestInterval,
      interval: interval,
      maxWaitTime: maxWaitTime,
      numUpdates: numUpdates,
      accuracy: accuracy,
      smallestDisplacement: smallestDisplacement,
      waitForAccurateLocation: waitForAccurateLocation,
      acceptableAccuracy: acceptableAccuracy,
    ),
  );
  if (response != true) throw Exception('Unable to set new location settings');
}

/// Get permission status.
Future<PermissionStatus> getPermissionStatus() async {
  final response = await _platform.getPermissionStatus();
  if (response == null) {
    throw Exception('Error while getting permission status');
  }
  return response;
}

/// Request location permission.
Future<PermissionStatus> requestPermission() async {
  final response = await _platform.requestPermission();
  if (response == null) {
    throw Exception('Error while getting permission status');
  }
  return response;
}

/// Returns true if the GPS provider is enabled
Future<bool> isGPSEnabled() async {
  final response = await _platform.isGPSEnabled();
  if (response == null) {
    throw Exception('Error while getting GPS status');
  }
  return response;
}

/// Returns true if the Network provider is enabled
Future<bool> isNetworkEnabled() async {
  final response = await _platform.isNetworkEnabled();
  if (response == null) {
    throw Exception('Error while getting Network status');
  }
  return response;
}
