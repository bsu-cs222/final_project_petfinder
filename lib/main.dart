import 'package:url_launcher/url_launcher.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final parser = PetFinderParser();
final caller = QueryCall();

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: ZipCodePage(),
    );
  }
}

class ZipCodePage extends StatelessWidget {
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  ZipCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primaryContainer,
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Zip Code Entry')),
      body: Column(
        children: [
          const SizedBox(
            child:
                Text('Welcome to Petfinder, please enter your zipcode below'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: style,
                      controller: zipCodeController,
                      decoration:
                          const InputDecoration(labelText: 'Enter Zip Code'),
                    ),
                  ),
                ),
                SizedBox(
                    width: 250,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: style,
                          controller: genderController,
                          decoration: const InputDecoration(
                              labelText: 'Enter the Gender of the Pet'),
                        )))
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PetListPage(
                        zipCode: zipCodeController.text,
                        gender: genderController.text,
                      ),
                    ),
                  );
                },
                child: const Text('Enter'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetListPage extends StatefulWidget {
  final String zipCode;
  final String gender;

  const PetListPage({super.key, required this.zipCode, required this.gender});

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  bool userBoxSurveillance = false;
  List<dynamic> pets = [];

  void petBoxBehavior(PointerEvent details) {
    setState(() {
      userBoxSurveillance = true;
    });
  }

  void stopPetBoxBehavior(PointerEvent details) {
    setState(() {
      userBoxSurveillance = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await caller.makeRequestToAPI(dotenv.env['api_id'],
        dotenv.env['api_secret'], widget.zipCode, widget.gender);

    final parsedPets = parser.parseFivePets(response);
    setState(() {
      pets = parsedPets;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri aUrl = Uri.parse(url);
    if (await canLaunchUrl(aUrl)) {
      await launchUrl(aUrl);
    } else {
      throw 'The URL for this pet profile is broken.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: petBoxBehavior,
      onPointerMove: petBoxBehavior,
      onPointerCancel: stopPetBoxBehavior,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Available pets in the  ${widget.zipCode} area.')),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZipCodePage()),
                );
              },
              child: const Text('Back'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (BuildContext context, int index) {
                  final pet = pets[index];

                  return Column(
                    children: [
                      Container(
                        width: 600,
                        decoration: BoxDecoration(
                          border: Border.all(width: 10, color: Colors.pink),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (pet.photos.isNotEmpty)
                                  Image.network(
                                    pet.photos[0]['small'],
                                  ),
                                if (pet.photos.isEmpty)
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/660px-No-Image-Placeholder.svg.png?20200912122019',
                                    width: 100,
                                    height: 100,
                                    scale: 0.3,
                                  ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pet.name),
                                    Text('${pet.breed} ${pet.species}'),
                                    ElevatedButton(
                                      child:
                                          Text('Learn more about ${pet.name}'),
                                      onPressed: () {
                                        _launchURL(pet.urlString);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ), //gesture detector?
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
