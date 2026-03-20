import 'package:dvt_weather_app/bloc/index.dart';
import 'package:dvt_weather_app/model/forecast_response.dart';
import 'package:dvt_weather_app/utils/ext.dart';
import 'package:dvt_weather_app/utils/helper_func.dart';
import 'package:dvt_weather_app/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CurrentWeatherBloc>().add(const FetchCurrentWeather());
        },
        child: BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
          listener: (context, state) async {
            if (state is CurrentWeatherLoaded && state.firstRun) {
              await buildShowHelperDialog(context);
            }
          },
          builder: (context, state) {
            if (state is CurrentWeatherLoaded) {
              return _WeatherComponent(state: state);
            }
            if (state is CurrentWeatherFailed) {
              return _WeatherFailedComponent(errorState: state);
            }
            if (state is CurrentWeatherInProgress &&
                state.currentWeatherResponse != null &&
                state.forecastResponse != null) {
              return _WeatherComponent(state: state);
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: const LinearProgressIndicator(minHeight: 8),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Fetching...',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WeatherComponent extends StatefulWidget {
  final CurrentWeatherState state;

  const _WeatherComponent({required this.state});

  @override
  State<_WeatherComponent> createState() => __WeatherComponentState();
}

class __WeatherComponentState extends State<_WeatherComponent> {
  static const _degreeSymbol = '\u00B0';

  String _url = Util.sunnyURL;
  Color _color = Util.SUNNY;

  @override
  void initState() {
    super.initState();
    _backgroundChange();
  }

  void _backgroundChange() {
    final weather = widget.state.currentWeatherResponse!.weather;
    setState(() {
      if (weather.isNotEmpty) {
        _url = weather.first.main.produceUrl();
        _color = weather.first.main.produceColor();
      }
    });
  }

  Widget _produceIcon(Weather weather) {
    if (weather.main.toLowerCase().contains('cloud')) {
      return IconButton(
        icon: Image.asset('assets/symbols/partlysunny.png'),
        onPressed: () {},
      );
    }
    if (weather.main.toLowerCase().contains('rain')) {
      return IconButton(
        icon: Image.asset('assets/symbols/rain.png'),
        onPressed: () {},
      );
    }
    return IconButton(
      icon: Image.asset('assets/symbols/clear.png'),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherResponse = widget.state.currentWeatherResponse!;
    final groupedForecasts = widget.state.formattedData.entries.toList();

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 1.02,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      _url,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(1.0, -0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          await buildShowHelperDialog(context);
                        },
                        child: const Icon(
                          Icons.help,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${weatherResponse.main.temp.floor()} $_degreeSymbol',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 12),
                        if (weatherResponse.weather.isNotEmpty)
                          Text(
                            weatherResponse.weather.first.main,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        const SizedBox(height: 12),
                        if (widget.state is CurrentWeatherInProgress)
                          const CircularProgressIndicator.adaptive(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: _color,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _TemperatureColumn(
                            label: 'Min',
                            temperature:
                                '${weatherResponse.main.tempMin.floor()} $_degreeSymbol',
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          _TemperatureColumn(
                            label: 'Current',
                            temperature:
                                '${weatherResponse.main.temp.floor()} $_degreeSymbol',
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          _TemperatureColumn(
                            label: 'Max',
                            temperature:
                                '${weatherResponse.main.tempMax.floor()} $_degreeSymbol',
                            crossAxisAlignment: CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 4,
                      endIndent: 4,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListView.separated(
                          itemCount: groupedForecasts.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          itemBuilder: (context, index) {
                            final dayEntries = groupedForecasts[index].value;
                            return ExpansionTile(
                              leading: Text(
                                DateFormat('EEEE').format(
                                  DateTime.parse(dayEntries.first.dtTxt),
                                ),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              title:
                                  _produceIcon(dayEntries.first.weather.first),
                              trailing: Text(
                                '${dayEntries.first.main.temp.floor()} $_degreeSymbol ',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: dayEntries.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, itemIndex) {
                                    final entry = dayEntries[itemIndex];
                                    return ListTile(
                                      leading: Text(
                                        DateFormat('h:mm a').format(
                                          DateTime.parse(entry.dtTxt),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      title: _produceIcon(entry.weather.first),
                                      trailing: Text(
                                        '${entry.main.temp.floor()} $_degreeSymbol ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemperatureColumn extends StatelessWidget {
  final String label;
  final String temperature;
  final CrossAxisAlignment crossAxisAlignment;

  const _TemperatureColumn({
    required this.label,
    required this.temperature,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          temperature,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style:
              Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 2),
        ),
      ],
    );
  }
}

class _WeatherFailedComponent extends StatelessWidget {
  final CurrentWeatherFailed errorState;

  const _WeatherFailedComponent({required this.errorState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            size: 64,
            color: Colors.black54,
          ),
          const SizedBox(height: 12),
          Text(
            errorState.message,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
