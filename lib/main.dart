import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:dvt_weather_app/bloc/index.dart';
import 'package:dvt_weather_app/pages/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        home: RegisterServiceWidget(),
      ),
    );
  }
}

class RegisterServiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherApiService.create(),
      child: RegisterRepositoryWidget(),
    );
  }
}

class RegisterRepositoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherRepository(
        context.read(),
      ),
      child: RegisterBusinessLogicWidget(),
    );
  }
}

class RegisterBusinessLogicWidget extends StatelessWidget {
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
