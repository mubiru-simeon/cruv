import 'dart:async';

import 'package:cruv/constants/constants.dart';
import 'package:cruv/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/models.dart';
import '../theming/theming.dart';
import '../views/views.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key key}) : super(key: key);

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  TextEditingController nameController = TextEditingController();
  bool searching = false;
  Timer searchOnStoppedTyping;
  List<Seat> seats = [];
  Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(capitalizedAppName);
  }

  _onChangeHandler(value) {
    const duration = Duration(
      milliseconds: 200,
    );

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping.cancel();
    }

    searchOnStoppedTyping = Timer(
      duration,
      () => _search(value),
    );
  }

  _search(
    String searchText,
  ) {
    Future.delayed(Duration(milliseconds: 100), () async {
      if (searchText.trim().isNotEmpty) {
        if (mounted) {
          setState(() {
            searching = true;
          });
        }

        Map dd = box.get(Seat.DIRECTORY) ?? {};

        seats.clear();

        dd.forEach((k, v) {
          String name = v[Seat.NAME];
          if (name != null &&
              name.toLowerCase().contains(searchText.toLowerCase())) {
            seats.add(
              Seat.fromData(
                v[Seat.OCCUPIED],
                v[Seat.BLANKSPACE],
                v[Seat.AVAILABLE],
                v[Seat.NAME],
                v[Seat.TYPE],
                v[Seat.TRAINID],
                k,
              ),
            );
          }
        });

        if (mounted) {
          setState(() {
            searching = false;
          });
        }
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(
          icon: null,
          onPressed: null,
          text: "Search",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: standardPadding),
          child: TextField(
            controller: nameController,
            onChanged: (v) {
              _onChangeHandler(v);
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Type here",
              contentPadding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: standardBorderRadius,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 15,
                  color: ThemeBuilder.of(context).getCurrentTheme() ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.blue,
                ),
                onPressed: () {
                  nameController.clear();
                  if (mounted) {
                    setState(() {
                      seats.clear();
                      searching = false;
                    });
                  }
                },
              ),
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: standardPadding,
            ),
            child: searching
                ? LoadingWidget()
                : nameController.text.trim().isEmpty
                    ? NoDataFound(
                        text: "What are you looking for?",
                      )
                    : seats.isEmpty
                        ? NoDataFound(
                            text: "No Items Found.",
                            onTap: null,
                          )
                        : ListView.builder(
                            itemCount: seats.length,
                            itemBuilder: (context, index) {
                              Seat ss = seats[index];

                              Train tt = getTrainfromID(
                                box,
                                ss.trainID,
                              );

                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.all(standardPadding),
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.train,
                                      ),
                                    ),
                                    title: Text(
                                      ss.name ?? "Seat",
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (ss.type ?? "Unknown Type")
                                              .toUpperCase(),
                                        ),
                                        Text(
                                          "Train: ${tt.name}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomDivider(),
                                ],
                              );
                            },
                          ),
          ),
        )
      ],
    );
  }
}
