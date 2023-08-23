import 'package:hive/hive.dart';
import 'package:car/models/car.dart';

class CarRepository {
  final Box<Car> _carBox = Hive.box<Car>('carbox');

  List<Car> getAllCar() {
    return _carBox.values.toList();
  }

  void addCar(Car car) {
    _carBox.add(car);
  }

  void updateCar(Car updatedCar) {
  
    final carIndex = _carBox.values.toList().indexWhere((car) => car == car);
    if (carIndex != -1) {
      _carBox.putAt(carIndex, updatedCar);
 
    }
  }

  void deleteCar(int index) {
    _carBox.deleteAt(index);
  }
}
