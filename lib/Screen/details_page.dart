// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore_hng/models/rest_country_model.dart';
import 'package:explore_hng/services/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../services/api_services/lang_convert.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, this.countryDetails, this.flags}) : super(key: key);

  RestCountryModel? countryDetails;
  List<String>? flags;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final GetLang langController = Get.put(GetLang());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.bottomAppBarColor,
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(
            color: Color(0xFF030F23),
          ),
          iconTheme: IconThemeData(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          // titleTextStyle: TextStyle(
          //   color: Color(0xFF030F23),
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          // ),
          title: Text(widget.countryDetails!.name!.common!),
        ),
        body: ListView(children: [
          CarouselSlider(
            options: CarouselOptions(height: 250.0),
            items: widget.flags!.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Image.network(
                        i,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text("Unable to load map"));
                        },
                      ));
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Population: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.population.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Region: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.region.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Capital: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.capital![0].toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Motto: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Official language: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.languages!.values.first
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Ethnic group: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Religion: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Government: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Independence: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.independent!
                          ? "Independent, but date not supplied"
                          : "Not supplied"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Area: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.area.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Currency: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.currencies!.values.first.name
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "GDP: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Time zone: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.timezones![0].toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Date format: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Dialing code: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Not supplied"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Driving side: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.countryDetails!.car!.side.toString().inCaps),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
