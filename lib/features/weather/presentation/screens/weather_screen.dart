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
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("Weather App")),
      body: Container(
        decoration: BoxDecoration(
          gradient: _getWeatherGradient(provider.weather?.description),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
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
                        provider.fetchWeather(_controller.text);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    provider.fetchWeather(value);
                    FocusScope.of(context).unfocus();
                  },
                ),

                const SizedBox(height: 40),

                /// ✅ Animated Content
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _buildContent(provider),
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
      return const Center(
        key: ValueKey("loading"),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (provider.errorMessage != null) {
      return Center(
        key: const ValueKey("error"),
        child: Text(
          provider.errorMessage!,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (provider.weather != null) {
      return WeatherCard(
        key: const ValueKey("weather"),
        weather: provider.weather!,
      );
    }

    return const Center(
      key: ValueKey("empty"),
      child: Text(
        "Search for a city to see the weather",
        style: TextStyle(color: Colors.white70, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 🎨 Dynamic Gradient حسب حالة الطقس
  LinearGradient _getWeatherGradient(String? condition) {
    if (condition == null) {
      return const LinearGradient(
        colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    final lower = condition.toLowerCase();

    if (lower.contains("sunny") || lower.contains("clear")) {
      return const LinearGradient(
        colors: [Color(0xFFFFB75E), Color(0xFFED8F03)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (lower.contains("cloud")) {
      return const LinearGradient(
        colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (lower.contains("rain")) {
      return const LinearGradient(
        colors: [Color(0xFF314755), Color(0xFF26A0DA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (lower.contains("snow")) {
      return const LinearGradient(
        colors: [Color(0xFFE6DADA), Color(0xFF274046)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return const LinearGradient(
      colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
