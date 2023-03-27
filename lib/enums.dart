abstract class Evidence {

 String get name;
}

enum SUSPECT implements Evidence{
  Green,
  Plum,
  Mustard,
  Peacock,
  Scarlett,
  White;

  @override
  String get name {
    return toString().split('.').last;
  }
}


enum WEAPON implements Evidence{
  C_Stick,
  Dagger,
  LeadPipe,
  Revolver,
  Rope,
  Spanner;

  @override
  String get name {
    return toString().split('.').last;
  }
}

enum ROOM implements Evidence{
  Conserv_,
  Lounge,
  Kitchen,
  Library,
  Hall,
  Study,
  Ballroom,
  Din_Room,
  Bill_Room;

  @override
  String get name {
  return toString().split('.').last;
}
}

class STATE {
  static const String excluded = "X";
  static const String suspected = "?";
  static const String nil = "";

}