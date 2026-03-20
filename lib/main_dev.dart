import 'package:dvt_weather_app/bloc/index.dart';
import 'package:dvt_weather_app/pages/index.dart';
import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DVT Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const RegisterService(),
    );
  }
}

class RegisterService extends StatelessWidget {
  const RegisterService({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherApiService>(
      create: (_) => WeatherApiService.create(),
      child: const RegisterRepository(),
    );
  }
}

class RegisterRepository extends StatelessWidget {
  const RegisterRepository({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<WeatherRepository>(
      create: (_) => WeatherRepository(context.read<WeatherApiService>()),
      child: const RegisterBlocs(),
    );
  }
}

class RegisterBlocs extends StatelessWidget {
  const RegisterBlocs({super.key});

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
