import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Celsius';
  String targetUnit = 'Celsius';
  final List<String> units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        backgroundColor: Colors.purple,
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
        labelText: 'Enter Temperature',
        border: OutlineInputBorder(),
        hintText: 'e.g. 25',
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
      convertTemperature();
    },
    child: Text('Convert'),
    style: ElevatedButton.styleFrom(
      primary: Colors.purple,
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

void convertTemperature() {
  switch (sourceUnit) {
    case 'Celsius':
      outputValue = targetUnit == 'Fahrenheit'
          ? (inputValue * 9 / 5) + 32
          : (inputValue + 273.15);
      break;
    case 'Fahrenheit':
      outputValue = targetUnit == 'Celsius'
          ? (inputValue - 32) * 5 / 9
          : (inputValue - 32) * 5 / 9 + 273.15;
      break;
    case 'Kelvin':
      outputValue = targetUnit == 'Celsius'
          ? inputValue - 273.15
          : (inputValue - 273.15) * 9 / 5 + 32;
      break;
  }

  setState(() {});
}
}
        