import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_bloc/bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';
import '../Data/data.dart';
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherState(status: WeatherStatus.initial)) {
    on<FetchWeatherByCity>((event, emit) async {
      emit(const WeatherState(status: WeatherStatus.loading));
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByCityName(event.cityName);
        emit(WeatherState(status: WeatherStatus.success,weather: weather));
      } catch (e) {
        emit(const WeatherState(status: WeatherStatus.error));
      }
    });
    on<FetchWeather>((event, emit) async {
      emit(const WeatherState(status: WeatherStatus.loading));
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude, event.position.longitude,
        );
        emit(WeatherState(weather:weather, status : WeatherStatus.success));
      } catch (e) {
        emit(const WeatherState(status: WeatherStatus.error));
      }
    });
    // Add handler for ResetWeatherState event
    on<ResetWeatherState>((event, emit) {
      emit(const WeatherState(status: WeatherStatus.initial));
    });
  }
}