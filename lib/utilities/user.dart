class UserModel {

  final String uid;
  final int wins;
  final int games;
  final String name;
  final int elo;
  final List friends;

  UserModel({ this.uid = '', this.wins = 0, this.games = 0, this.name = '', this.elo = 1000, this.friends = const []});

}