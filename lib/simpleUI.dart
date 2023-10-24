import 'package:url_launcher/url_launcher.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter/material.dart';
final parser = PetFinderParser();
final caller = QueryCall();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ZipCodePage(),
    );
  }
}
// class MyAppState extends ChangeNotifier {
//   void backToSearchScreen() {
//     ZipCodePage();
//   }
// }
class ZipCodePage extends StatelessWidget {
  final TextEditingController zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zip Code Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: zipCodeController,
              decoration: InputDecoration(labelText: 'Enter Zip Code'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PetListPage(zipCode: zipCodeController.text),
                  ),
                );
              },
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}


class PetListPage extends StatefulWidget {
  final String zipCode;

  PetListPage({required this.zipCode});

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<dynamic> pets = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await caller.makeRequestToAPI(widget.zipCode);
    final parsedPets = parser.parseFivePets(response);
    setState(() {
      pets = parsedPets;
    });
  }

  Future<void> _launchURL(String url) async{
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)){
      await launchUrl(_url);
    } else {
      throw 'The URL for this pet profile is broken.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pet List for Zip Code ${widget.zipCode}')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ZipCodePage()),
              );
            },
            child: Text('Back'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (BuildContext context, int index) {
                final pet = pets[index];
                return ListTile(
                  title: Text(pet.name),
                  subtitle: GestureDetector(
                      onTap: () {
                        _launchURL(pet.URLString);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${pet.breed} ${pet.species}'),
                          if (pet.photos.isNotEmpty)
                            Image.network(pet.photos[0]['small'])
                          else
                            Text('No available photo for this pet.'),
                          Text(pet.URLString),
                        ],
                      ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

