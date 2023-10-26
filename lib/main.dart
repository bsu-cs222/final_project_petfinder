import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final parser = PetFinderParser();
final File petTestFile = File('test/apiResponse.json');
final fileContents = petTestFile.readAsStringSync();
final pets = parser.parseFivePets(fileContents);

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
        page = ListPageWidget();
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
          child: Text('Welcome to Petfinder, please enter your zipcode below'),
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

class ListPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    //var _image;
    return Scaffold(
      body: Column(
        children: [
          Image.network(
              'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=100',
              width: 300,
              height: 100,
              scale: 0.3),
          // Image(
          //   image: _image,
          //   frameBuilder: (BuildContext context, Widget child, int? frame,
          //       bool? wasSynchronouslyLoaded) {
          //     return (Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Image.network(
          //           'https://ensemble-stars.fandom.com/wiki/(Sealed_Display_of_Specimens)_Mika_Kagehira',
          //           width: 150,
          //           height: 150),
          //     ));
          //   },
          //   loadingBuilder: (BuildContext context, Widget child,
          //       ImageChunkEvent? loadingProgress) {
          //     return Center(child: child);
          //   },
          // )
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (BuildContext context, int index) {
                final pet = pets[index];
                var smallPetPhoto = pet.photos[0]['large'];
                return ListTile(
                  title: Text(pet.name),
                  subtitle: Text('${pet.breed} ${pet.species}'),
                  trailing: Container(child: Image.network(smallPetPhoto)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                appState.backToSearchScreen();
              },
              child: Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
