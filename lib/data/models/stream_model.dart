class StreamQuality {
  final String name;
  String url;
  final int urlType;
  final String userAgent;
  final String referer;
  final int eventChannelId;
  final Map<String, String> headers;
  final DRMData? drm;

  StreamQuality({
    required this.name,
    required this.url,
    required this.urlType,
    required this.userAgent,
    required this.referer,
    required this.eventChannelId,
    required this.headers,
    this.drm,
  });

  factory StreamQuality.fromJson(Map<String, dynamic> json) {
    final headers =
        (json['headers'] is Map<String, String>)
            ? Map<String, String>.from(json['headers'] ?? <String, String>{})
            : <String, String>{};

    if (headers.containsKey('User-Agent')) {
      headers['User-Agent'] = headers['User-Agent']!.replaceAll(
        RegExp(r'^[\s\u200B\u200E\u200F]+|[\s\u200B\u200E\u200F]+$'),
        '',
      );
    }
    return StreamQuality(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      urlType: json['url_type'] ?? 0,
      userAgent: json['user_agent'] ?? '',
      referer: json['referer'] ?? '',
      eventChannelId: json['event_channel_id'] ?? 0,
      headers: headers,
      drm: json['drm'] != null ? DRMData.fromJson(json['drm']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
    'url_type': urlType,
    'user_agent': userAgent,
    'referer': referer,
    'event_channel_id': eventChannelId,
    'headers': headers,
    'drm': drm?.toJson(),
  };
}

class DRMData {
  final String type;
  final String license;
  final List<dynamic> requestProperties;

  DRMData({
    required this.type,
    required this.license,
    required this.requestProperties,
  });

  factory DRMData.fromJson(Map<String, dynamic> json) {
    return DRMData(
      type: json['type'] ?? '',
      license: json['license'] ?? '',
      requestProperties: json['request_properties'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'license': license,
    'request_properties': requestProperties,
  };
}
