import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_firestore/core/shared_preferences/shared_preference_keys.dart';
import 'package:todo_firestore/features/home/data/models/lorem_image_info_model.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';

class SharedPreferenceManager {
  Future<int> getHomeRequestPage() async {
    final sp = await SharedPreferences.getInstance();
    final page = sp.getInt(SharedPreferenceKeys.homeRequestPage);
    if (page == null) {
      await sp.setInt(SharedPreferenceKeys.homeRequestPage, 0);
      return 0;
    }
    return page;
  }

  Future<void> setHomeRequestPage(int value) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(SharedPreferenceKeys.homeRequestPage, value);
  }

  Future<List<LoremImageInfo>> getHomeImageInfos() async {
    final sp = await SharedPreferences.getInstance();
    final infos = sp.getStringList(SharedPreferenceKeys.homeImageInfos);
    if (infos == null) {
      await sp.setStringList(SharedPreferenceKeys.homeImageInfos, []);
      return [];
    }

    return infos
        .map((info) => LoremImageInfoModel.fromJson(jsonDecode(info)))
        .toList();
  }

  Future<void> setHomeImageInfos(List<LoremImageInfo> value) async {
    final sp = await SharedPreferences.getInstance();
    final model = value
        .map((e) => LoremImageInfoModel(
              author: e.author,
              downloadUrl: e.downloadUrl,
              height: e.height,
              id: e.id,
              url: e.url,
              width: e.width,
            ))
        .toList();
    sp.setStringList(
      SharedPreferenceKeys.homeImageInfos,
      model.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
