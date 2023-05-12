import 'package:cruv/constants/constants.dart';
import 'package:cruv/models/berth.dart';
import 'package:cruv/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddBerthBottomSheet extends StatefulWidget {
  final Seat pp;
  const AddBerthBottomSheet({
    Key key,
    @required this.pp,
  }) : super(key: key);

  @override
  State<AddBerthBottomSheet> createState() => _AddBerthBottomSheetState();
}

class _AddBerthBottomSheetState extends State<AddBerthBottomSheet> {
  bool blankSpace = false;
  bool available = true;
  bool occupied = false;
  String mode = Seat.LOWER;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.pp.name,
    );

    mode = widget.pp.type ?? Seat.LOWER;
    available = widget.pp.available;
    blankSpace = widget.pp.blankSpace;
    occupied = widget.pp.occupied;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BackBar(
            icon: null,
            onPressed: null,
            text: "Add a berth",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: standardPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformationalBox(
                      visible: true,
                      onClose: null,
                      message: "Add a berth number and select the type",
                    ),
                    SizedBox(
                      height: standardPadding * 2,
                    ),
                    CustomDivider(),
                    CheckboxListTile(
                      value: blankSpace,
                      title: Text("This is a blank space"),
                      onChanged: (v) {
                        setState(() {
                          blankSpace = v;
                        });
                      },
                    ),
                    CustomDivider(),
                    SizedBox(
                      height: standardPadding * 2,
                    ),
                    if (!blankSpace)
                      Text(
                        "Add a berth number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!blankSpace)
                      SizedBox(
                        height: standardPadding,
                      ),
                    if (!blankSpace)
                      TextField(
                        decoration: standardInputDecoration,
                        controller: nameController,
                      ),
                    if (!blankSpace)
                      SizedBox(
                        height: standardPadding * 2,
                      ),
                    if (!blankSpace)
                      Text(
                        "Which type is it?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!blankSpace)
                      SizedBox(
                        height: standardPadding,
                      ),
                    if (!blankSpace)
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Seat.LOWER,
                            Seat.MIDDLE,
                            Seat.UPPER,
                            Seat.SIDELOWER,
                            Seat.SIDEUPPER,
                          ]
                              .map<Widget>(
                                (e) => Expanded(
                                  child: RowSelector(
                                    onTap: () {
                                      setState(() {
                                        mode = e;
                                      });
                                    },
                                    selected: mode == e,
                                    text: e.toString().toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (!blankSpace)
                      SizedBox(
                        height: standardPadding,
                      ),
                    if (!blankSpace) CustomDivider(),
                    if (!blankSpace)
                      CheckboxListTile(
                        value: available,
                        title: Text("This space is available"),
                        onChanged: (v) {
                          setState(() {
                            available = v;
                          });
                        },
                      ),
                    if (!blankSpace) CustomDivider(),
                    if (!blankSpace)
                      CheckboxListTile(
                        value: occupied,
                        title: Text("This space is occupied"),
                        onChanged: (v) {
                          setState(() {
                            occupied = v;
                          });
                        },
                      ),
                    if (!blankSpace) CustomDivider(),
                  ],
                ),
              ),
            ),
          ),
          ProceedButton(onTap: () {
            Navigator.of(context).pop({
              Seat.AVAILABLE: available,
              Seat.BLANKSPACE: blankSpace,
              Seat.OCCUPIED: occupied,
              Seat.TRAINID: widget.pp.trainID,
              Seat.TYPE: mode,
              Seat.NAME: nameController.text.trim(),
            });
          })
        ],
      ),
    );
  }
}
