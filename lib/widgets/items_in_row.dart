import 'package:flutter/material.dart';
import 'package:weather_app_bloc/constants/custom_text.dart';

class ItemsInRow extends StatelessWidget {
  final String? image;
  final String? time;
  final String ? text;

  const ItemsInRow({
    Key? key,
    this.image,
    this.time, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (image != null)
          Image.asset(
            image!,
            height: 60,
          ),
        const SizedBox(width: 5), // Replaces Width(5)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (time != null)
              Text(
                time!,
                style: CustomText.header()
              ),
            const SizedBox(height: 5), // Replaces Height(5)
            if(text !=null)
             Text(
              text!,
              style: CustomText.subheader(), // Customize as per your needs
            ),
          ],
        ),
      ],
    );
  }
}
