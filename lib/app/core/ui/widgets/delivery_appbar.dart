import 'package:flutter/material.dart';

class DeliveryAppbar extends AppBar {
  DeliveryAppbar({
    super.key,
    double elevation = 1,
  }) : super(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: elevation,
          title: Image.asset(
            'assets/images/chapeudecouro02.png',
            width: 100,
            fit: BoxFit.cover,
          ),
        );
}
