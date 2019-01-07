class Group{
  int _id;
  String _name;

  Group(int id, String name){
    this.id = id;
    this.name = name;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map toJson() => {'id':id, 'name':name};

  factory Group.fromJson(Map<String, dynamic> group) => Group(group['id'], group['name']);

}
