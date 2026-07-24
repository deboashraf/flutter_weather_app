import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF50C9C3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// 🔍 Search Field
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        provider.featchWeather(_controller.text);
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    provider.featchWeather(value);
                  },
                ),

                const SizedBox(height: 30),

                /// ✅ Animated Content
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _buildContent(provider),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(WeatherProvider provider) {
    if (provider.isLoading) {
      return const CircularProgressIndicator(
        key: ValueKey("loading"),
        color: Colors.white,
      );
    }

    if (provider.errorrMessage != null) {
      return Text(
        provider.errorrMessage!,
        key: const ValueKey("error"),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      );
    }

    if (provider.weather != null) {
      return WeatherCard(
        key: const ValueKey("weather"),
        weather: provider.weather!,
      );
    }

    return const Text(
      "Search for a city to see the weather",
      key: ValueKey("empty"),
      style: TextStyle(
        color: Colors.white70,
        fontSize: 18,
      ),
    );
  }
}