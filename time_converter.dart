import 'package:flutter/material.dart';

class TimeConverter extends StatefulWidget {
  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Seconds';
  String targetUnit = 'Seconds';
  final List<String> units = ['Seconds', 'Minutes', 'Hours', 'Days'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
        backgroundColor: Colors.indigo,
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
        labelText: 'Enter Time',
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
        convertTime();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.indigo,
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

  void convertTime() {
    double inputValueInSeconds = inputValue;

    switch (sourceUnit) {
      case 'Minutes':
        inputValueInSeconds = inputValue * 60.0;
        break;
      case 'Hours':
        inputValueInSeconds = inputValue * 3600.0;
        break;
      case 'Days':
        inputValueInSeconds = inputValue * 86400.0;
        break;
    }

    switch (targetUnit) {
      case 'Seconds':
        outputValue = inputValueInSeconds;
        break;
      case 'Minutes':
        outputValue = inputValueInSeconds / 60.0;
        break;
      case 'Hours':
        outputValue = inputValueInSeconds / 3600.0;
        break;
      case 'Days':
        outputValue = inputValueInSeconds / 86400.0;
        break;
    }

    setState(() {});
  }
}