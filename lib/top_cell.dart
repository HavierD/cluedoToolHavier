import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/data_model.dart';
import 'package:havier_cluedo_tool/textfield_alert_dialog.dart';

class TopCell extends StatefulWidget {
  final int flex;
  final Player player;
  final Function callback;
  bool editable;

  TopCell({
    super.key,
    required this.flex,
    required this.player,
    required this.callback,
    this.editable = true,
  });

  @override
  State<TopCell> createState() => _TopCellState();
}

class _TopCellState extends State<TopCell> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: ElevatedButton(
        onPressed: widget.editable? () {
          showDialog(
              context: context,
              builder: (context) {
                return TextfieldAlertDialog(
                  player: widget.player,
                  callBack: widget.callback,
                );
              });
        } : (){},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white70,
          side: const BorderSide(color: Colors.black, width: 1),
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(widget.player.name),
      ),
    );
  }
}
