import 'package:flutter/material.dart';

import 'models.dart';

class TrainSelection extends ChangeNotifier {
  static const SELECTEDTRAIN = "selectedTrain";

  Map<String, dynamic> data = {};

  notify() {
    notifyListeners();
  }

  editSelectedTrain(
    Train train,
    bool notify,
  ) {
    if (train != null) {
      data.addAll({
        SELECTEDTRAIN: train,
      });
    } else {
      data.remove(
        SELECTEDTRAIN,
      );
    }

    if (notify) {
      notifyListeners();
    }
  }

  editEditableBerthsSetting(
    bool editable,
    bool notify,
  ) {
    data.addAll({
      Seat.EDITABLEBERTHS: editable,
    });

    if (notify) {
      notifyListeners();
    }
  }

  clear() {
    data.clear();

    notifyListeners();
  }
}
