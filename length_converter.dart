import 'package:flutter/material.dart';

class LengthConverter extends StatefulWidget {
  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Meter';
  String targetUnit = 'Meter';
  final List<String> units = ['Meter', 'Kilometer', 'Mile', 'Yard', 'Foot', 'Inch'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Length Converter'),
        backgroundColor: Colors.blue,
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
        labelText: 'Enter Length',
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
        convertLength();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
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

  void convertLength() {
    double inputValueInMeter = inputValue;

    switch (sourceUnit) {
      case 'Kilometer':
        inputValueInMeter = inputValue * 1000.0;
        break;
      case 'Mile':
        inputValueInMeter = inputValue * 1609.34;
        break;
      case 'Yard':
        inputValueInMeter = inputValue * 0.9144;
        break;
      case 'Foot':
        inputValueInMeter = inputValue * 0.3048;
        break;
      case 'Inch':
        inputValueInMeter = inputValue * 0.0254;
        break;
    }

    switch (targetUnit) {
      case 'Meter':
        outputValue = inputValueInMeter;
        break;
      case 'Kilometer':
        outputValue = inputValueInMeter / 1000.0;
        break;
      case 'Mile':
        outputValue = inputValueInMeter / 1609.34;
        break;
      case 'Yard':
        outputValue = inputValueInMeter / 0.9144;
        break;
      case 'Foot':
        outputValue = inputValueInMeter / 0.3048;
        break;
      case 'Inch':
        outputValue = inputValueInMeter / 0.0254;
        break;
    }

    setState(() {});
  }
}