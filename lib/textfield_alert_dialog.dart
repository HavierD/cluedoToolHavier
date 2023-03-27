import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/data_model.dart';

class TextfieldAlertDialog extends StatefulWidget {
  final Player player;
  final Function callBack;

  const TextfieldAlertDialog({Key? key, required this.player, required this.callBack, }) : super
      (key: key);

  @override
  State<TextfieldAlertDialog> createState() => _TextfieldAlertDialogState();
}

class _TextfieldAlertDialogState extends State<TextfieldAlertDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(hintText: 'player name'),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            widget.player.name = _textEditingController.text;
            Navigator.pop(context);
            widget.callBack.call();
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
