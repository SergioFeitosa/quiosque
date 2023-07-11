import 'package:flutter/material.dart';

class DeliveryAppbarFull extends AppBar {
  DeliveryAppbarFull({
    super.key,
    double elevation = 1,
    context,
    bag,
    url,
  }) : super(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/home', arguments: {
                'bag': bag,
              });
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushNamed(url, arguments: {
                  'bag': bag,
                });
              },
              child: Image.asset(
                "assets/images/chapeudecouro02.png",
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          centerTitle: true,
        );
}
