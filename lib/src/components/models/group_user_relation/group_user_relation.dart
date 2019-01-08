class GroupUserRelation{
  final String _userId;
  final int _groupId;
  bool _isAdmin;

  String get userId => _userId;


  bool get isAdmin => _isAdmin;

  set isAdmin(bool value) {
    _isAdmin = value;
  }

  int get groupId => _groupId;

  GroupUserRelation(this._userId, this._groupId, bool isAdmin){
    this.isAdmin = isAdmin;
  }

  Map toJson() => {'userId':userId, 'groupId':groupId, 'isAdmin':isAdmin};

  factory GroupUserRelation.fromJson(Map<String, dynamic> groupUserRelation) =>
      GroupUserRelation(groupUserRelation['userId'], groupUserRelation['groupId'], groupUserRelation['isAdmin']);
}