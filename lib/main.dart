import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tsalul_url_player/core/services/service_locator.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';
import 'package:tsalul_url_player/core/utils/receive_intent.dart';
import 'package:tsalul_url_player/data/models/stream_model.dart';
import 'package:tsalul_url_player/presentation/bloc/cubit/theme_cubit.dart';
import 'package:tsalul_url_player/presentation/bloc/link_bloc/link_bloc.dart';
import 'package:tsalul_url_player/presentation/screens/home_screen.dart';
import 'package:tsalul_url_player/presentation/screens/splash_screen.dart';
import 'package:tsalul_url_player/presentation/screens/video_player_screen.dart';
// import 'package:tsalul_url_player/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  await initServiceLocator();
  final streamList = await receiveIntentQualities();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LinkBloc>(create: (_) => sl<LinkBloc>()..add(LoadLinks())),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
      ],
      child: MyApp(streamQualities: streamList),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<StreamQuality> streamQualities;

  const MyApp({super.key, required this.streamQualities});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeData =
            state is ThemeLoaded ? state.themeData : AppTheme.lightTheme;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tsalul URL Player',
          theme: themeData,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              state is ThemeLoaded && state.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home:
              streamQualities.isNotEmpty
                  ? VideoPlayerScreen(streams: streamQualities)
                  : const SplashScreen(),
          routes: {'/home': (context) => HomeScreen()},
        );
      },
    );
  }
}
        // fontFamily: 'Poppins',

// i want home screen page it is has app bar without background color 
// and elevetion and in it put TUP center 

// in body i want show list items 
// in beautiful design 
