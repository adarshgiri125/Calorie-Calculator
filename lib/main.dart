import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Localization(
        child: CalorieFinder(),
      ),
    );
  }
}

class Localization extends StatefulWidget {
  final Widget child;

  const Localization({Key? key, required this.child}) : super(key: key);

  @override
  _LocalizationState createState() => _LocalizationState();
}

class _LocalizationState extends State<Localization> {
  late MaterialLocalizations localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Localizations.override(
        context: context,
        locale: Localizations.localeOf(context),
        child: widget.child,
      ),
    );
  }
}

class CalorieFinder extends StatefulWidget {
  @override
  _CalorieFinderState createState() => _CalorieFinderState();
}

class _CalorieFinderState extends State<CalorieFinder> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  String dropdownValue = 'Male';
  String dropdownActivityValue = 'Sedentary';
  String result = '';

  String calculateCalories() {
    double age = double.parse(ageController.text);
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    double calories = 0;

    if (dropdownValue == 'Male') {
      calories = 66 + (6.2 * weight) + (12.7 * height) - (6.76 * age);
    } else {
      calories = 655.1 + (4.35 * weight) + (4.7 * height) - (4.7 * age);
    }

    switch (dropdownActivityValue) {
      case 'Sedentary':
        calories *= 1.2;
        break;
      case 'Lightly Active':
        calories *= 1.375;
        break;
      case 'Moderately Active':
        calories *= 1.55;
        break;
      case 'Very Active':
        calories *= 1.725;
        break;
      case 'Extra Active':
        calories *= 1.9;
        break;
    }

    result =
        'You need to consume ${calories.toStringAsFixed(2)} calories per day.';

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calorie Finder'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Gender',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Age',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your age',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Weight (kg)',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your weight in kilograms',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Height (cm)',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your height in centimeters',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'How active are you?',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton<String>(
                value: dropdownActivityValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownActivityValue = newValue!;
                  });
                },
                items: <String>[
                  'Sedentary',
                  'Lightly Active',
                  'Moderately Active',
                  'Very Active',
                  'Extra Active'
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = calculateCalories().toString();
                  });
                },
                child: Text('Calculate'),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                result,
                style: TextStyle(fontSize: 18),
              ),
            ])));
  }
}
