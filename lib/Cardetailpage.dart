import 'dart:io';

import 'package:car/models/car.dart';

import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  final Car car;

  CarDetailPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 180, 49, 255),
        title: Text('Car Kart'),
      ),
      body: Center(
        child: Container(
          height: 350,
          child: Card(
            color: Color.fromARGB(255, 255, 255, 255),
           
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 25,
            shadowColor: Color.fromARGB(255, 185, 34, 255),
            margin: EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.black,
                   
                  ),
                  SizedBox(height: 20),
                  Text('Name: ${car.name}'),
                  Text('Model: ${car.model}'),
                  Text('Color: ${car.color}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
