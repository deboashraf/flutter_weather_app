import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/weather/data/datasource/weather_remote_datasource.dart';
import 'features/weather/data/repository/weather_repository.dart';
import 'features/weather/presentation/provider/weather_provider.dart';
import 'features/weather/presentation/screens/weather_screen.dart';

void main() {
  final remoteDataSource = WeatherRemoteDatasource();
  final repository = WeatherRepository(remoteDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WeatherRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        home: const WeatherScreen(),
      ),
    );
  }
}