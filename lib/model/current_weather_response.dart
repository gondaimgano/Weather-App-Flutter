class CurrentWeatherResponse {
  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String name;
  final int? cod;

  CurrentWeatherResponse({
    this.coord,
    this.weather = const [],
    this.base = '',
    required this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name = '',
    this.cod,
  });

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      coord: json['coord'] != null
          ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
          : null,
      weather: (json['weather'] as List<dynamic>? ?? const [])
          .map((value) => Weather.fromJson(value as Map<String, dynamic>))
          .toList(),
      base: json['base']?.toString() ?? '',
      main: Main.fromJson((json['main'] as Map<String, dynamic>? ?? const {})),
      visibility: (json['visibility'] as num?)?.toInt(),
      wind: json['wind'] != null
          ? Wind.fromJson(json['wind'] as Map<String, dynamic>)
          : null,
      clouds: json['clouds'] != null
          ? Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
          : null,
      dt: (json['dt'] as num?)?.toInt(),
      sys: json['sys'] != null
          ? Sys.fromJson(json['sys'] as Map<String, dynamic>)
          : null,
      timezone: (json['timezone'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name']?.toString() ?? '',
      cod: (json['cod'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord?.toJson(),
      'weather': weather.map((value) => value.toJson()).toList(),
      'base': base,
      'main': main.toJson(),
      'visibility': visibility,
      'wind': wind?.toJson(),
      'clouds': clouds?.toJson(),
      'dt': dt,
      'sys': sys?.toJson(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }
}

class Coord {
  final double? lon;
  final double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: (json['lon'] as num?)?.toDouble(),
        lat: (json['lat'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}

class Weather {
  final int? id;
  final String main;
  final String description;
  final String icon;

  Weather({
    this.id,
    this.main = '',
    this.description = '',
    this.icon = '',
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: (json['id'] as num?)?.toInt(),
        main: json['main']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        icon: json['icon']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Main {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num humidity;

  Main({
    this.temp = 0,
    this.feelsLike = 0,
    this.tempMin = 0,
    this.tempMax = 0,
    this.pressure = 0,
    this.humidity = 0,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'] as num? ?? 0,
        feelsLike: json['feels_like'] as num? ?? 0,
        tempMin: json['temp_min'] as num? ?? 0,
        tempMax: json['temp_max'] as num? ?? 0,
        pressure: json['pressure'] as num? ?? 0,
        humidity: json['humidity'] as num? ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
    };
  }
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] as num?)?.toDouble(),
        deg: (json['deg'] as num?)?.toInt(),
        gust: (json['gust'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Clouds {
  final int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: (json['all'] as num?)?.toInt(),
      );

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class Sys {
  final int? type;
  final int? id;
  final String country;
  final int? sunrise;
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country = '',
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: (json['type'] as num?)?.toInt(),
        id: (json['id'] as num?)?.toInt(),
        country: json['country']?.toString() ?? '',
        sunrise: (json['sunrise'] as num?)?.toInt(),
        sunset: (json['sunset'] as num?)?.toInt(),
      );

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
