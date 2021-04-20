import 'package:charcode/charcode.dart';
import 'package:dvt_weather_app/model/forecast_response.dart';
import 'package:dvt_weather_app/utils/ext.dart';
import 'package:dvt_weather_app/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dvt_weather_app/bloc/index.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CurrentWeatherBloc>().add(FetchCurrentWeather());
        },
        child: BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
            listener: (context, state) {},
            builder: (context, state) {
          if (state is CurrentWeatherLoaded)
            return _WeatherComponent(state: state);
          if (state is CurrentWeatherFailed)
            return _WeatherFailedComponent(errorState: state);
          if (state is CurrentWeatherInProgress)
            if (state
                      .currentWeatherResponse !=
                  null &&
              state.forecastResponse != null)
            return _WeatherComponent(state: state);
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:[
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.23,
                  child: LinearProgressIndicator(
                    minHeight:8,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
                ),
                SizedBox(height: 12,),
                Text("Fetching...",style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black54),)
              ]

            ),
          );
        }),
      ),
    );
  }
}

class _WeatherFailedComponent extends StatelessWidget {
  final CurrentWeatherFailed errorState;

  const _WeatherFailedComponent({Key key, this.errorState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error,
          size: 64,
          color: Colors.black54,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          errorState.message,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 12,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<CurrentWeatherBloc>().add(FetchCurrentWeather());
            },
            child: Text(
              "Try again",
            )),
      ],
    ));
  }
}

class _WeatherComponent extends StatefulWidget {
  final CurrentWeatherState state;

  const _WeatherComponent({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  __WeatherComponentState createState() => __WeatherComponentState();
}

class __WeatherComponentState extends State<_WeatherComponent> {
  String _url = Util.sunnyURL;
  Color _color = Util.SUNNY;


  _backgroundChange() {
    final weather = widget.state.currentWeatherResponse.weather;
    setState(() {
      if (weather.isNotEmpty) {
        _url = weather[0].main.produceUrl();
        _color = weather[0].main.produceColor();

      }
    });
  }
 Widget _produceIcon(Weather weather){
   // print(weather.main);
   if( weather.main.toLowerCase().contains("cloud"))
     return IconButton(icon: Image.asset("assets/symbols/partlysunny.png"), onPressed: (){});
   if(weather.main.toLowerCase().contains("rain"))
     return IconButton(icon: Image.asset("assets/symbols/rain.png"), onPressed: (){});
   return IconButton(icon: Image.asset("assets/symbols/clear.png"), onPressed: (){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _backgroundChange();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.02,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
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
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.state.currentWeatherResponse.main.temp.floor()} ${String.fromCharCode($deg)}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        if (widget
                            .state.currentWeatherResponse.weather.isNotEmpty)
                          Text(
                            widget.state.currentWeatherResponse.weather[0].main,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        SizedBox(
                          height: 12,
                        ),
                        if (widget.state is CurrentWeatherInProgress)
                          CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: _color, //54717a 57575d
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${widget.state.currentWeatherResponse.main.tempMin.floor()} ${String.fromCharCode($deg)}",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Min",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(letterSpacing: 2)),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${widget.state.currentWeatherResponse.main.temp.floor()} ${String.fromCharCode($deg)}",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Current",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(letterSpacing: 2)),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "${widget.state.currentWeatherResponse.main.tempMax.floor()} ${String.fromCharCode($deg)}",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                height: 4,
                              ),
                              Text("Max",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(letterSpacing: 2)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 4,
                      endIndent: 4,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ListView.separated(
                         // physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.state.formattedData.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          itemBuilder: (context, i) =>
                              ExpansionTile(

                                leading: Text(
                                DateFormat("EEEE").format(DateTime.parse(widget.state.formattedData.values.toList()[i].first.dtTxt)),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                                title:
                            _produceIcon(widget.state.formattedData.values.toList()[i].first.weather.first) ,
                                trailing:  Text(
                                    "${widget.state.formattedData.values.toList()[i].first.main.temp.floor()} ${String.fromCharCode($deg)} ",
                                    style: Theme.of(context).textTheme.headline6),
                                children: [
                                  ListView.builder(
                                    itemCount: widget.state.formattedData.values.toList()[i].length,
                                    itemBuilder: (context,j){
                                    return ListTile(
                                      leading: Text(
                                        DateFormat("h:mm a").format(DateTime.parse(widget.state.formattedData.values.toList()[i][j].dtTxt)),
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      title: _produceIcon(widget.state.formattedData.values.toList()[i][j].weather.first),
                                      trailing:Text(
                                          "${widget.state.formattedData.values.toList()[i][j].main.temp.floor()} ${String.fromCharCode($deg)} ",
                                          style: Theme.of(context).textTheme.subtitle1)

                                    );
                                  },shrinkWrap: true,)
                                ],
                              ),
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
