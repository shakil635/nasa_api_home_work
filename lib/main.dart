import 'package:flutter/material.dart';
import 'package:nasa_image_and_video_api_test/image_screen.dart/home.dart';

void main() {
  runApp(const NasaApi());
}

class NasaApi extends StatelessWidget {
  const NasaApi({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp( 
      home:HomePage(),
    );
  }
}
