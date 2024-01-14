import 'package:flutter/material.dart';
import 'package:project/class/item_class.dart';
import 'package:project/pages/description_page.dart';

import '../core/constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.box});

  final ItemClass box;

  // final String imagePath;
  // final String title; // to oznacz że nigdy nie bedzie zmieniany ten tytul bo
  // tworzymy tylko jedna instancje

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DescriptionPage(box: box);
          },
        ));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(kDouble10),
          // color: Colors.black,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: kDouble5),
              Image.asset(box.imagePath),
              Text(
                box.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: kDouble10)
            ],
          ),
        ),
      ),
    );
  }
}
