import 'package:cs222_final_project_pet_finder/enum_decoder.dart';
import 'package:cs222_final_project_pet_finder/query_builder.dart';
import 'package:cs222_final_project_pet_finder/query_call.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'input_wizard.dart';

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
  final TextEditingController ageController = TextEditingController();
  final inputWizard = InputWizard();
  final queryBuilder = QueryBuilder();
  ZipCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    String url = queryBuilder.baseURL();
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
              child: Text.rich(
            TextSpan(
              // default text style
              children: <TextSpan>[
                TextSpan(
                    text: 'Welcome to PetFinder! \n',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                TextSpan(
                    text: 'To get started, please enter your zipcode below.',
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(5),
                        ],
                        style: style,
                        controller: zipCodeController,
                        decoration: const InputDecoration(
                            labelText: 'Enter Zip Code *')),
                  ),
                ),
                const Text('\nHere are some optional filters:'),
                SizedBox(
                    width: 350,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: style,
                          controller: genderController,
                          decoration: const InputDecoration(
                              labelText: 'Gender: (female or male)'),
                        ))),
                SizedBox(
                  width: 350,
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
                SizedBox(
                    width: 350,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: style,
                          controller: ageController,
                          decoration: const InputDecoration(
                              labelText: 'Age: (baby, young, adult, senior)'),
                        )))
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  var genderRequest =
                      inputWizard.organizeGenderInput(genderController);
                  var  ageRequest=
                    inputWizard.organizeAgeInput(ageController);
                  var speciesRequest=
                      inputWizard.organizeSpeciesInput(speciesController);
                  final filterValues = {
                    'gender': genderRequest,
                    'location': zipCodeController.text,
                    'type': speciesRequest,
                    'age': ageRequest
                  };
                  url = queryBuilder.addFilter(filterValues, url);
                  var zipcodeRequest=inputWizard.organizeZipcodeInput(zipCodeController);
                  if (zipcodeRequest==true) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PetListPage(url: url),
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
  final String url;

  const PetListPage({
    super.key,
    required this.url,
  });

  @override
  PetListPageState createState() => PetListPageState();
}

class PetListPageState extends State<PetListPage> {
  final enumDecoder = EnumDecoder();
  final parser = PetFinderParser();
  List<dynamic> pets = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final caller = APICaller();
    final queryBuilder = QueryBuilder();
    String url = queryBuilder.baseURL();
    final response = await caller.makeRequestToAPI(
      dotenv.env['api_id'],
      dotenv.env['api_secret'],
      url,
    );

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
      child: Scaffold(
        appBar: AppBar(title: const Text('Available pets in the  area.')),
        body: Column(children: [
          if (pets.isEmpty)
            const Text.rich(
              TextSpan(
                // default text style
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'No adoptable pets were found based on your zipcode and filters!',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
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
                                  Text('Name: ${pet.name}'),
                                  Text('${pet.breed} ${pet.species}'),
                                  Text(
                                      'Gender: ${enumDecoder.decodeGenderEnum(pet.gender)}\nAge: ${enumDecoder.decodeGenderEnum(pet.age)}'),
                                  ElevatedButton(
                                    child: Text('Want to adopt ${pet.name}?'),
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
        ]),
      ),
    );
  }
}
