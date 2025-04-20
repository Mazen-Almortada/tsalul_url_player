// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsalul_url_player/data/models/stream_model.dart';

final _intentChannel = const MethodChannel('intent_channel');

Future<List<StreamQuality>> receiveIntentQualities() async {
  try {
    final intent = await _intentChannel.invokeMethod('getIntentData');
    final String jsonString = intent['streams'] ?? '[]';
    print(jsonDecode(jsonString));
    final List<dynamic> jsonList = jsonDecode(jsonString);

    List<StreamQuality> streamQualitiesList =
        jsonList
            .map((e) => StreamQuality.fromJson(Map<String, dynamic>.from(e)))
            .toList();
    return streamQualitiesList;
  } on PlatformException catch (e) {
    debugPrint("Error receiving intent data: $e");
    return [];
  }
}

void listenToNewIntents(Function(List<StreamQuality>) onNewData) {
  _intentChannel.setMethodCallHandler((call) async {
    if (call.method == 'newIntentReceived') {
      final dataJson = call.arguments['streams'] as String? ?? '[]';
      final List<dynamic> decoded = jsonDecode(dataJson);
      final qualities =
          decoded
              .map((e) => StreamQuality.fromJson(Map<String, dynamic>.from(e)))
              .toList();

      onNewData(qualities);
    }
    return null;
  });
}
