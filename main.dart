import 'package:flutter/material.dart';
import 'volume_converter.dart';
import 'length_converter.dart';
import 'area_converter.dart';
import 'mass_converter.dart';
import 'speed_converter.dart';
import 'temperature_converter.dart';
import 'time_converter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildConverterTile(context, 'Volume Converter', VolumeConverter()),
            _buildConverterTile(context, 'Length Converter', LengthConverter()),
            _buildConverterTile(context, 'Area Converter', AreaConverter()),
            _buildConverterTile(context, 'Mass Converter', MassConverter()),
            _buildConverterTile(context, 'Speed Converter', SpeedConverter()),
            _buildConverterTile(context, 'Temperature Converter', TemperatureConverter()),
            _buildConverterTile(context, 'Time Converter', TimeConverter()),
          ],
        ),
      ),
    );
  }

  Widget _buildConverterTile(BuildContext context, String title, Widget converter) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => converter),
          );
        },
      ),
    );
  }
}