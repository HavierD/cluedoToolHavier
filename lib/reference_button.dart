import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/data_model.dart';
import 'package:havier_cluedo_tool/enums.dart';

class ReferenceButton extends StatelessWidget {
  final List<Evidence> evidences;
  final Function callBack;

  const ReferenceButton({Key? key, required this.evidences, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Evidence>(
      onSelected: (selected) {
        callBack(selected.name);
      },
      itemBuilder: (BuildContext context) => _generatePopupMenuItems(evidences),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(evidences[0].runtimeType.toString()),
      ),
    );
  }

  List<PopupMenuItem<Evidence>> _generatePopupMenuItems(List<Evidence> evidences) {
    List<PopupMenuItem<Evidence>> re = [];
    for (var e in evidences) {
      final item = PopupMenuItem(
        value: e,
        child: Text(
          e.name,
          // style: const TextStyle(
          //   fontSize: 16.0,
          //   fontWeight: FontWeight.w500,
          //   letterSpacing: 0.5,
          //   color: Colors.cyan,
          // ),
        ),
      );
      re.add(item);
    }
    return re;
  }
}

class ReferenceButtonPlayer extends StatelessWidget {
  final DataModel model;
  final Function callBack;

  const ReferenceButtonPlayer({Key? key, required this.model,required this.callBack, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> players = [];
    players.add("me");
    if (model.game.otherPlayer2.name != ""){players.add(model.game.otherPlayer2.name);}
    if (model.game.otherPlayer3.name != ""){players.add(model.game.otherPlayer3.name);}
    if (model.game.otherPlayer4.name != ""){players.add(model.game.otherPlayer4.name);}
    if (model.game.otherPlayer5.name != ""){players.add(model.game.otherPlayer5.name);}
    if (model.game.otherPlayer6.name != ""){players.add(model.game.otherPlayer6.name);}

    return PopupMenuButton<String>(
      onSelected: (selected) {
        callBack(selected);
      },
      itemBuilder: (BuildContext context) => _generatePopupMenuItems(players),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("PLAYERS"),
      ),
    );
  }

  List<PopupMenuItem<String>> _generatePopupMenuItems(List<String> players) {
    List<PopupMenuItem<String>> re = [];
    for (var e in players) {
      final item = PopupMenuItem(
        value: e,
        child: Text(e),
      );
      re.add(item);
    }
    return re;
  }
}
