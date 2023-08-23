import 'package:flutter/material.dart';
import 'package:car/models/car.dart';
import 'package:car/db/data.dart';
import 'Cardetailpage.dart';

class EditCarPage extends StatelessWidget {
  final Car car;

  EditCarPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Car'),
        backgroundColor: const Color.fromARGB(255, 152, 54, 244),
      ),
      body: EditCarForm(car: car),
      backgroundColor: Color.fromARGB(255, 218, 185, 248),
    );
  }
}

class EditCarForm extends StatelessWidget {
  final Car car;

  EditCarForm({required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            // initialValue: car.name,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Model',
            ),
            // initialValue: car.model.toString(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Color',
            ),
            // initialValue: car.color,
          ),
          SizedBox(height: 16),
          MaterialButton(
            color: Color.fromARGB(255, 163, 54, 242),
            onPressed: () {
              final updatedCar = Car(
                image: car.image,
                name: car.name,
                model: int.parse(car.model.toString()),
                color: car.color,
              );

              // Update the car in Hive
              CarRepository().updateCar(updatedCar);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CarDetailPage(car: updatedCar),
                ),
              );
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
