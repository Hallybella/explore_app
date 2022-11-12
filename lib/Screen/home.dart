// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:explore_hng/Screen/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controllers/theme_service.dart';
import '../main.dart';
import '../models/rest_country_model.dart';
import 'package:http/http.dart' as http;

import '../services/api_services/api_endpoints.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<RestCountryModel>>? _value;
  List<String> languages = [];
  String? gender;
  var paymentType;

  Future<List<RestCountryModel>> getValue() async {
    List<RestCountryModel> countryData = [];
    List<String> langList = [];
    final apiUrl = Uri.parse(AppUtils.restCountryUrl);
    final response = await http.get(
      apiUrl,
      headers: {
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      for (int i = 0; i < restCountryModelFromJson(response.body).length; i++) {
        countryData.add(restCountryModelFromJson(response.body)[i]);
        if (restCountryModelFromJson(response.body)[i].languages != null) {
          restCountryModelFromJson(response.body)[i]
              .languages!
              .forEach((key, value) {
            languages.add(value);
          });
        }
        // restCountryModelFromJson(response.body)[i]
        //     .languages!
        //     .forEach((key, value) {
        //   languages.add(value);
        // });
      }
      // setState(() {
      countryData.sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
      // languages.toSet();
      // });

      final ids = Set();
      languages.retainWhere((x) => ids.add(x));
      languages.sort(((a, b) => a.compareTo(b)));
      // print(ids);
      // print(languages.toSet());
      return countryData;
    } else {
      print(response.body);
      return [];
    }
  }

  @override
  initState() {
    super.initState();
    _value = getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.bottomAppBarColor,
        centerTitle: false,
        title: Row(
          children: const [
            Text(
              "Explore",
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: ThemeService().switchTheme,
            icon: Icon(
              Get.isDarkMode
                  ? Icons.mode_night_outlined
                  : Icons.wb_sunny_outlined,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(
            double.infinity,
            MediaQuery.of(context).size.height * 0.13,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Search Country"),
                  // textInputAction: TextInputAction.,
                  validator: (passcode) {
                    Pattern pattern = r'[0-9]{1}$';
                    RegExp regex = RegExp(pattern.toString());
                    if (passcode!.isEmpty) {
                      return 'Field cannot be empty';
                    } else if (!regex.hasMatch(passcode)) {
                      return 'Characters must be digits only';
                    } else {
                      return null;
                    }
                  },
                  // onSaved: (password) =>  promoCode = password,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.82,
                                decoration: BoxDecoration(
                                  color: context.theme.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Languages",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade200,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //     left: 16.0,
                                    //     // vertical: 8.0,
                                    //   ),
                                    //   child: ListView(
                                    //     shrinkWrap: true,
                                    //     children: [
                                    //       Text(
                                    //         paymentType == null
                                    //             ? "Yoruba"
                                    //             : "English",
                                    //       ),
                                    //       RadioListTile(
                                    //         value: 1,
                                    //         title: const Text("Visa"),
                                    //         groupValue: paymentType,
                                    //         onChanged: (val) => setState(() {
                                    //           paymentType = val! as int;
                                    //         }),
                                    //       ),
                                    //       RadioListTile(
                                    //         value: 2,
                                    //         title: const Text("Mastercard"),
                                    //         groupValue: paymentType,
                                    //         onChanged: (val) => setState(() {
                                    //           paymentType = val! as int;
                                    //         }),
                                    //       ),
                                    // RadioListTile(
                                    //   value: 3,
                                    //   title:
                                    //       const Text("American express"),
                                    //   groupValue: paymentType,
                                    //   onChanged: (val) => setState(() {
                                    //     paymentType = val! as int;
                                    //   }),
                                    // ),
                                    //     ],
                                    //   ),
                                    // )
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: ListView.builder(
                                        // shrinkWrap: true,
                                        itemCount: languages.length,
                                        itemBuilder: ((context, index) {
                                          return RadioListTile(
                                            value: languages[index],
                                            title: Text(languages[index]),
                                            groupValue: paymentType,
                                            onChanged: (val) {
                                              print(val);
                                              // setState(() {
                                              //   languages[index] =
                                              //       val.toString();
                                              // });
                                            },
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.language_rounded,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("EN"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Wrap(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: context.theme.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Filter",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade200,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.close,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text("Filter"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<RestCountryModel>>(
        future: _value,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<RestCountryModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        List<String> flagList = [];
                        flagList.add(snapshot.data![index].flags!.png!);
                        flagList.add(snapshot.data![index].coatOfArms!.png!);
                        flagList
                            .add(snapshot.data![index].maps!.openStreetMaps!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPage(
                                countryDetails: snapshot.data![index],
                                flags: flagList,
                              );
                            },
                          ),
                        );
                      },
                      title:
                          Text(snapshot.data![index].name!.common.toString()),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            snapshot.data![index].flags!.png.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].capital!.isEmpty
                          ? ""
                          : snapshot.data![index].capital![0].toString()),
                    );
                  },
                ),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }
}
