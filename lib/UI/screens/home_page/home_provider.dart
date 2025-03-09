import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../../../models/ThemeInteriorModel.dart';

class HomeProvider extends ChangeNotifier {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  late Map<String, RemoteConfigValue>? _allRemoteConfigs;
  late List<String> categories = [];
  late List<ThemeInteriorModel> themesList = [];
  late List<String> designersList = [];
  late bool isCategoriesLoading = true;
  late bool isThemeItemsLoading = true;
  late bool isDesignerLoading = true;

  _setUpRemoteConfigs() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
  }

  Future<void> fetchAndActivate() async {
    await _setUpRemoteConfigs();
    await _remoteConfig.fetchAndActivate();
  }

  Future<void> getCategories() async {
    notifyListeners();
    _allRemoteConfigs = _remoteConfig.getAll();
    final list = _allRemoteConfigs!["categories_list"]?.asString();
    categories = List<String>.from(jsonDecode(list!));
    isCategoriesLoading = false;
    notifyListeners();
  }

  Future<void> getThemesItems() async {
    notifyListeners();
    if (_allRemoteConfigs == null) {
      _allRemoteConfigs = _remoteConfig.getAll();
      _getThemesListFromConfigs(_allRemoteConfigs!);
    } else {
      _getThemesListFromConfigs(_allRemoteConfigs!);
    }
  }

  void _getThemesListFromConfigs(Map<String, dynamic> allRemoteConfigs) {
    final list = allRemoteConfigs["themes_items"]?.asString();
    final testList = themeInteriorModelFromJson(list);
    themesList = testList;
    isThemeItemsLoading = false;
    notifyListeners();
  }

  void getDesigners() {
    notifyListeners();
    if (_allRemoteConfigs == null) {
      _allRemoteConfigs = _remoteConfig.getAll();
      _getDesignersList(_allRemoteConfigs);
    } else {
      _getDesignersList(_allRemoteConfigs);
    }
  }

  void _getDesignersList(Map<String, RemoteConfigValue>? allRemoteConfigs) {
    final list = allRemoteConfigs!["designers"]?.asString();
    designersList = List<String>.from(jsonDecode(list!));
    isDesignerLoading = false;
    notifyListeners();
  }
}
