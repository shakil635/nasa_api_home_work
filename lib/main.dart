import 'package:flutter/material.dart';
import 'package:nasa_image_and_video_api_test/image_screen.dart/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Box Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NASA IMAGE'),
          backgroundColor: const Color.fromARGB(56, 109, 10, 231),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBox(),
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController txt = TextEditingController();
  List<String> nasaImageResponseLinks = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txt,
                        decoration: const InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  submitButtonPressed(txt.text);
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: returnAllImagesFromNasa(nasaImageResponseLinks),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> returnAllImagesFromNasa(List<String> listOfLinks) {
    return listOfLinks
        .map((link) => Image.network(
              link,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image not found');
              },
            ))
        .toList();
  }

  void submitButtonPressed(String text) async {
    try {
      final items = await getItems(text);
      final links = getLinks(items);
      print(links.join('\n'));
      setState(() {
        nasaImageResponseLinks = links.isNotEmpty ? links : [];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
