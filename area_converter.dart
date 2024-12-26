import 'package:flutter/material.dart';

class AreaConverter extends StatefulWidget {
  @override
  _AreaConverterState createState() => _AreaConverterState();
}

class _AreaConverterState extends State<AreaConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Square Meter';
  String targetUnit = 'Square Meter';
  final List<String> units = ['Square Meter', 'Square Kilometer', 'Square Mile', 'Square Yard', 'Square Foot', 'Square Inch'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Area Converter'),
        backgroundColor: Colors.green,
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
        labelText: 'Enter Area',
        border: OutlineInputBorder(),
        hintText: 'e.g. 100',
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
        convertArea();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
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

  void convertArea() {
    double inputValueInSquareMeter = inputValue;

    switch (sourceUnit) {
      case 'Square Kilometer':
        inputValueInSquareMeter = inputValue * 1e6;
        break;
      case 'Square Mile':
        inputValueInSquareMeter = inputValue * 2.59e6;
        break;
      case 'Square Yard':
        inputValueInSquareMeter = inputValue * 0.836127;
        break;
      case 'Square Foot':
        inputValueInSquareMeter = inputValue * 0.092903;
        break;
      case 'Square Inch':
        inputValueInSquareMeter = inputValue * 0.00064516;
        break;
    }

    switch (targetUnit) {
      case 'Square Meter':
        outputValue = inputValueInSquareMeter;
        break;
      case 'Square Kilometer':
        outputValue = inputValueInSquareMeter * 1e-6;
        break;
      case 'Square Mile':
        outputValue = inputValueInSquareMeter * 3.861e-7;
        break;
      case 'Square Yard':
        outputValue = inputValueInSquareMeter / 0.836127;
        break;
      case 'Square Foot':
        outputValue = inputValueInSquareMeter / 0.092903;
        break;
      case 'Square Inch':
        outputValue = inputValueInSquareMeter / 0.00064516;
        break;
    }

    setState(() {});
  }
}