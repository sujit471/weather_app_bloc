import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
sealed class WeatherState extends Equatable{
  const WeatherState();
  @override
  List<Object> get props=>[];
}
class WeatherInitial extends WeatherState {
}
class Weatherloading  extends WeatherState {}
final class WeatherBlocFailure extends WeatherState {}
class WeatherError extends WeatherState{
  final String message ;
  const WeatherError(this.message);
}
class WeatherSuccess extends WeatherState{
   final Weather weather;
  const WeatherSuccess (this.weather);
  @override
  List<Object> get props =>[weather];
}
class WeatherFailure extends WeatherState{

}
class ResetWeather extends WeatherState{

}