import 'package:flutter/material.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';

class HomeProvider extends ChangeNotifier {
  String _query = '';
  List<LoremImageInfo> _allImageInfos = [];

  String get query => _query;
  List<LoremImageInfo> get allImageInfos => _allImageInfos;
  List<LoremImageInfo> get filteredImageInfos {
    return _allImageInfos
        .where(
          (imageInfo) => imageInfo.author.toLowerCase().contains(_query),
        )
        .toList();
  }

  set query(String val) {
    _query = val;
    notifyListeners();
  }

  set allImageInfos(List<LoremImageInfo> val) {
    _allImageInfos = val;
    notifyListeners();
  }
}
