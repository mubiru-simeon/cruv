import 'dart:async';
import 'package:cruv/services/services.dart';
import 'package:cruv/views/no_data_found_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  Function doIt;

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      CommunicationServices().showSnackBar(
        "Press back once more to exit $capitalizedAppName",
        context,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: AllBerthsView(),
    );
  }
}

class AllBerthsView extends StatefulWidget {
  const AllBerthsView({Key key}) : super(key: key);

  @override
  State<AllBerthsView> createState() => _AllBerthsViewState();
}

class _AllBerthsViewState extends State<AllBerthsView> {
  Box box;
  bool editable = false;

  @override
  void initState() {
    box = Hive.box(capitalizedAppName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BackBar(
            icon: Icons.menu,
            action: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialogBox(
                      bodyText:
                          "Our station serves many different trains. You can tap on the menu button in the top left corner to view the trains and select yours. You'll then be able to see the seats on the train and select yours.",
                      buttonText: "Got it",
                      onButtonTap: () {},
                      showOtherButton: true,
                    );
                  },
                );
              },
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            text: "Seat Finder",
          ),
          GestureDetector(
            onTap: () {
              UIServices().showDatSheet(
                SearchBottomSheet(),
                true,
                context,
              );
            },
            child: Container(
              height: 70,
              padding: EdgeInsets.only(
                left: standardPadding,
                right: standardPadding,
                top: standardPadding,
              ),
              margin: EdgeInsets.only(
                bottom: standardPadding,
              ),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                  borderRadius: standardBorderRadius,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          "Tap here to search for your seat",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(
                          standardPadding,
                        ),
                        child: Center(
                          child: Text(
                            "Find",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Consumer<TrainSelection>(
            builder: (context, cart, child) {
              if (cart.data == null ||
                  cart.data.isEmpty ||
                  cart.data[TrainSelection.SELECTEDTRAIN] == null) {
                return NoDataFound(
                  text: "No train selected",
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  doSthText: "Please tap here to select a train and proceed",
                );
              } else {
                Train seatRow = cart.data[TrainSelection.SELECTEDTRAIN];
                editable = cart.data[Seat.EDITABLEBERTHS] ?? false;

                Map columnItems = seatRow.seats;

                return InteractiveViewer(
                  constrained: false,
                  child: Padding(
                    padding: const EdgeInsets.all(standardPadding * 2),
                    child: Column(
                      children: columnItems.entries.map<Widget>(
                        (e) {
                          List rowItems = e.value ?? [];

                          int currentColumnIndex =
                              columnItems.values.toList().indexOf(e.value);

                          return Row(
                            children: rowItems.map<Widget>(
                              (v) {
                                int currentRowIndex = rowItems.indexOf(v);

                                return MovieSeatBox(
                                  testing: false,
                                  seatID: v,
                                  toTheSouth: currentColumnIndex + 1 >
                                          columnItems.length - 1
                                      ? null
                                      : (getSeatfromID(
                                                box,
                                                columnItems.values.toList()[
                                                        currentColumnIndex + 1]
                                                    [currentRowIndex],
                                              ).blankSpace) ==
                                              true
                                          ? null
                                          : columnItems.values.toList()[
                                                  currentColumnIndex + 1]
                                              [currentRowIndex],
                                  toTheNorth: currentColumnIndex - 1 < 0
                                      ? null
                                      : (getSeatfromID(
                                                box,
                                                columnItems.values.toList()[
                                                        currentColumnIndex - 1]
                                                    [currentRowIndex],
                                              ).blankSpace) ==
                                              true
                                          ? null
                                          : columnItems.values.toList()[
                                                  currentColumnIndex - 1]
                                              [currentRowIndex],
                                  toTheLeft: currentRowIndex - 1 < 0
                                      ? null
                                      : (getSeatfromID(
                                                box,
                                                rowItems[currentRowIndex - 1],
                                              ).blankSpace) ==
                                              true
                                          ? null
                                          : rowItems[currentRowIndex - 1],
                                  toTheRight: currentRowIndex + 1 >
                                          rowItems.length - 1
                                      ? null
                                      : (getSeatfromID(
                                                box,
                                                rowItems[currentRowIndex + 1],
                                              ).blankSpace) ==
                                              true
                                          ? null
                                          : rowItems[currentRowIndex + 1],
                                  menuable: editable,
                                  onTap: () {
                                    CommunicationServices().showToast(
                                      "Tapped",
                                      primaryColor,
                                    );
                                  },
                                  selected: false,
                                  seat: null,
                                );
                              },
                            ).toList(),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
