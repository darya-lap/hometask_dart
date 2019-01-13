class GroupUserRelation{
  final String _userId;
  final int _groupId;
  bool _isAdmin;

  String get userId => _userId;

  int get groupId => _groupId;

  bool get isAdmin => _isAdmin;

  set isAdmin(bool value) {
    _isAdmin = value;
  }

  GroupUserRelation(this._userId, this._groupId, bool isAdmin){
    this.isAdmin = isAdmin;
  }

  Map toJson() => {'userId':userId, 'groupId':groupId, 'isAdmin':isAdmin};

  factory GroupUserRelation.fromJson(Map<String, dynamic> group) {

    return GroupUserRelation(
      group['userId'],
      group['groupId'],
      group['isAdmin']
    );
  }
}