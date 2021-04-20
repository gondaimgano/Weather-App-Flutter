import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:dvt_weather_app/bloc/index.dart';
import 'package:dvt_weather_app/pages/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DVT Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: RegisterService(),
    );
  }
}

class RegisterService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherApiService.create(),
      child: RegisterRepository(),
    );
  }
}

class RegisterRepository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherRepository(
        context.read(),
      ),
      child: RegisterBlocs(),
    );
  }
}

class RegisterBlocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CurrentWeatherBloc(context.read())
              ..add(
                FetchCurrentWeather(),
              )),
      ],
      child: DVTWeatherApp(),
    );
  }
}

class DVTWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
