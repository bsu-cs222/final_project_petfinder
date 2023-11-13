import 'package:flutter/services.dart';
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
  final TextEditingController speciesController = TextEditingController();

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
          title: const Text('Search Page')),
      body: Column(
        children: [
          const SizedBox(
            child: Text(
                'Welcome to Petfinder, please enter your zipcode below. \n Fields marked with * are required.'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(5),
                      ],
                      style: style,
                      controller: zipCodeController,
                      decoration:
                          const InputDecoration(labelText: 'Enter Zip Code *'),
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
                              labelText: 'Gender: (female or male)'),
                        ))),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: style,
                      controller: speciesController,
                      decoration: const InputDecoration(
                          labelText: 'Species: (cat, dog, bird, etc.)'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (zipCodeController.text != "") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PetListPage(
                        zipCode: zipCodeController.text,
                        gender: genderController.text,
                        species: speciesController.text,
                      ),
                    ));
                  }
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
  final String species;

  const PetListPage(
      {super.key,
      required this.zipCode,
      required this.gender,
      required this.species});

  @override
  PetListPageState createState() => PetListPageState();
}

class PetListPageState extends State<PetListPage> {
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
    final response = await caller.makeRequestToAPI(
        dotenv.env['api_id'],
        dotenv.env['api_secret'],
        widget.zipCode,
        widget.gender,
        widget.species);

    final parsedPets = parser.parsePetInfo(response);
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
            if (pets.isEmpty) const Text('No adoptable pets were found!'),
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
                                  Column(
                                    children: [
                                      Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/660px-No-Image-Placeholder.svg.png?20200912122019',
                                        width: 100,
                                        height: 100,
                                        scale: 0.3,
                                      ),
                                      const Text(
                                          'Image is credited\nto wikimedia commons',
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pet.name),
                                    Text('${pet.breed} ${pet.species}'),
                                    Text('${pet.gender}'),
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
                      ),
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
