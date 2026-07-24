class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final String iconUrl;
  final double windSpeed;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.iconUrl,
    required this.windSpeed,
    required this.humidity,
  });

  factory WeatherModel.fromjson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      country: json['location']['country'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      description: json['current']['condition']['text'],
      iconUrl: "https:${json['current']['condition']['icon']}",
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),
      humidity: json['current']['humidity'],
    );
  }
}
