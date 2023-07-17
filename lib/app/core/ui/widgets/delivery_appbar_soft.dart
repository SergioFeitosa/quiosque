import 'package:flutter/material.dart';

class DeliveryAppbarSoft extends AppBar {
  DeliveryAppbarSoft({
    super.key,
    double elevation = 1,
  }) : super(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/chapeudecouro02.png",
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          centerTitle: true,
        );
}
