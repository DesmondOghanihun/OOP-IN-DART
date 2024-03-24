import 'dart:io';

// Interface for shapes
abstract class Shape {
  double calculateArea();
}

// Base class
class Circle implements Shape {
  double radius;

  Circle(this.radius);

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }

  void printArea() {
    print("Circle Area: ${calculateArea()}");
  }
}

// Subclass that extends Circle
class Cylinder extends Circle {
  double height;

  Cylinder(double radius, this.height) : super(radius);

  @override
  double calculateArea() {
    return 2 * super.calculateArea() + 2 * 3.14 * radius * height;
  }

  void printVolume() {
    double volume = 3.14 * radius * radius * height;
    print("Cylinder Volume: $volume");
  }
}

// Method to read data from a file and create objects
List<Cylinder> createCylindersFromFile(String fileName) {
  List<Cylinder> cylinders = [];
  try {
    File file = File(fileName);
    List<String> lines = file.readAsLinesSync();

    for (var line in lines) {
      List<String> values = line.split(',');
      if (values.length == 2) {
        double radius = double.parse(values[0].trim());
        double height = double.parse(values[1].trim());
        Cylinder cylinder = Cylinder(radius, height);
        cylinders.add(cylinder);
      }
    }
  } catch (e) {
    print("Error reading file: $e");
  }
  return cylinders;
}

// Method demonstrating the use of a loop
void printCylinderDetails(List<Cylinder> cylinders) {
  for (var cylinder in cylinders) {
    cylinder.printArea();
    cylinder.printVolume();
    print("-------------");
  }
}

void main() {
  // Create cylinders from file
  List<Cylinder> cylinders = createCylindersFromFile("cylinder_data.txt");

  // Print details
  printCylinderDetails(cylinders);
}