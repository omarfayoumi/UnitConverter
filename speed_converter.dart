import 'package:flutter/material.dart';

class SpeedConverter extends StatefulWidget {
  @override
  _SpeedConverterState createState() => _SpeedConverterState();
}

class _SpeedConverterState extends State<SpeedConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Meter/Second';
  String targetUnit = 'Meter/Second';
  final List<String> units = ['Meter/Second', 'Kilometer/Hour', 'Mile/Hour'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Converter'),
        backgroundColor: Colors.red,
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
        labelText: 'Enter Speed',
        border: OutlineInputBorder(),
        hintText: 'e.g. 60',
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
        convertSpeed();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
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

  void convertSpeed() {
    double inputValueInMeterPerSecond = inputValue;

    switch (sourceUnit) {
      case 'Kilometer/Hour':
        inputValueInMeterPerSecond = inputValue / 3.6;
        break;
      case 'Mile/Hour':
        inputValueInMeterPerSecond = inputValue / 2.237;
        break;
    }

    switch (targetUnit) {
      case 'Meter/Second':
        outputValue = inputValueInMeterPerSecond;
        break;
      case 'Kilometer/Hour':
        outputValue = inputValueInMeterPerSecond * 3.6;
        break;
      case 'Mile/Hour':
        outputValue = inputValueInMeterPerSecond * 2.237;
        break;
    }

    setState(() {});
  }
}