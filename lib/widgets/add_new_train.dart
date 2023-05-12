import 'package:cruv/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../services/services.dart';
import 'widgets.dart';

class AddNewTrainBottomSheet extends StatefulWidget {
  const AddNewTrainBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  State<AddNewTrainBottomSheet> createState() => _AddNewTrainBottomSheetState();
}

class _AddNewTrainBottomSheetState extends State<AddNewTrainBottomSheet> {
  TextEditingController columnController = TextEditingController();
  TextEditingController rowController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var uuid = Uuid();
  Box box;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    box = Hive.box(capitalizedAppName);
  }

  @override
  Widget build(BuildContext context) {
    Map pp = {
      "e1": {
        "code": "e1",
        "occupied": true,
        "blankSpace": true,
        "unavailable": false,
      },
      "e2": {
        "code": "e2",
        "occupied": false,
        "blankSpace": true,
        "unavailable": true,
      },
      "e3": {
        "code": "e3",
        "occupied": true,
        "blankSpace": false,
        "unavailable": false,
      },
      "e4": {
        "code": "e4",
        "occupied": true,
        "blankSpace": true,
        "unavailable": true,
      },
      "e5": {
        "code": "e5",
        "occupied": false,
        "blankSpace": false,
        "unavailable": false,
      },
      "e6": {
        "code": "e6",
        "occupied": true,
        "blankSpace": false,
        "unavailable": false,
      },
      "e7": {
        "code": "e7",
        "occupied": false,
        "blankSpace": false,
        "unavailable": false,
      },
      "f1": {
        "code": "e7",
        "occupied": true,
        "blankSpace": false,
        "unavailable": false,
      },
      "f2": {
        "code": "e7",
        "occupied": false,
        "blankSpace": false,
        "unavailable": true,
      },
      "f3": {
        "code": "e7",
        "occupied": false,
        "blankSpace": false,
        "unavailable": false,
      },
      "f4": {
        "code": "e7",
        "blankSpace": false,
        "occupied": false,
        "unavailable": false,
      },
      "g4": {
        "code": "e7",
        "blankSpace": true,
        "occupied": false,
        "unavailable": false,
      },
      "g1": {
        "code": "e7",
        "occupied": false,
        "blankSpace": true,
        "unavailable": false,
      },
      "g2": {
        "code": "e7",
        "occupied": false,
        "blankSpace": false,
        "unavailable": false,
      },
      "g3": {
        "code": "e7",
        "occupied": false,
        "blankSpace": false,
        "unavailable": false,
      },
      "gh": {
        "code": "e7",
        "blankSpace": false,
        "occupied": false,
        "unavailable": false,
      },
    };

//List of lists.
//each list is a column
    List<List<String>> seatOrders = [
      [
        "e1",
        "e2",
        "e3",
        "e4",
        "e5",
      ],
      [
        "e6",
        "e7",
        "gh",
        "gh",
        "gh",
      ],
      [
        "f1",
        "f2",
        "f3",
        "f3",
        "f3",
      ],
      [
        "f1",
        "f2",
        "f3",
        "f3",
        "f3",
      ],
      [
        "e4",
        "e4",
        "e4",
        "e4",
        "e4",
      ],
      [
        "f1",
        "f2",
        "f3",
        "f3",
        "f3",
      ],
      [
        "f1",
        "f2",
        "f3",
        "f3",
        "f3",
      ],
      [
        "e1",
        "e1",
        "f3",
        "f3",
        "f3",
      ],
    ];

    return Scaffold(
      body: Column(
        children: [
          BackBar(
            icon: null,
            onPressed: null,
            text: "Tell Us About Your Seat Arrangement",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InformationalBox(
                    visible: true,
                    onClose: null,
                    message:
                        "Name your train and tell us how many rows and columns you have. \n\nStarting from the front of the train, count how many rows and columns you see, INCLUDING CORRIDORS AND ANY UNUSED SEATS AND ANY VACANT SPOTS.",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "For example :",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rows: 5",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: FrontOfTheBus(
                                image: logo,
                                maxHeigth:
                                    MediaQuery.of(context).size.height * 0.2,
                                maxWidth: MediaQuery.of(context).size.width,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Columns: 8",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: seatOrders.map(
                                  (e) {
                                    return Column(
                                      children: e.map(
                                        (v) {
                                          Seat seat = Seat.fromData(
                                            pp[v][Seat.OCCUPIED],
                                            pp[v][Seat.BLANKSPACE],
                                            pp[v][Seat.AVAILABLE],
                                            pp[v][Seat.NAME],
                                            pp[v][Seat.TYPE],
                                            pp[v][Seat.TRAINID],
                                            pp[v]["id"],
                                          );

                                          return MovieSeatBox(
                                            toTheSouth: null,
                                            toTheNorth: null,
                                            toTheLeft: null,
                                            toTheRight: null,
                                            testing: true,
                                            seatID: seat.id,
                                            menuable: false,
                                            selected: false,
                                            onTap: () {},
                                            seat: seat,
                                          );
                                        },
                                      ).toList(),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Name",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: standardInputDecoration,
                            controller: nameController,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Columns",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: standardInputDecoration,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            controller: columnController,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Rows",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: standardInputDecoration,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            controller: rowController,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProceedButton(
            processing: processing,
            onTap: () {
              if (columnController.text.trim().isEmpty) {
                CommunicationServices().showSnackBar(
                  "Please tell us how many rows it is.",
                  context,
                );
              } else {
                if (rowController.text.trim().isEmpty) {
                  CommunicationServices().showSnackBar(
                    "Please tell us how many columns it is.",
                    context,
                  );
                } else {
                  if (nameController.text.trim().isEmpty) {
                    CommunicationServices().showSnackBar(
                      "Please name this train / ship.",
                      context,
                    );
                  } else {
                    uploadSeats();
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  uploadSeats() async {
    setState(() {
      processing = true;
    });

    int ct = 0;
    dynamic columns = {};
    String trainID = Uuid().v4();

    for (int vt = 0; vt < int.parse(rowController.text.trim()); vt++,) {
      List<String> seatIDs = [];

      for (int vt = 0; vt < int.parse(columnController.text.trim()); vt++,) {
        String id = Uuid().v4();
        Seat seat = Seat.fromData(
          false,
          false,
          true,
          null,
          null,
          trainID,
          id,
        );

        seatIDs.add(seat.id);
        dynamic seatsInDaBox = box.get(Seat.DIRECTORY) ?? {};

        seatsInDaBox.addAll({
          id: seat.toMap(),
        });

        await box.put(Seat.DIRECTORY, seatsInDaBox);
      }

      columns.addAll({
        ct.toString(): seatIDs,
      });

      ct = ct + 1;
    }

    dynamic seatRowsInDaBox = box.get(Train.DIRECTORY) ?? {};

    Train seatRow = Train.fromData(
      nameController.text.trim(),
      columns,
      trainID,
    );

    seatRowsInDaBox.addAll({
      trainID: seatRow.toMap(),
    });

    await box.put(Train.DIRECTORY, seatRowsInDaBox);
    NavigationService().pop();

    CommunicationServices().showToast(
      "Your train has been added. You may now edit and change the seats as you like.",
      primaryColor,
    );
  }
}
