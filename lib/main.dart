import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:havier_cluedo_tool/data_model.dart';
import 'package:havier_cluedo_tool/enums.dart';
import 'package:havier_cluedo_tool/reference_button.dart';
import 'package:havier_cluedo_tool/top_cell.dart';
import 'package:provider/provider.dart';

import 'cluedo_cell.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return DataModel();
      },
      child: MaterialApp(
        title: 'Havier Cluedo Sheet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Havier Cluedo Sheet'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  void _appendStringIntoTextField(String string) {
    setState(() {
      String newText = "${_textFieldController.text} $string";
      _textFieldController.text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: buildScaffold,
    );
  }

  Scaffold buildScaffold(BuildContext context, DataModel model, _) {
    return Scaffold(
      body: model.loading
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      // height: 800,
                      width: 350,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Column(
                            children: _generateGrid(model),
                          ),
                          Column(
                            children: _generateNoteTexts(model),
                          ),
                          ColoredBox(
                            color: Colors.white70,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ReferenceButton(
                                        evidences: SUSPECT.values,
                                        callBack: _appendStringIntoTextField),
                                    ReferenceButton(
                                        evidences: WEAPON.values,
                                        callBack: _appendStringIntoTextField),
                                    ReferenceButton(
                                        evidences: ROOM.values,
                                        callBack: _appendStringIntoTextField),
                                    ReferenceButtonPlayer(
                                        model: model,
                                        callBack: _appendStringIntoTextField),
                                    // OutlinedButton(
                                    //   onPressed: () => _appendStringIntoTextField("show"),
                                    //   child: const Text("show"),
                                    // ),
                                    // OutlinedButton(
                                    //   onPressed: () => _appendStringIntoTextField("to"),
                                    //   child: const Text("to"),
                                    // ),
                                  ],
                                ),
                                Stack(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ColoredBox(
                                      color: Colors.white70,
                                      child: TextField(
                                        controller: _textFieldController,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    bottom: 8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          model.game.notes.add(_textFieldController.text);
                                          _textFieldController.clear();
                                        });
                                      },
                                      child: const Text("OK"),
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Row> _generateGrid(DataModel model) {
    List<Row> rows = [];
    rows.add(_generateTopRow(model));
    rows.add(Row(children: const [SizedBox( child: Text("SUSPECT:"),)]));
    _generateSubGrid(SUSPECT.values, rows, model);
    rows.add(Row(children: const [SizedBox( child: Text("WEAPON:"),)]));
    _generateSubGrid(WEAPON.values, rows, model);
    rows.add(Row(children: const [SizedBox( child: Text("ROOM:"),)]));
    _generateSubGrid(ROOM.values, rows, model);

    return rows;
  }

  void _generateSubGrid(List<Evidence> evidences, List<Row> rows, DataModel model) {
    for (var evidence in evidences) {
      var r = Row(
        children: <Widget>[
          Expanded(
              flex: 35,
              child: ElevatedButton(onPressed: () {}, child: Text(evidence.name))),
          Expanded(
              flex: 10,
              child: CluedoCell(evidence: evidence, columnIndex: 0, model: model)),
          Expanded(
              flex: 10,
              child: CluedoCell(evidence: evidence, columnIndex: 1, model: model)),
          Expanded(
              flex: 10,
              child: CluedoCell(evidence: evidence, columnIndex: 2, model: model)),
          Expanded(
              flex: 10,
              child: CluedoCell(evidence: evidence, columnIndex: 3, model: model)),
          // Expanded(
          //     flex: 10,
          //     child: CluedoCell(evidence: evidence, columnIndex: 4, model: model)),
          // Expanded(
          //     flex: 10,
          //     child: CluedoCell(evidence: evidence, columnIndex: 5, model: model)),
        ],
      );
      rows.add(r);
    }
  }

  Row _generateTopRow(DataModel model) {
    refresh() {
      setState(() {});
    }

    return Row(
      children: <Widget>[
        TopCell(flex: 35, player: Player(name: ''), callback: refresh),
        TopCell(
          flex: 10,
          player: Player(name: "I"),
          callback: refresh,
          editable: false,
        ),
        TopCell(flex: 10, player: model.game.otherPlayer2, callback: refresh),
        TopCell(flex: 10, player: model.game.otherPlayer3, callback: refresh),
        TopCell(flex: 10, player: model.game.otherPlayer4, callback: refresh),
        // TopCell(flex: 10, player: model.game.otherPlayer5, callback: refresh),
        // TopCell(flex: 10, player: model.game.otherPlayer6, callback: refresh),
      ],
    );
  }

  List<Widget> _generateNoteTexts(DataModel model) {
    List<Widget> re = [];
    final notes = model.game.notes;
    for (var note in notes) {
      var t = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(note),
          IconButton(
            onPressed: () {
              setState(() {
                model.game.notes.remove(note);
              });
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      );
      re.add(t);
    }
    return re;
  }
}
