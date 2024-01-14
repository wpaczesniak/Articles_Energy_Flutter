import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/class/item_class.dart';
import 'package:project/core/constants.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key, required this.box});

  final ItemClass box;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  double fontSizeCustom = 25;
  String _location = 'Unknown';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _location = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _location =
            'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {

      _location = '\u03C6: ${position.latitude.toStringAsFixed(3)}, \u03BB: ${position.longitude.toStringAsFixed(3)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.box.title),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(localizations.location + ": " + _location),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.location_on),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDouble10),
          child: Column(
            children: [
              Container(
                width: 700,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  widget.box.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: kDouble20,),
              Wrap(
                // spacing: kDouble10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fontSizeCustom = 15;
                      });
                    },
                    child: Text(localizations.smallTitle),
                  ),
                  const SizedBox(width: kDouble5,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fontSizeCustom = 20;
                      });
                    },
                    child: Text(localizations.mediumTitle),
                  ),
                  const SizedBox(width: kDouble5,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fontSizeCustom = 25;
                      });
                    },
                    child: Text(localizations.largeTitle),
                  ),

                ],
              ),
              const SizedBox(
                height: kDouble20,
              ),
              FittedBox(
                child: Text(
                  widget.box.title,
                  style: TextStyle(
                    fontSize: fontSizeCustom,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: kDouble20,
              ),
              Text(
                widget.box.description,
                style: TextStyle(
                  fontSize: fontSizeCustom,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: kDouble40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
