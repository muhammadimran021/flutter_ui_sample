import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class SplashRepository {
  Future<void> fetchAndActivate();
  Future<void> setupRemoteConfigs();
  void setUpConfigs(FirebaseRemoteConfig firebaseRemoteConfig);
}
