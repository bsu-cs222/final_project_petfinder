import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Pet Finder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.pink,
              backgroundColor: Colors.pink.shade50,
              accentColor: Colors.pink.shade200),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var pageNumber = 1;
  void enterLocation(String input) {
    var keyboardMaybe = input;
    pageNumber = 2;
    print(pageNumber);
    notifyListeners();
  }

  void backToSearchScreen() {
    pageNumber = 1;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int pageNumber = appState.pageNumber;
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    Widget page;
    switch (pageNumber) {
      case 1:
        page = InitialPage();
        break;
      case 2:
        page = ListPage();
        break;
      default:
        throw UnimplementedError('no widget for $pageNumber');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Find A Pet'),
      ),
      body: page,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InitialPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    return Column(
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
                  controller: controller,
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
                padding: const EdgeInsets.all(20), child: Text('Option 2 Test'))
          ],
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  String current = controller.text;
                  if (current.isEmpty) {
                  } else {
                    appState.enterLocation(current);
                    controller.clear();
                  }
                },
                child: Text('Search')),
          ),
        )
      ],
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  appState.backToSearchScreen();
                },
                child: Text('Back')),
          )
        ],
      ),
    );
  }
}
