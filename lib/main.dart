import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink.shade50,
            accentColor: Colors.pink.shade200),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void enterLocation(input) {
    var keyboardMaybe = input;
    print(keyboardMaybe);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Find A Pet'),
      ),
      body: Column(
        children: [
          SizedBox(
            child: Text(
                'Welcome to Petfinder, here you\'ll *insert instructions later'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: style,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your location',
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Option 2 Test'))
            ],
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    initiateSearchAndFind;
                  },
                  child: Text('Search')),
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void initiateSearchAndFind() {}
}
