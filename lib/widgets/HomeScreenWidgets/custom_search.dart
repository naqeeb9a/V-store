import 'package:flutter/material.dart';

import 'package:google_place/google_place.dart';

class AutoMap extends StatefulWidget {
  const AutoMap({Key? key}) : super(key: key);

  @override
  _AutoMapState createState() => _AutoMapState();
}

class _AutoMapState extends State<AutoMap> {
  GooglePlace googlePlace =
      GooglePlace("AIzaSyCyogZR5H7QVuGgqRFL3kRg3cWDQVUkV3E");
  List<AutocompletePrediction> predictions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.isNotEmpty && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index].description!),
                      onTap: () {
                        debugPrint(predictions[index].placeId);
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Image.network(
                    "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
