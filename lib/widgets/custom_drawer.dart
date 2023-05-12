import 'package:cruv/models/berth.dart';
import 'package:cruv/models/train_selection.dart';
import 'package:cruv/services/services.dart';
import 'package:cruv/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../theming/theming.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Box box;
  List<Train> rows = [];
  bool editableBerths = false;

  @override
  void initState() {
    box = Hive.box(capitalizedAppName);

    resetRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<TrainSelection>(builder: (context, cart, child) {
        editableBerths = cart.data[Seat.EDITABLEBERTHS] ?? false;

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    standardPadding,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: standardPadding * 2,
                        ),
                        Text(
                          capitalizedAppName,
                          style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: standardPadding / 2,
                        ),
                        Text(
                          "Please tap on a train to select it",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: standardPadding * 2,
                        ),
                        Column(
                          children: rows
                              .map<Widget>(
                                (e) => singleDrawerItem(
                                  onDelete: () {
                                    dynamic ss = box.get(Train.DIRECTORY) ?? {};

                                    for (var element in ss.entries) {
                                      if (element.key == e.id) {
                                        ss.remove(element.key);
                                      }
                                    }

                                    box.put(Train.DIRECTORY, ss);

                                    rows.remove(e);
                                    setState(() {});
                                  },
                                  label: e.name,
                                  onTap: () {
                                    Provider.of<TrainSelection>(context,
                                            listen: false)
                                        .editSelectedTrain(
                                      e,
                                      true,
                                    );

                                    NavigationService().pop();
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.train,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: standardPadding,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: standardPadding,
                ),
                child: Text(
                  "Admin controls",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.all(standardPadding),
                title: Text("Enable Editing Mode"),
                subtitle: Text(
                  "Lets you edit the berths and trains",
                ),
                value: editableBerths,
                onChanged: (v) {
                  Provider.of<TrainSelection>(context, listen: false)
                      .editEditableBerthsSetting(
                    v,
                    true,
                  );

                  setState(() {});
                },
              ),
              if (editableBerths)
                CustomButton(
                  onPressed: () async {
                    await UIServices()
                        .showDatSheet(
                      AddNewTrainBottomSheet(),
                      true,
                      context,
                    )
                        .then((value) {
                      resetRooms();
                    });
                  },
                  text: "Add a train",
                ),
              if (editableBerths)
                CustomButton(
                  onPressed: () async {
                    box.clear();
                    Provider.of<TrainSelection>(context, listen: false).clear();
                    rows.clear();

                    setState(() {});
                  },
                  text: "Clear all trains and seats",
                ),
              if (!kIsWeb)
                Padding(
                  padding: const EdgeInsets.all(
                    standardPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Theme:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: standardPadding,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: standardBorderRadius,
                          border: Border.all(),
                        ),
                        child: SwitcherButton(
                          size: 80,
                          value: ThemeBuilder.of(context).getCurrentTheme() ==
                              Brightness.light,
                          onChange: (v) async {
                            if (v) {
                              ThemeBuilder.of(context).makeLight();

                              box.put(
                                brightness,
                                "light",
                              );
                            } else {
                              ThemeBuilder.of(context).makeDark();

                              box.put(
                                brightness,
                                "dark",
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  resetRooms() {
    dynamic ss = box.get(Train.DIRECTORY) ?? {};

    rows.clear();

    for (var element in ss.entries) {
      rows.add(
        Train.fromData(
          element.value[Train.NAME],
          element.value[Train.SEATS],
          element.value[Train.ID],
        ),
      );
    }

    setState(() {});
  }

  Widget singleDrawerItem({
    @required String label,
    String image,
    @required Function onTap,
    @required Icon icon,
    bool processing = false,
    Function onDelete,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              standardPadding,
            ),
            child: Row(
              children: [
                image == null
                    ? icon
                    : CircleAvatar(
                        backgroundImage: AssetImage(image),
                      ),
                const SizedBox(
                  width: standardPadding,
                ),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (editableBerths)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      onDelete();
                    },
                    child: Text("Delete"),
                  ),
                ),
              ],
            ),
          SizedBox(
            height: standardPadding / 2,
          ),
          const CustomDivider(),
          SizedBox(
            height: standardPadding / 2,
          ),
        ],
      ),
    );
  }
}
