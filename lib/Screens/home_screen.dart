import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';
import 'package:weather_app_bloc/widgets/weather_card.dart';
import '../Constants/space.dart';
import '../bloc/weather_event.dart';
import '../constants/custom_text.dart';
import '../widgets/items_in_row.dart';
import '../widgets/weather_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _cityController = TextEditingController();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(
      backgroundColor: Colors.black,
appBar: PreferredSize( preferredSize: const Size.fromHeight(5),
    child: AppBar(
      backgroundColor: Colors.black,
    )),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                color: Colors.orangeAccent.withOpacity(0.3),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherInitial) {
                          return  Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DefaultTextStyle(
                                  style: const TextStyle(

                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontFamily: 'Agne',
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText('Welcome Back'),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Lottie.asset(
                                    'assets/weather.json',  // Path to your Lottie animation
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is WeatherLoading) {
                          return Column(
                            children: [
                              Center(
                                child: Lottie.asset(
                                  'assets/searching.json',
                                  height: 200,
                                ),
                              ),
                              Height(90),
                             DefaultTextStyle(
                              style: const TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontFamily: 'Agne',
                              ),
                              child: AnimatedTextKit(
                              animatedTexts: [
                              TypewriterAnimatedText('Searching.....'),
                              ],
                              ),
                              ),
                            ],
                          );
                        } else if (state is WeatherSuccess) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple.withOpacity(0.3),
                                      Colors.orangeAccent.withOpacity(0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Enter city name',
                                    hintStyle: const TextStyle(color: Colors.white54),
                                    labelStyle: const TextStyle(color: Colors.white54),
                                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.white),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                  ),
                                  onSubmitted: (cityName) {
                                    context
                                        .read<WeatherBloc>()
                                        .add(FetchWeatherByCity(cityName));
                                  },
                                ),
                              ),
                              Height(30),
                              Text(
                                'Location 📍: ${state.weather.areaName}',
                                style: CustomText.subheader(),
                              ),
                              Height(10),
                              Center(
                                  child: getWeatherIcon(
                                      state.weather.weatherConditionCode!)),
                              Height(10),
                              Center(
                                child: Text(
                                  '${state.weather.temperature}',
                                  style: CustomText.header(),
                                ),
                              ),
                              Height(10),
                              Center(
                                child: Text(
                                  '${state.weather.weatherMain}',
                                  style: CustomText.header(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  formattedDate,
                                  style: CustomText.subheader(),
                                ),
                              ),
                              Height(100),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemsInRow(
                                    text: formatTime(state.weather.sunrise!),
                                    image: 'assets/11.png',
                                    time: 'Sunrise',
                                  ),
                                  ItemsInRow(
                                    text: formatTime(state.weather.sunset!),
                                    image: 'assets/12.png',
                                    time: 'Sunset',
                                  ),
                                ],
                              ),
                              Height(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemsInRow(
                                    text: '${state.weather.tempMax}',
                                    image: 'assets/13.png',
                                    time: 'Max Temp',
                                  ),
                                  ItemsInRow(
                                    text: '${state.weather.tempMin}',
                                    image: 'assets/14.png',
                                    time: 'Min temp',
                                  ),
                                ],
                              ),
                              Height(20),
                               Row(
                                 children: [
                                   WeatherCard(state: '${state.weather.humidity} g/kg',
                                     name: 'humidity',
                                     icon: Icons.cloud,
                                     color: Colors.grey,
                                     size: 50,
                                   ),
                                  Width(20),
                                   WeatherCard(state: '${state.weather.tempFeelsLike}',
                                     name: 'Feels Like',
                                     icon: Icons.sunny,
                                     color: Colors.orange,
                                     size: 40,
                                   ),
                                 ],
                               ),
                              Height(20),
                              Row(
                                children: [
                                  WeatherCard(state: '${state.weather.pressure} Pa',
                                    name: 'Pressure',
                                    icon: Icons.access_time_outlined,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  Width(20),
                                  WeatherCard(state: '${state.weather.windSpeed} km/hr',
                                    name: 'Wind',
                                    icon: Icons.flag_rounded,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ],
                              ),
                              Height(20),
                              Row(
                                children: [
                                  WeatherCard(state: '${state.weather.rainLast3Hours} ',
                                    name: 'Rain Last 3 Hours',
                                    icon: Icons.grain,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  Width(20),
                                  WeatherCard(state: '${state.weather.cloudiness} oktas',
                                    name: 'Cloudiness',
                                    icon: Icons.flag_rounded,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return  Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple.withOpacity(0.3),
                                      Colors.orangeAccent.withOpacity(0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Enter city name',
                                    hintStyle: const TextStyle(color: Colors.white54),
                                    labelStyle: const TextStyle(color: Colors.white54),
                                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Colors.white),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                  ),
                                  onSubmitted: (cityName) {
                                    context
                                        .read<WeatherBloc>()
                                        .add(FetchWeatherByCity(cityName));
                                  },
                                ),
                              ),
                              Height(20),
                              Text("City not Found ",style: CustomText.header(),),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
