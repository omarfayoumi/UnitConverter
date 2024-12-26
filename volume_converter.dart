import 'package:flutter/material.dart';

class VolumeConverter extends StatefulWidget {
  @override
  _VolumeConverterState createState() => _VolumeConverterState();
}

class _VolumeConverterState extends State<VolumeConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Cubic Meter';
  String targetUnit = 'Cubic Meter';
  final List<String> units = ['Cubic Meter', 'Liter', 'Milliliter', 'Gallon'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volume Converter'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputField(),
            SizedBox(height: 30),
            _buildUnitSelectors(),
            SizedBox(height: 30),
            _buildConvertButton(),
            SizedBox(height: 30),
            _buildResultDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter Volume',
        border: OutlineInputBorder(),
        hintText: 'e.g. 1.5',
      ),
      onChanged: (value) {
        setState(() {
          inputValue = double.tryParse(value) ?? 0.0;
        });
      },
    );
  }

  Widget _buildUnitSelectors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDropdownButton(sourceUnit, (value) {
          setState(() {
            sourceUnit = value!;
          });
        }),
        Text('to', style: TextStyle(fontSize: 20)),
        _buildDropdownButton(targetUnit, (value) {
          setState(() {
            targetUnit = value!;
          });
        }),
      ],
    );
  }

  Widget _buildDropdownButton(String currentValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: onChanged,
      items: units.map((unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: () {
        convertVolume();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Text(
      'Result: ${outputValue.toStringAsFixed(2)} $targetUnit',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  void convertVolume() {
    double inputValueInCubicMeter = inputValue;

    switch (sourceUnit) {
      case 'Liter':
        inputValueInCubicMeter = inputValue / 1000.0;
        break;
      case 'Milliliter':
        inputValueInCubicMeter = inputValue / 1e6;
        break;
      case 'Gallon':
        inputValueInCubicMeter = inputValue * 0.00378541;
        break;
    }

    switch (targetUnit) {
      case 'Cubic Meter':
        outputValue = inputValueInCubicMeter;
        break;
      case 'Liter':
        outputValue = inputValueInCubicMeter * 1000.0;
        break;
      case 'Milliliter':
        outputValue = inputValueInCubicMeter * 1e6;
        break;
      case 'Gallon':
        outputValue = inputValueInCubicMeter / 0.00378541;
        break;
    }

    setState(() {});
  }
}