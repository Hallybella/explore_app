import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          // widget.title,
          "Explore",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit_outlined))
        ],
        bottom: PreferredSize(
          preferredSize: Size(
            double.infinity,
            120,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.86,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                        // controller: promoControl,
                        // maxLines: ,
                        // cursorColor:
                        //     primaryOrangeColor,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.all(12.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  // color:
                                  //     primaryOrangeColor,
                                  width: 2.0),
                            ),
                            labelStyle: const TextStyle(color: Colors.red),
                            // prefixIcon: const Icon(Icons.lock_outline, color: primaryOrangeColor),
                            focusColor: Colors.red,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            // labelText: "",
                            hintText: "Search Country"),
                        textInputAction: TextInputAction.done,
                        validator: (passcode) {
                          Pattern pattern = r'[0-9]{1}$';
                          RegExp regex = RegExp(pattern.toString());
                          if (passcode!.length == 0) {
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 700,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[Text("data")],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Row(
                          children: [Icon(Icons.access_alarm), Text("data")],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 700,
                              color: Colors.amber,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Row(
                          children: [Icon(Icons.access_alarm), Text("data")],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.05,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     color: Colors.red,
              //   ),
              // child: ,
              // )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [],
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 20,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          //         child: SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.75,
          //           child: TextFormField(
          //             textAlign: TextAlign.center,
          //             toolbarOptions: ToolbarOptions(
          //               copy: true,
          //               selectAll: true,
          //             ),
          //             // controller: promoControl,
          //             // maxLines: ,
          //             // cursorColor:
          //             //     primaryOrangeColor,
          //             style: TextStyle(
          //               fontSize: MediaQuery.of(context).size.width * 0.03,
          //             ),
          //             textAlignVertical: TextAlignVertical.center,
          //             keyboardType: TextInputType.text,
          //             decoration: InputDecoration(
          //                 prefixIcon: Icon(Icons.search),
          //                 contentPadding: EdgeInsets.all(12.0),
          //                 focusedBorder: OutlineInputBorder(
          //                   borderSide: BorderSide(
          //                       // color:
          //                       //     primaryOrangeColor,
          //                       width: 2.0),
          //                 ),
          //                 labelStyle: const TextStyle(color: Colors.red),
          //                 // prefixIcon: const Icon(Icons.lock_outline, color: primaryOrangeColor),
          //                 focusColor: Colors.red,
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(3.0),
          //                 ),
          //                 // labelText: "",
          //                 hintText: "Search Country"),
          //             textInputAction: TextInputAction.done,
          //             validator: (passcode) {
          //               Pattern pattern = r'[0-9]{1}$';
          //               RegExp regex = RegExp(pattern.toString());
          //               if (passcode!.length == 0) {
          //                 return 'Field cannot be empty';
          //               } else if (!regex.hasMatch(passcode)) {
          //                 return 'Characters must be digits only';
          //               } else {
          //                 return null;
          //               }
          //             },
          //             // onSaved: (password) =>  promoCode = password,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    )
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
