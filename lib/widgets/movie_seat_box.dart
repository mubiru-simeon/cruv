import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../views/views.dart';
import 'widgets.dart';

class MovieSeatBox extends StatefulWidget {
  final Seat seat;
  final bool menuable;
  final String toTheRight;
  final String toTheLeft;
  final String toTheNorth;
  final String toTheSouth;
  final bool selected;
  final String text;
  final Function onTap;
  final String seatID;
  final bool testing;

  const MovieSeatBox({
    Key key,
    @required this.seat,
    @required this.seatID,
    @required this.menuable,
    @required this.onTap,
    @required this.selected,
    this.text,
    @required this.toTheSouth,
    @required this.toTheNorth,
    @required this.toTheLeft,
    @required this.toTheRight,
    @required this.testing,
  }) : super(key: key);

  @override
  State<MovieSeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<MovieSeatBox> {
  Box box;
  double width = 80.0;

  @override
  void initState() {
    super.initState();
    box = Hive.box(capitalizedAppName);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seat == null) {
      Seat ss = getSeatfromID(
        box,
        widget.seatID,
      );

      return body(ss);
    } else {
      return body(
        widget.seat,
      );
    }
  }

  body(Seat seat) {
    final color = widget.selected
        ? selectedSeatColor
        : seat.blankSpace
            ? Theme.of(context).canvasColor
            : seat.occupied
                ? unavailableColor
                : availableColor;

    Seat toTheLeft;
    Seat toTheNorth;
    Seat toTheRight;
    Seat toTheSouth;

    if (widget.toTheLeft != null) {
      toTheLeft = getSeatfromID(
        box,
        widget.toTheLeft,
      );
    }

    if (widget.toTheNorth != null) {
      toTheNorth = getSeatfromID(
        box,
        widget.toTheNorth,
      );
    }

    if (widget.toTheRight != null) {
      toTheRight = getSeatfromID(
        box,
        widget.toTheRight,
      );
    }

    if (widget.toTheSouth != null) {
      toTheSouth = getSeatfromID(
        box,
        widget.toTheSouth,
      );
    }

    bool showNoth = toTheNorth != null;
    bool showSouth = toTheSouth != null;
    bool showLeft = toTheLeft != null;
    bool showRight = toTheRight != null;

    return widget.menuable
        ? FocusedMenuHolder(
            menuItems: [
              FocusedMenuItem(
                title: const Text(
                  "Edit this slot",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await UIServices()
                      .showDatSheet(
                    AddBerthBottomSheet(
                      pp: seat,
                    ),
                    true,
                    context,
                  )
                      .then(
                    (value) {
                      if (value != null) {
                        dynamic dd = box.get(Seat.DIRECTORY) ?? {};

                        Map pp = {};
                        dd.forEach((k, v) {
                          pp.addAll({k: v});
                        });

                        pp.addAll({
                          seat.id: value,
                        });

                        box.put(
                          Seat.DIRECTORY,
                          pp,
                        );

                        Provider.of<TrainSelection>(
                          context,
                          listen: false,
                        ).notify();
                      }
                    },
                  );
                },
                backgroundColor: primaryColor,
                trailingIcon: const Icon(
                  Icons.space_bar,
                  color: Colors.white,
                ),
              ),
              if (!seat.blankSpace)
                FocusedMenuItem(
                  title: const Text(
                    "View Bookings For This Seat",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    UIServices().showDatSheet(
                      SeatBookings(seat: seat),
                      true,
                      context,
                    );
                  },
                  backgroundColor: Colors.green,
                  trailingIcon: const Icon(
                    FontAwesomeIcons.chair,
                    color: Colors.white,
                  ),
                ),
            ],
            onPressed: () {},
            openWithTap: true,
            child: Stack(
              children: [
                if (!seat.blankSpace && (showNoth && showLeft))
                  Positioned(
                    top: 0,
                    left: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showNoth && showRight))
                  Positioned(
                    top: 0,
                    right: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showSouth && showLeft))
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showSouth && showRight))
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: singleBox(),
                  ),
                AnimatedContainer(
                  height: width,
                  width: width,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: standardBorderRadius,
                  ),
                  child: child(seat),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              if (seat.available) {
                widget.onTap();
              }
            },
            child: Stack(
              children: [
                if (!seat.blankSpace && (showNoth && showLeft))
                  Positioned(
                    top: 0,
                    left: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showNoth && showRight))
                  Positioned(
                    top: 0,
                    right: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showSouth && showLeft))
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: singleBox(),
                  ),
                if (!seat.blankSpace && (showSouth && showRight))
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: singleBox(),
                  ),
                AnimatedContainer(
                  height: widget.testing ? null : width,
                  width: widget.testing ? null : width,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: standardBorderRadius,
                  ),
                  child: child(seat),
                ),
              ],
            ),
          );
  }

  child(Seat seat) {
    return seat.blankSpace
        ? null
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (seat.name != null)
              Text(
                seat.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 97, 175),
                ),
              ),
            if (seat.type != null)
              Text(
                seat.type.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 97, 175),
                ),
              ),
          ]);
  }

  Widget overLaidBoxes(
    bool showNorth,
    bool showSouth,
    bool showLeft,
    bool showRight,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showNorth || showLeft) singleBox(),
            if (showNorth || showRight) singleBox(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showSouth || showLeft) singleBox(),
            if (showSouth || showRight) singleBox(),
          ],
        ),
      ],
    );
  }

  singleBox() {
    return Container(
      width: width / 2 + 5,
      height: width / 2 + 5,
      color: primaryColor,
    );
  }
}

class SeatBookings extends StatefulWidget {
  final Seat seat;
  const SeatBookings({
    Key key,
    @required this.seat,
  }) : super(key: key);

  @override
  State<SeatBookings> createState() => _SeatBookingsState();
}

class _SeatBookingsState extends State<SeatBookings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Bookings",
        ),
        Expanded(
          child: NoDataFound(
            text: "No Bookings Yet",
          ),
        )
      ],
    );
  }
}
