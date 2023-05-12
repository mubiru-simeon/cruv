import 'dart:io';

import 'package:flutter/material.dart';

import 'services.dart';

class UIServices {
  ImageProvider<Object> getImageProvider(
    dynamic asset,
  ) {
    return asset == null
        ? null
        : asset is File
            ? FileImage(asset)
            : asset.toString().trim().contains(
                      "assets/images",
                    )
                ? AssetImage(
                    asset,
                  )
                : NetworkImage(
                    asset,
                  );
  }

  DecorationImage decorationImage(
    dynamic asset,
    bool darken,
  ) {
    return asset == null
        ? null
        : DecorationImage(
            image: getImageProvider(
              asset,
            ),
            fit: BoxFit.cover,
            colorFilter: darken
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  )
                : null,
          );
  }

  Future<dynamic> showDatSheet(
    Widget sheet,
    bool willThisThingNeedScrolling,
    BuildContext context, {
    double height,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: willThisThingNeedScrolling,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: height ?? MediaQuery.of(context).size.height * 0.9,
            child: StatefulBuilder(builder: (context, setIt) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService().pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).canvasColor,
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          16,
                        ),
                        topRight: Radius.circular(
                          16,
                        ),
                      ),
                      child: Container(
                        color: Theme.of(context).canvasColor,
                        child: sheet,
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
