import 'package:flutter/material.dart';
import 'package:wisata_app/models/tourism_place.dart';
import 'package:wisata_app/screens/vacation/detail_vacation_screen.dart';
import 'package:wisata_app/utils/contants.dart';

class VacationScreen extends StatelessWidget {
  const VacationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Indonesia'),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailVacation(place: place);
              }));
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    place.imageAsset,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    place.name,
                    textAlign: TextAlign.start
                    ,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Staatliches',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: tourismPlaceList.length,
      ),
    );
  }
}
