import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_ui_sample/data/repository/SplashRepository.dart';

import '../../data/network/DioProvider.dart';
import '../models/FirebaseRemoteConfigs.dart';

class SplashRepositoryImpl extends SplashRepository {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  late Map<String, RemoteConfigValue>? _allRemoteConfigs;

  @override
  Future<void> fetchAndActivate() async {
    await setupRemoteConfigs();
    await _remoteConfig.fetchAndActivate();
    setUpConfigs(_remoteConfig);
  }

  @override
  Future<void> setupRemoteConfigs() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }

  @override
  void setUpConfigs(FirebaseRemoteConfig firebaseRemoteConfig) {
    _allRemoteConfigs = _remoteConfig.getAll();
    final list = _allRemoteConfigs!["app_data"]?.asString();
    FirebaseRemoteConfigs.instance.saveJSON(list!);
    DioProvider dioProvider = DioProvider();
    dioProvider.initialize(
      baseUrl: FirebaseRemoteConfigs.instance.tmdbBaseUrl!,
      authKey: FirebaseRemoteConfigs.instance.authToken!,
    );
    dioProvider.setFileUploadBaseUrl(
      FirebaseRemoteConfigs.instance.apiBaseUrl!,
    );
  }
}
