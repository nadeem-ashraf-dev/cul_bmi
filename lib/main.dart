import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: BMICalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int height = 180;
  int weight = 60;
  int age = 20;
  bool isMale = true;

  void calculateBMI() {
    double bmi = weight / ((height / 100) * (height / 100));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResultScreen(bmi: bmi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: GenderCard(
                      gender: 'MALE',
                      icon: Icons.male,
                      isSelected: isMale,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: GenderCard(
                      gender: 'FEMALE',
                      icon: Icons.female,
                      isSelected: !isMale,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              color: Color(0xFF1D1E33),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HEIGHT', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('cm', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 100.0,
                    max: 220.0,
                    activeColor: Colors.pink,
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ParameterCard(
                    label: 'WEIGHT',
                    value: weight,
                    onMinus: () => setState(() => weight--),
                    onPlus: () => setState(() => weight++),
                  ),
                ),
                Expanded(
                  child: ParameterCard(
                    label: 'AGE',
                    value: age,
                    onMinus: () => setState(() => age--),
                    onPlus: () => setState(() => age++),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: calculateBMI,
            child: Container(
              color: Colors.pink,
              width: double.infinity,
              height: 60,
              child: Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;

  GenderCard({required this.gender, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Color(0xFF1D1E33) : Color(0xFF111328),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.white),
          SizedBox(height: 15),
          Text(
            gender,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ParameterCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  ParameterCard({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1D1E33),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
          Text(value.toString(), style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(icon: Icons.remove, onPressed: onMinus),
              SizedBox(width: 10),
              RoundIconButton(icon: Icons.add, onPressed: onPlus),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  RoundIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class BMIResultScreen extends StatelessWidget {
  final double bmi;

  BMIResultScreen({required this.bmi});

  @override
  Widget build(BuildContext context) {
    String bmiResult;
    if (bmi >= 25) {
      bmiResult = 'Overweight';
    } else if (bmi > 18.5) {
      bmiResult = 'Normal';
    } else {
      bmiResult = 'Underweight';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI RESULT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your BMI is:',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              bmiResult,
              style: TextStyle(fontSize: 24, color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
