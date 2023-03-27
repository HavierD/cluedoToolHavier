import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/data_model.dart';
import 'package:havier_cluedo_tool/enums.dart';

class CluedoCell extends StatefulWidget {
  final Evidence evidence;
  final int columnIndex;
  final DataModel model;

  const CluedoCell({
    super.key,
    required this.evidence,
    required this.columnIndex,
    required this.model,
  });

  @override
  State<CluedoCell> createState() => _CluedoCellState();
}

class _CluedoCellState extends State<CluedoCell> {
  late CellData cellData;

  @override
  void initState() {
    super.initState();
    cellData = widget.model.findCellData(
      evidence: widget.evidence,
      index: widget.columnIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          changeState();
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // side: const BorderSide(color: Colors.black, width: 1),
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(cellData.state),
    );
  }

  void changeState() {
    if (cellData.state == STATE.excluded) {
      cellData.state = STATE.suspected;
      return;
    }
    if (cellData.state == STATE.suspected) {
      cellData.state = STATE.nil;
      return;
    }
    if (cellData.state == STATE.nil) {
      cellData.state = STATE.excluded;
      return;
    }
  }


}
