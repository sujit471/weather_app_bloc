import 'package:flutter/material.dart';
import 'package:weather_app_bloc/Constants/space.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, this.state, this.name, this.icon, this.color, this.size});
final  Color? color;
  final String? state;
  final String? name;
  final IconData? icon;
  final double? size ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text at the start
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (name != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    name!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              Height(10),
              if (state != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    state!,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
            ],
          ),
           Positioned(
            bottom: 8,
            right: 8,
            child: Icon(icon,color: color,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}
