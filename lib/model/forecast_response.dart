class ForecastResponse {
  final String cod;
  final int? message;
  final int? cnt;
  final List<Item> list;
  final City? city;

  ForecastResponse({
    this.cod = '',
    this.message,
    this.cnt,
    this.list = const [],
    this.city,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    return ForecastResponse(
      cod: json['cod']?.toString() ?? '',
      message: (json['message'] as num?)?.toInt(),
      cnt: (json['cnt'] as num?)?.toInt(),
      list: (json['list'] as List<dynamic>? ?? const [])
          .map((value) => Item.fromJson(value as Map<String, dynamic>))
          .toList(),
      city: json['city'] != null
          ? City.fromJson(json['city'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((value) => value.toJson()).toList(),
      'city': city?.toJson(),
    };
  }
}

class Item {
  final num dt;
  final Main main;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final num visibility;
  final num pop;
  final Sys? sys;
  final String dtTxt;

  Item({
    this.dt = 0,
    required this.main,
    this.weather = const [],
    this.clouds,
    this.wind,
    this.visibility = 0,
    this.pop = 0,
    this.sys,
    this.dtTxt = '',
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        dt: json['dt'] as num? ?? 0,
        main:
            Main.fromJson((json['main'] as Map<String, dynamic>? ?? const {})),
        weather: (json['weather'] as List<dynamic>? ?? const [])
            .map((value) => Weather.fromJson(value as Map<String, dynamic>))
            .toList(),
        clouds: json['clouds'] != null
            ? Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
            : null,
        wind: json['wind'] != null
            ? Wind.fromJson(json['wind'] as Map<String, dynamic>)
            : null,
        visibility: json['visibility'] as num? ?? 0,
        pop: json['pop'] as num? ?? 0,
        sys: json['sys'] != null
            ? Sys.fromJson(json['sys'] as Map<String, dynamic>)
            : null,
        dtTxt: json['dt_txt']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((value) => value.toJson()).toList(),
      'clouds': clouds?.toJson(),
      'wind': wind?.toJson(),
      'visibility': visibility,
      'pop': pop,
      'sys': sys?.toJson(),
      'dt_txt': dtTxt,
    };
  }
}

class Main {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num seaLevel;
  final num grndLevel;
  final num humidity;
  final num tempKf;

  Main({
    this.temp = 0,
    this.feelsLike = 0,
    this.tempMin = 0,
    this.tempMax = 0,
    this.pressure = 0,
    this.seaLevel = 0,
    this.grndLevel = 0,
    this.humidity = 0,
    this.tempKf = 0,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'] as num? ?? 0,
        feelsLike: json['feels_like'] as num? ?? 0,
        tempMin: json['temp_min'] as num? ?? 0,
        tempMax: json['temp_max'] as num? ?? 0,
        pressure: json['pressure'] as num? ?? 0,
        seaLevel: json['sea_level'] as num? ?? 0,
        grndLevel: json['grnd_level'] as num? ?? 0,
        humidity: json['humidity'] as num? ?? 0,
        tempKf: json['temp_kf'] as num? ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
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

class Clouds {
  final num all;

  Clouds({this.all = 0});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'] as num? ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class Wind {
  final num speed;
  final num deg;
  final num gust;

  Wind({
    this.speed = 0,
    this.deg = 0,
    this.gust = 0,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'] as num? ?? 0,
        deg: json['deg'] as num? ?? 0,
        gust: json['gust'] as num? ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Sys {
  final String pod;

  Sys({this.pod = ''});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'pod': pod,
    };
  }
}

class City {
  final int? id;
  final String name;
  final Coord? coord;
  final String country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({
    this.id,
    this.name = '',
    this.coord,
    this.country = '',
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: (json['id'] as num?)?.toInt(),
        name: json['name']?.toString() ?? '',
        coord: json['coord'] != null
            ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
            : null,
        country: json['country']?.toString() ?? '',
        population: (json['population'] as num?)?.toInt(),
        timezone: (json['timezone'] as num?)?.toInt(),
        sunrise: (json['sunrise'] as num?)?.toInt(),
        sunset: (json['sunset'] as num?)?.toInt(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord?.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
