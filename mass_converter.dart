import 'package:flutter/material.dart';

class MassConverter extends StatefulWidget {
  @override
  _MassConverterState createState() => _MassConverterState();
}

class _MassConverterState extends State<MassConverter> {
  double inputValue = 0.0;
  double outputValue = 0.0;
  String sourceUnit = 'Kilogram';
  String targetUnit = 'Kilogram';
  final List<String> units = ['Kilogram', 'Gram', 'Pound', 'Ounce'];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mass Converter'),
        backgroundColor: Colors.orange,
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
        labelText: 'Enter Mass',
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
        convertMass();
      },
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
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

  void convertMass() {
    double inputValueInKilogram = inputValue;

    switch (sourceUnit) {
      case 'Gram':
        inputValueInKilogram = inputValue / 1000.0;
        break;
      case 'Pound':
        inputValueInKilogram = inputValue * 0.453592;
        break;
      case 'Ounce':
        inputValueInKilogram = inputValue * 0.0283495;
        break;
    }

    switch (targetUnit) {
      case 'Kilogram':
        outputValue = inputValueInKilogram;
        break;
      case 'Gram':
        outputValue = inputValueInKilogram * 1000.0;
        break;
      case 'Pound':
        outputValue = inputValueInKilogram / 0.453592;
        break;
      case 'Ounce':
        outputValue = inputValueInKilogram / 0.0283495;
        break;
    }

    setState(() {});
  }
}