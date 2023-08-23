
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Cardetailpage.dart';
import 'db/data.dart';
import 'models/car.dart';

class Addcar extends StatefulWidget {
  @override
  _AddcarState createState() => _AddcarState();
}

class _AddcarState extends State<Addcar> {
  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final CarRepository carRepository = CarRepository();

  // images function
  final ImagePicker imagePicker = ImagePicker();
  PickedFile? pickedImage;

  Future<void> _pickImage() async {
    final picked = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 188, 54, 255),
        title: Text('Add Car'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialButton(
             color:Color.fromARGB(255, 163, 54, 242),
              onPressed: _pickImage,
              child: Text("Add Image"),
            ),
            pickedImage != null
                ? Image.file(
                    File(pickedImage!.path),
                    width: 100,
                    height: 100,
                  )
                : Container(),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: modelController,
              decoration: InputDecoration(
                labelText: 'Model',
              ),
            ),
            TextField(
              controller: colorController,
              decoration: InputDecoration(
                labelText: 'Color',
              ),
            ),
            SizedBox(height: 16),
            MaterialButton(
             color:Color.fromARGB(255, 163, 54, 242),
              onPressed: () {
                final Car newCar = Car(
                  image: pickedImage?.path ?? '',
                  name: nameController.text,
                   model: int.parse(modelController.text),
                  color: colorController.text,
                );

                carRepository.addCar(newCar);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CarDetailPage(car: newCar)),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 203, 255),
    );
  }
}
