class UserModel {

  final String uid;
  final int wins;
  final int games;
  final String name;
  final int elo;
  final List friends;

  UserModel({required this.uid, required this.wins, required this.games, required this.name, required this.elo, required this.friends});

}