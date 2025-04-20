import 'package:awesome_video_player/awesome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tsalul_url_player/core/utils/player_utils.dart';
import 'package:tsalul_url_player/data/models/stream_model.dart';
import 'package:tsalul_url_player/presentation/widgets/custom_full_controls.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<StreamQuality> streams;
  final bool fullScreenByDefault;

  const VideoPlayerScreen({
    super.key,
    required this.streams,
    this.fullScreenByDefault = false,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late List<StreamQuality> streamList;
  late StreamQuality current;

  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });

    initPlayer();
  }

  initPlayer() {
    streamList = widget.streams;
    if (streamList.isNotEmpty) {
      current = streamList.first;
    }
    current = streamList.first;
    BetterPlayerControlsConfiguration controlsConfiguration =
        BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,

          customControlsBuilder: (controller, onPlayerVisibilityChanged) {
            return CustomFullControls(
              controller: controller,
              qualities: streamList,
              onControlsVisibilityChanged: onPlayerVisibilityChanged,
            );
          },
        );

    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
          autoDispose: true,
          autoPlay: true,
          fullScreenByDefault: widget.fullScreenByDefault,
          deviceOrientationsOnFullScreen: [],
          controlsConfiguration: controlsConfiguration,
        );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      current.url,
      videoFormat: detectVideoFormat(current.url),
      drmConfiguration:
          current.drm?.license != null
              ? BetterPlayerDrmConfiguration(
                drmType: getDrmType(current.drm?.type ?? 'clearkey'),
                clearKey: current.drm?.license,
              )
              : null,
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        bufferForPlaybackAfterRebufferMs: 5000,
      ),
    );
    _controller = BetterPlayerController(betterPlayerConfiguration);
    _controller.setupDataSource(dataSource);
  }

  @override
  void dispose() {
    _controller.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BetterPlayer(controller: _controller),
    );
  }
}
