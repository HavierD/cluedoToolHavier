import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/enums.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  final String id;
  Player otherPlayer2 = Player(name: '');
  Player otherPlayer3 = Player(name: '');
  Player otherPlayer4 = Player(name: '');
  Player otherPlayer5 = Player(name: '');
  Player otherPlayer6 = Player(name: '');
  List<CellData> cellDatas = [];
  List<String> notes= [];

  Game(this.id);
  
  static Game newInstance(String id){
    final g =  Game(id);
    for (var i = 0; i < 6; i++) {
      for(var people in SUSPECT.values){
        g.cellDatas.add(CellData(evidence: people, playerIndex: i));
      }
      for(var weapon in WEAPON.values) {
        g.cellDatas.add(CellData(evidence: weapon, playerIndex: i));
      }
      for(var room in ROOM.values) {
        g.cellDatas.add(CellData(evidence: room, playerIndex: i));
      }
    }
    return g;
  }

  CellData getCellByEvidenceAndPlayerIndex(Evidence evidence, int index){
    for (var cd in cellDatas) {
      if (cd.evidence == evidence && cd.playerIndex == index) {
        return cd;
      }
    }
    throw Exception("couldn't find this cell: evidence: $evidence, index: $index");
  }

  Map<String, Object> toMap() {
    Map<String, Object> re = {
      'id' : id,
      'otherPlayer2' : otherPlayer2.name,
      'otherPlayer3' : otherPlayer3.name,
      'otherPlayer4' : otherPlayer4.name,
      'otherPlayer5' : otherPlayer5.name,
      'otherPlayer6' : otherPlayer6.name,
      'cellDatas': cellDatas.map((cellData) => {'evidence': cellData.evidence, 'playerIndex': cellData
          .playerIndex, 'state' : cellData.state}).toList(),
      'notes': notes
    };
    return re;
  }
}

class CellData{
  final Evidence evidence;
  final int playerIndex;
  String state;

  CellData({required this.evidence, required this.playerIndex, this.state = STATE.nil});

}

class Player{
  String name;
  Player({required this.name});
}


class DataModel extends ChangeNotifier{
  
  late Game game;
  CollectionReference gameCollection = FirebaseFirestore.instance.collection('games');

  bool loading = false;

  DataModel(){
    game = Game.newInstance("1");
    _fetchData();
    _refreshUI();
  }

  Future<void> _fetchData() async {
    _refreshUI();
  }

  void _refreshUI(){
    notifyListeners();
  }

  CellData findCellData({required Evidence evidence, required int index}){
    for( var e in game.cellDatas) {
      if (e.evidence == evidence && e.playerIndex == index) {
        return e;
      }
    }
    throw Exception("Cannot find this cell. Evidence: $evidence, player: $index");
  }

  String getNotes() {
    StringBuffer stringBuffer = StringBuffer();
    for (var note in game.notes) {
      stringBuffer.write(note);
      stringBuffer.write("\n");
    }
    return stringBuffer.toString();
  }
  void addNote(String note) {
    game.notes.add(note);
    _refreshUI();
  }
}

class DataModelFirebase extends ChangeNotifier{

  bool loading = false;
  late Game game;
  CollectionReference gameCollection = FirebaseFirestore.instance.collection('games');

  DataModelFirebase(){
    loading = true;
    _fetchData();
    _refreshUI();
  }

  Future<void> _fetchData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    final webData = webInfo.data;
    // final deviceName = Platform.localHostname;
    // final snapshot = await gameCollection.doc(deviceName).get();
    final snapshot = await gameCollection.doc('test1').get();
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    // if (!doc.exists){
    //   Game game = Game.newInstance(deviceName);
    //   gameCollection.doc(deviceName).update(game.toMap());
    // } else {
    //   game = Game(doc.id);
    //   game.otherPlayer2 = Player(name: doc['otherPlayer2']);
    //   game.otherPlayer3 = Player(name: doc['otherPlayer3']);
    //   game.otherPlayer4 = Player(name: doc['otherPlayer4']);
    //   game.otherPlayer5 = Player(name: doc['otherPlayer5']);
    //   game.otherPlayer6 = Player(name: doc['otherPlayer6']);
    //   game.notes = List<String>.from(doc['notes']);
    //
    // }
    _refreshUI();
  }

  void _refreshUI(){
    notifyListeners();
  }

  CellData findCellData({required Evidence evidence, required int index}){
    for( var e in game.cellDatas) {
      if (e.evidence == evidence && e.playerIndex == index) {
        return e;
      }
    }
    throw Exception("Cannot find this cell. Evidence: $evidence, player: $index");
  }

  void addNote(String note) {
    game.notes.add(note);
    _refreshUI();
  }
}
