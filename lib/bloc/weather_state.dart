import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

// sealed class WeatherState extends Equatable {
//   const WeatherState();
//
//   @override
//   List<Object> get props => [];
// }

// class WeatherInitial extends WeatherState {}
//
// class WeatherLoading extends WeatherState {}
//
// class WeatherError extends WeatherState {
//   final String message;
//
//   const WeatherError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class WeatherSuccess extends WeatherState {
//   final Weather weather;
//
//   const WeatherSuccess(this.weather);
//
//   @override
//   List<Object> get props => [weather];
// }
//
// class WeatherFailure extadends WeatherState {}

enum WeatherStatus {
 initial ,
  loading ,
  error ,
  success

}

class WeatherState extends Equatable{
final WeatherStatus status ;
final Weather ?weather ;
final String  ? message ;
const  WeatherState({
  required this.status,
this.weather ,
  this.message
});
// factory WeatherState.initial() {
//   return const WeatherState._(status: WeatherStatus.initial, weather:null, message: '' );
// }
// A single factory constructor to handle all states
  // save the memory on  no creating the same instances again and again
// const WeatherState (this.status, this.weather, this.message, {});
// factory WeatherState({
//   required WeatherStatus status,
//   Weather? weather,
//   String? message,
// }) {
//   return WeatherState._(
//     status: status,
//     weather: weather,
//     message: message,
//   );
// }
WeatherState copyWith({
WeatherStatus ? status ,
  Weather ? weather ,
  String ?  message,
})
{
  return WeatherState(status: status ?? this.status , weather : weather ?? this.weather, message: message ?? this.message );

}
@override
List<Object?> get props => [status, weather , message];
@override
  String toString(){
  return 'WeatherState {status : $status , message : $message,weather : $weather }';
}
}
