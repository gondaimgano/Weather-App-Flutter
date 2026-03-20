import 'package:dvt_weather_app/bloc/index.dart';
import 'package:dvt_weather_app/pages/index.dart';
import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
        background: Colors.deepPurple,
      ),
      child: MaterialApp(
        title: 'DVT Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dividerColor: Colors.transparent,
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
        ),
        home: const RegisterServiceWidget(),
      ),
    );
  }
}

class RegisterServiceWidget extends StatelessWidget {
  const RegisterServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherApiService>(
      create: (_) => WeatherApiService.create(),
      child: const RegisterRepositoryWidget(),
    );
  }
}

class RegisterRepositoryWidget extends StatelessWidget {
  const RegisterRepositoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherRepository>(
      create: (_) => WeatherRepository(context.read<WeatherApiService>()),
      child: const RegisterBusinessLogicWidget(),
    );
  }
}

class RegisterBusinessLogicWidget extends StatelessWidget {
  const RegisterBusinessLogicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentWeatherBloc>(
          create: (_) => CurrentWeatherBloc(context.read<WeatherRepository>())
            ..add(const FetchCurrentWeather()),
        ),
      ],
      child: const DVTWeatherApp(),
    );
  }
}

class DVTWeatherApp extends StatelessWidget {
  const DVTWeatherApp({super.key});

  @override
  Widget build(BuildContext context) => const HomePage();
}
