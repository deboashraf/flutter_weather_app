import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${weather.cityName}, ${weather.country}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Image.network(
              weather.iconUrl,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            Text(
              "${weather.temperature}°C",
              style: const TextStyle(
                fontSize: 42, // ✅ أكبر بوضوح
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weather.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text("Wind: ${weather.windSpeed} kph"),
            Text("Humidity: ${weather.humidity}%"),
          ],
        ),
      ),
    );
  }
}