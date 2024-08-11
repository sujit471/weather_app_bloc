import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_bloc/bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';
import '../Data/data.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(Weatherloading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
