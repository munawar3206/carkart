import 'dart:io';
import 'package:car/searchfunction.dart';
import 'package:flutter/material.dart';
import 'AddCar.dart';
import 'Cardetailpage.dart';
import 'db/data.dart';
import 'editcar.dart';
import 'models/car.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarRepository carRepository = CarRepository();
  List<Car> cars = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    cars = carRepository.getAllCar();
  }

  void searchCars(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Car> filterCars() {
    return cars.where((car) {
      final nameLower = car.name.toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Car> filteredCars = filterCars();

    return Scaffold(
      appBar: AppBar(
        title: Text("carKart"),
        backgroundColor: Color.fromARGB(255, 151, 60, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: (cars, searchCars),
              );
              if (query != null) {
                searchCars(query);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredCars.length,
        itemBuilder: (context, index) {
          final Car car = filteredCars[index];

          return Container(
            height: 70,
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 153, 74, 255),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.8,
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  backgroundImage:
                      car.image != null ? FileImage(File(car.image)) : null,
                  child: car.image == null ? Icon(Icons.image, size: 30) : null,
                ),
                title: Text(car.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditCarPage(car: car)),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 202, 174, 255),
                              title: Text('Confirm Deletion'),
                              content: Text(
                                  'Are you sure you want to delete this car?'),
                              elevation: 25,
                              shadowColor: Color.fromARGB(255, 255, 0, 0),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    int carIndex = cars.indexOf(car);
                                    carRepository.deleteCar(carIndex);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarDetailPage(car: car)),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 157, 68, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addcar()),
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 210, 194, 239),
    );
  }
}
