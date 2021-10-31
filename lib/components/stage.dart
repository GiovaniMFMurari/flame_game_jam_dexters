// import 'package:flame/components.dart';

import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame_game_jam_dexters/components/item.dart';

class Stage {
  static const staticStages = <int, List<String>>{
    1: [
      ';;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';;',
      ';;',
      ';;',
      '1;;2',
      ';;',
      '2;1;',
      ';;',
      ';1;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '2;;1',
      ';;',
      '1;2;',
      ';;',
      ';2;1',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '1;;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';;',
      '2;1;2',
      ';;',
      ';1;',
      ';;',
      '2;;1',
      ';;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';1;',
      ';1;',
      ';1;',
      ';;1',
      ';;1',
      ';;',
      '1;;',
      '1;;',
      ';;1',
      ';1;',
      ';1;',
      ';;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '1;2;2',
      ';;',
      ';1;2',
      ';;',
      '2;1;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';1;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';1;2',
      ';1;2',
      '1;2;',
      ';1;2',
      '2;1;',
      ';2;1',
      '1;;',
      '1;;2',
      ';1;2',
      '1;1;',
      '1;2;2',
      '1;;',
      ';1;',
      ';;1',
      '2;2;1',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';;',
      ';;',
      ';;',
      '1;;2',
      ';;',
      '2;1;',
      ';;',
      ';1;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '2;;1',
      ';;',
      '1;2;',
      ';;',
      ';2;1',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '1;;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';;',
      '2;1;2',
      ';;',
      ';1;',
      ';;',
      '2;;1',
      ';;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';1;',
      ';1;',
      ';1;',
      ';;1',
      ';;1',
      ';;',
      '1;;',
      '1;;',
      ';;1',
      ';1;',
      ';1;',
      ';;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      '1;2;2',
      ';;',
      ';1;2',
      ';;',
      '2;1;',
      ';;',
      '1;;',
      ';;',
      ';1;',
      ';1;',
      ';2;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;',
      ';;'
    ]
  };
  static double distanceBetweenItems = 100.0;
  static double initialX = 50;
  static const double spawnPositionY = 0.0;

  int stage;
  Queue<Iterable> stageRows = Queue();

  Stage({this.stage = 1});

  Queue<Iterable> readStage() {
    List<String> rawStage = staticStages[stage]!;

    for (var rawRow in rawStage) {
      stageRows.add(_interpretRow(rawRow));
    }

    return stageRows;
  }

  List<Item?> _interpretRow(String rawRow) {
    var row = rawRow.split(';');
    List<Item?> itemsRow = List.empty(growable: true);

    for (var i = 0; i < row.length; i++) {
      switch (row[i]) {
        case '1':
          itemsRow.add(Item.treat(
              Vector2((initialX + i * distanceBetweenItems), spawnPositionY)));
          break;
        case '2':
          itemsRow.add(Item.trick(
              Vector2((initialX + i * distanceBetweenItems), spawnPositionY)));
          break;
        default:
          itemsRow.add(null);
      }
    }

    return itemsRow;
  }
}
