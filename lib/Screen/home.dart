// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:ui';

import 'package:explore_hng/Screen/details_page.dart';
import 'package:explore_hng/services/api_services/lang_convert.dart';
import 'package:explore_hng/services/misc/language_tool.dart';
import 'package:explore_hng/services/misc/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/theme_controllers/theme_service.dart';
import '../main.dart';
import '../models/check_box_model.dart';
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
  final GetLang langController = Get.put(GetLang());
  // Future<List<RestCountryModel>>? _value;
  // Future<List<RestCountryModel>>? _valueSave;
  List<RestCountryModel> items = [];
  List<RestCountryModel> defaultItems = [];
  List<RestCountryModel> filteredItems = [];
  List<String> filterCriteria = [];
  List<String> languages = [];
  List<String> languas = [];
  List<String> unfilterContinents = [];
  List<String> unfiltertimeZones = [];
  List<CheckBoxListTileModel> continents = [];
  List<CheckBoxListTileModel> timeZones = [];
  Map<String, Map<String, String>> langtrans = {};
  String? gender;
  String? selectedLang;
  bool selectedTimeZone = false;
  bool selectedContinent = false;
  bool showFilterButton = false;
  bool dataCheck = false;
  var paymentType;
  TextEditingController editingController = TextEditingController();

  @override
  initState() {
    getCountryData();
    super.initState();
    // _value = getValue();
    // _value!.then((value) => defaultItems = value);
  }

  void filterSearchResults(String query) async {
    List<RestCountryModel> dummySearchList = [];
    dummySearchList.addAll(defaultItems);
    print("defaultItem: $defaultItems");
    if (query.isNotEmpty) {
      List<RestCountryModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name!.common!.toLowerCase().contains(query.toLowerCase()) ||
            item.capital!.contains(query)) {
          dummyListData.add(item);
        }
      });
      //  print("defaultItem: $defaultItems");
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      print("defaultItem: $defaultItems");
      return;
    } else if (query.isEmpty) {
      // await getCountryData();
      // print("defaultItem: $defaultItems");
      setState(() {
        items.clear();
        items.addAll(defaultItems);
      });
      print("defaultItem: $defaultItems");
    }
  }

  getCountryData() async {
    try {
      final apiUrl = Uri.parse(AppUtils.restCountryUrl);
      final response = await http.get(
        apiUrl,
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        for (int i = 0;
            i < restCountryModelFromJson(response.body).length;
            i++) {
          defaultItems.add(restCountryModelFromJson(response.body)[i]);
          if (restCountryModelFromJson(response.body)[i].translations != null) {
            restCountryModelFromJson(response.body)[i]
                .translations!
                .forEach((key, value) {
              languas.add(key);

              // langtrans.addEntries({
              //   key.toString(): {
              //     restCountryModelFromJson(response.body)[i].name!.common!:
              //         value.common.toString()
              //   }
              // }.entries);
              // print(key);
              // print(value);
              // langtrans.addEntries()
            });
          }
          if (restCountryModelFromJson(response.body)[i]
              .continents!
              .isNotEmpty) {
            unfilterContinents
                .add(restCountryModelFromJson(response.body)[i].continents![0]);
          }
          if (restCountryModelFromJson(response.body)[i]
              .timezones!
              .isNotEmpty) {
            unfiltertimeZones.addAll(
                restCountryModelFromJson(response.body)[i].timezones!.toList());
          }
        }
        setState(() {
          defaultItems
              .sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
          items.addAll(defaultItems);
          // defaultItems = defaultItems;
          final ids = <dynamic>{};
          languages.retainWhere((x) => ids.add(x));
          languages.sort(((a, b) => a.compareTo(b)));
          final idstwo = <dynamic>{};
          languas.retainWhere((x) => idstwo.add(x));
          languas.sort(((a, b) => a.compareTo(b)));
          final idsg = <dynamic>{};
          unfilterContinents.retainWhere((x) => idsg.add(x));
          unfilterContinents.sort(((a, b) => a.compareTo(b)));
          final idtime = <dynamic>{};
          unfiltertimeZones.retainWhere((x) => idtime.add(x));
          unfiltertimeZones.sort(((a, b) => a.compareTo(b)));
        });
        for (int i = 0; i < unfilterContinents.length; i++) {
          setState(() {
            continents.add(CheckBoxListTileModel(
                value: unfilterContinents[i], isCheck: false));
          });
        }
        for (int i = 0; i < unfiltertimeZones.length; i++) {
          setState(() {
            timeZones.add(CheckBoxListTileModel(
              value: unfiltertimeZones[i],
            ));
            timeZones.removeWhere((element) => element.value == "UTC");
          });
        }
        setState(() {
          dataCheck = false;
        });

        // print("main items: $languas");
        // print("defaultItem: $defaultItems");
        // print("languages: $languages");
        // print("continents: $continents");
        // print("timezone: $timeZones");
        // print(languages.toSet());
        // return countryData;
      } else {
        print(response.body);
        return [];
      }
    } on SocketException catch (_) {
      var snackBar = SnackBar(
          content: Text('Connection error. Check yout internet settings'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        dataCheck = true;
      });
    } catch (e) {
      var snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        dataCheck = true;
      });
    }
  }

  // Future<List<RestCountryModel>> getValue() async {
  //   List<RestCountryModel> countryData = [];
  //   List<String> langList = [];
  //   final apiUrl = Uri.parse(AppUtils.restCountryUrl);
  //   final response = await http.get(
  //     apiUrl,
  //     headers: {
  //       "Accept": "application/json",
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     for (int i = 0; i < restCountryModelFromJson(response.body).length; i++) {
  //       countryData.add(restCountryModelFromJson(response.body)[i]);
  //       if (restCountryModelFromJson(response.body)[i].languages != null) {
  //         restCountryModelFromJson(response.body)[i]
  //             .languages!
  //             .forEach((key, value) {
  //           languages.add(value);
  //         });
  //       }
  //       // restCountryModelFromJson(response.body)[i]
  //       //     .languages!
  //       //     .forEach((key, value) {
  //       //   languages.add(value);
  //       // });
  //     }
  //     // setState(() {
  //     countryData.sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
  //     items = countryData;
  //     defaultItems = countryData;
  //     // languages.toSet();
  //     // });

  //     final ids = Set();
  //     languages.retainWhere((x) => ids.add(x));
  //     languages.sort(((a, b) => a.compareTo(b)));
  //     print(items);
  //     // print(languages.toSet());
  //     return countryData;
  //   } else {
  //     print(response.body);
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.bottomAppBarColor,
        centerTitle: false,
        title: Row(
          children: [
            Get.isDarkMode
                ? Image.asset(
                    "assets/logo.png",
                    height: MediaQuery.of(context).size.height * 0.0425,
                  )
                : Image.asset(
                    "assets/ex_logo.png",
                    height: MediaQuery.of(context).size.height * 0.06,
                  )
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
            MediaQuery.of(context).size.height * 0.15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    print(value);
                    filterSearchResults(value);
                  },
                  controller: editingController,
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
                      onTap: () async {
                        // items.translations!.forEach((key, value) {
                        //   langtrans.addEntries({
                        //     key.toString(): {
                        //       restCountryModelFromJson(response.body)[i]
                        //           .name!
                        //           .common!: value.common.toString()
                        //     }
                        //   }.entries);
                        //   // print(key);
                        //   // print(value);
                        //   // langtrans.addEntries()
                        // });

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
                                        itemCount: languas.length,
                                        itemBuilder: ((context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  languas[index].inCaps,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Radio(
                                                    value: languas[index],
                                                    groupValue: selectedLang,
                                                    onChanged: (val) async {
                                                      print(languas[index]);
                                                      setState(() {
                                                        selectedLang =
                                                            val.toString();
                                                      });
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await prefs.setString(
                                                          'language',
                                                          languas[index]
                                                              .toString());
                                                      print(prefs
                                                          .get('language'));
                                                      // await langController
                                                      //     .getCountryData(
                                                      //         langType: languas[
                                                      //             index]);
                                                      Get.updateLocale(Locale(
                                                          languas[index]
                                                              .toString()));
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            ),
                                          );
                                          // return RadioListTile(
                                          //   value: languages[index],
                                          //   title: Text(languages[index]),
                                          //   groupValue: paymentType,
                                          //   onChanged: (val) {
                                          //     print(val);
                                          // setState(() {
                                          //   languages[index] =
                                          //       val.toString();
                                          // });
                                          //   },
                                          // );
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
                          builder: (context) => StatefulBuilder(
                            builder: (context, setStateBTX) {
                              return Wrap(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 16.0),
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.25,
                                    decoration: BoxDecoration(
                                      color: context.theme.backgroundColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .shade200,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                5.0),
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
                                          ExpansionTile(
                                            onExpansionChanged: (value) {
                                              print(value);
                                              setStateBTX((() {
                                                selectedContinent = value;
                                              }));

                                              if (selectedContinent == false &&
                                                  selectedTimeZone == false) {
                                                showFilterButton = false;
                                              } else {
                                                showFilterButton = true;
                                              }
                                            },
                                            title: Text(
                                              "Continent",
                                            ),
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: ListView.builder(
                                                    itemCount:
                                                        continents.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return CheckboxListTile(
                                                        activeColor:
                                                            Colors.pink[300],
                                                        dense: true,
                                                        //font change
                                                        title: Text(
                                                          continents[index]
                                                              .value!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                        value: continents[index]
                                                            .isCheck,
                                                        onChanged: (bool? val) {
                                                          if (val!) {
                                                            setStateBTX(() {
                                                              filteredItems.addAll(items
                                                                  .where((element) => element
                                                                      .continents![
                                                                          0]
                                                                      .contains(
                                                                          continents[index]
                                                                              .value!))
                                                                  .toList());
                                                              final idsfilt =
                                                                  <dynamic>{};
                                                              filteredItems
                                                                  .retainWhere(
                                                                      (x) => idsfilt
                                                                          .add(
                                                                              x));
                                                              filteredItems.sort(
                                                                  (a, b) => a
                                                                      .name!
                                                                      .common!
                                                                      .compareTo(b
                                                                          .name!
                                                                          .common!));
                                                            });
                                                          } else {
                                                            if (filteredItems
                                                                .isNotEmpty) {
                                                              // remove only
                                                              setStateBTX(() {
                                                                filteredItems.removeWhere((element) => element
                                                                    .continents![
                                                                        0]
                                                                    .contains(continents[
                                                                            index]
                                                                        .value!));
                                                                final idsfilt =
                                                                    <dynamic>{};
                                                                filteredItems
                                                                    .retainWhere((x) =>
                                                                        idsfilt.add(
                                                                            x));
                                                                filteredItems.sort(
                                                                    (a, b) => a
                                                                        .name!
                                                                        .common!
                                                                        .compareTo(b
                                                                            .name!
                                                                            .common!));
                                                              });
                                                            } else {
                                                              setStateBTX(() {
                                                                filteredItems =
                                                                    [];
                                                              });
                                                            }
                                                          }
                                                          print(filteredItems
                                                              .length);
                                                          setStateBTX(() {
                                                            continents[index]
                                                                .isCheck = val;
                                                          });
                                                        },
                                                      );
                                                    })),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            onExpansionChanged: (value) {
                                              print(value);
                                              setStateBTX((() {
                                                selectedTimeZone = value;
                                              }));

                                              if (selectedContinent == false &&
                                                  selectedTimeZone == false) {
                                                showFilterButton = false;
                                              } else {
                                                showFilterButton = true;
                                              }
                                            },
                                            title: Text("Time zones"),
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                child: ListView.builder(
                                                    itemCount: timeZones.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return CheckboxListTile(
                                                        activeColor:
                                                            Colors.pink[300],
                                                        dense: true,
                                                        //font change
                                                        title: Text(
                                                          timeZones[index]
                                                              .value!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  0.5),
                                                        ),
                                                        value: timeZones[index]
                                                                .isCheck ??
                                                            false,
                                                        onChanged: (bool? val) {
                                                          if (val!) {
                                                            setStateBTX(() {
                                                              filteredItems.addAll(items
                                                                  .where((element) => element
                                                                      .timezones![
                                                                          0]
                                                                      .contains(
                                                                          timeZones[index]
                                                                              .value!))
                                                                  .toList());
                                                              final idsfilt =
                                                                  <dynamic>{};
                                                              filteredItems
                                                                  .retainWhere(
                                                                      (x) => idsfilt
                                                                          .add(
                                                                              x));
                                                              filteredItems.sort(
                                                                  (a, b) => a
                                                                      .name!
                                                                      .common!
                                                                      .compareTo(b
                                                                          .name!
                                                                          .common!));
                                                            });
                                                          } else {
                                                            if (filteredItems
                                                                .isNotEmpty) {
                                                              // remove only
                                                              setStateBTX(() {
                                                                filteredItems.removeWhere((element) => element
                                                                    .timezones![
                                                                        0]
                                                                    .contains(timeZones[
                                                                            index]
                                                                        .value!));
                                                                final idsfilt =
                                                                    <dynamic>{};
                                                                filteredItems
                                                                    .retainWhere((x) =>
                                                                        idsfilt.add(
                                                                            x));
                                                                filteredItems.sort(
                                                                    (a, b) => a
                                                                        .name!
                                                                        .common!
                                                                        .compareTo(b
                                                                            .name!
                                                                            .common!));
                                                              });
                                                            } else {
                                                              setStateBTX(() {
                                                                filteredItems =
                                                                    [];
                                                              });
                                                            }
                                                          }
                                                          print(filteredItems
                                                              .length);
                                                          setStateBTX(() {
                                                            timeZones[index]
                                                                .isCheck = val;
                                                          });
                                                        },
                                                      );
                                                    })),
                                              )
                                            ],
                                          ),
                                          showFilterButton
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          for (var i = 0;
                                                              i <
                                                                  continents
                                                                      .length;
                                                              i++) {
                                                            setStateBTX((() {
                                                              continents[i]
                                                                      .isCheck =
                                                                  false;
                                                            }));
                                                          }
                                                          for (var i = 0;
                                                              i <
                                                                  timeZones
                                                                      .length;
                                                              i++) {
                                                            setStateBTX((() {
                                                              timeZones[i]
                                                                      .isCheck =
                                                                  false;
                                                            }));
                                                          }
                                                          setState((() {
                                                            filteredItems = [];
                                                            items =
                                                                defaultItems;
                                                          }));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Reset")),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (filteredItems
                                                              .isNotEmpty) {
                                                            setState(() {
                                                              items =
                                                                  filteredItems;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              filteredItems =
                                                                  [];
                                                              items =
                                                                  defaultItems;
                                                            });
                                                          }

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                            "Show results"))
                                                  ],
                                                )
                                              : Container()

                                          // SizedBox(
                                          //   height:
                                          //       MediaQuery.of(context).size.height *
                                          //           0.75,
                                          //   child: ListView.builder(
                                          //     // shrinkWrap: true,
                                          //     itemCount: languas.length,
                                          //     itemBuilder: ((context, index) {
                                          //       return ExpansionTile(title: title);
                                          //       // return RadioListTile(
                                          //       //   value: languages[index],
                                          //       //   title: Text(languages[index]),
                                          //       //   groupValue: paymentType,
                                          //       //   onChanged: (val) {
                                          //       //     print(val);
                                          //       // setState(() {
                                          //       //   languages[index] =
                                          //       //       val.toString();
                                          //       // });
                                          //       //   },
                                          //       // );
                                          //     }),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: dataCheck
            ? Center(
                child: Text("No data to display"),
              )
            : items.isEmpty
                ? Center(child: CircularProgressIndicator())
                : filteredItems.isEmpty
                    ? ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              List<String> flagList = [];
                              flagList.add(items[index].flags!.png!);
                              flagList.add(items[index].coatOfArms!.png!);
                              flagList.add(items[index].maps!.openStreetMaps!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsPage(
                                      countryDetails: items[index],
                                      flags: flagList,
                                    );
                                  },
                                ),
                              );
                            },
                            title:
                                Text(items[index].name!.common.toString().tr),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  items[index].flags!.png.toString()),
                            ),
                            subtitle: Text(items[index].capital!.isEmpty
                                ? ""
                                : items[index].capital![0].toString()),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              List<String> flagList = [];
                              flagList.add(filteredItems[index].flags!.png!);
                              flagList
                                  .add(filteredItems[index].coatOfArms!.png!);
                              flagList.add(
                                  filteredItems[index].maps!.openStreetMaps!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsPage(
                                      countryDetails: filteredItems[index],
                                      flags: flagList,
                                    );
                                  },
                                ),
                              );
                            },
                            title: Text(filteredItems[index]
                                .name!
                                .common
                                .toString()
                                .tr),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  filteredItems[index].flags!.png.toString()),
                            ),
                            subtitle: Text(filteredItems[index].capital!.isEmpty
                                ? ""
                                : filteredItems[index].capital![0].toString()),
                          );
                        },
                      ),
      ),
      // body: FutureBuilder<List<RestCountryModel>>(
      //   future: _value,
      //   builder: (
      //     BuildContext context,
      //     AsyncSnapshot<List<RestCountryModel>> snapshot,
      //   ) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasError) {
      //         return Text("${snapshot.error}");
      //       } else if (snapshot.hasData) {
      // return SizedBox(
      //   height: MediaQuery.of(context).size.height * 0.8,
      //   child: ListView.builder(
      //     itemCount: items.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         onTap: () async {
      //           List<String> flagList = [];
      //           flagList.add(items[index].flags!.png!);
      //           flagList.add(items[index].coatOfArms!.png!);
      //           flagList.add(items[index].maps!.openStreetMaps!);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return DetailsPage(
      //                   countryDetails: items[index],
      //                   flags: flagList,
      //                 );
      //               },
      //             ),
      //           );
      //         },
      //         title: Text(items[index].name!.common.toString()),
      //         leading: CircleAvatar(
      //           radius: 25,
      //           backgroundImage:
      //               NetworkImage(items[index].flags!.png.toString()),
      //         ),
      //         subtitle: Text(items[index].capital!.isEmpty
      //             ? ""
      //             : items[index].capital![0].toString()),
      //       );
      //     },
      //   ),
      // );
      //       } else {
      //         return const Text('Empty data');
      //       }
      //     } else {
      //       return Center(child: Text('State: ${snapshot.connectionState}'));
      //     }
      //   },
      // ),
    );
  }
}
