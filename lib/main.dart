import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_event.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_state.dart';
import 'services/authentication.dart';
import 'Screens/home_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions( apiKey: 'AIzaSyCQWSMh_VZ4wUQQ5oqGfoSFCgBrF8OpZPs',
        appId: '1:606114221907:android:a871018835c874957b1ba6', messagingSenderId: 'messagingSenderId',
        projectId: 'fir-login-b234a'
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authService: AuthService()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state is AuthenticationSuccess) {
              Position position = await _determinePosition();
              context.read<WeatherBloc>().add(FetchWeather(position));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthenticationInitial || state is AuthenticationLoadingState) {
              return const LoginScreen();
            } else if (state is AuthenticationError) {
              return const LoginScreen();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

/// Determine the current position of the device.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}