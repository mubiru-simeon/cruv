import 'package:hive/hive.dart';

class Seat {
  static const DIRECTORY = "seats";

  static const BLANKSPACE = "blankSpace";
  static const OCCUPIED = "occupied";
  static const AVAILABLE = "available";
  static const NAME = "name";
  static const TYPE = "type";
  static const TRAINID = "trainID";

  static const EDITABLEBERTHS = "editableBerths";

  static const LOWER = "lower";
  static const UPPER = "upper";
  static const MIDDLE = "middle";
  static const SIDELOWER = "side lower";
  static const SIDEUPPER = "side upper";

  bool _occupied;
  String _id;
  bool _available;
  String _type;
  String _trainID;
  String _name;
  bool _blankSpace;

  bool get occupied => _occupied;
  String get id => _id;
  String get type => _type;
  String get trainID => _trainID;
  String get name => _name;
  bool get available => _available;
  bool get blankSpace => _blankSpace;

  Seat.fromData(
    bool occupied,
    bool blankSpace,
    bool available,
    String name,
    String type,
    String trainID,
    String id,
  ) {
    _id = id;
    _name = name;
    _trainID = trainID;
    _type = type;
    _occupied = occupied ?? false;
    _available = available ?? true;
    _blankSpace = blankSpace ?? false;
  }

  dynamic toMap() {
    return {
      Seat.OCCUPIED: _occupied,
      Seat.NAME: _name,
      Seat.TRAINID: _trainID,
      Seat.TYPE: _type,
      Seat.AVAILABLE: _available,
      Seat.BLANKSPACE: _blankSpace,
    };
  }
}

Seat getSeatfromID(
  Box box,
  String id,
) {
  Seat ss;

  dynamic seats = box.get(Seat.DIRECTORY) ?? {};

  for (var element in seats.entries) {
    if (element.key == id) {
      ss = Seat.fromData(
        element.value[Seat.OCCUPIED],
        element.value[Seat.BLANKSPACE],
        element.value[Seat.AVAILABLE],
        element.value[Seat.NAME],
        element.value[Seat.TYPE],
        element.value[Seat.TRAINID],
        id,
      );
    }
  }

  ss ??= Seat.fromData(
    false,
    false,
    true,
    null,
    Seat.LOWER,
    null,
    id,
  );

  return ss;
}

Train getTrainfromID(
  Box box,
  String id,
) {
  Train ss;

  dynamic trains = box.get(Train.DIRECTORY) ?? {};

  for (var element in trains.entries) {
    if (element.key == id) {
      ss = Train.fromData(
        element.value[Train.NAME],
        element.value[Train.SEATS],
        id,
      );
    }
  }

  return ss;
}

class Train {
  static const DIRECTORY = "trains";

  static const SEATS = "seats";
  static const NAME = "name";

  static const ID = "id";

  dynamic _seats;
  String _id;
  String _name;

  dynamic get seats => _seats;
  String get name => _name;
  String get id => _id;

  Train.fromData(
    String name,
    dynamic seats,
    String id,
  ) {
    _id = id;
    _name = name;
    _seats = seats ?? {};
  }

  dynamic toMap() {
    return {
      Train.ID: _id,
      Train.NAME: _name,
      Train.SEATS: _seats,
    };
  }
}
