class Team {
  final String strTeam;
  final String strStadium;
  final String strBadge;
  final String strDescriptionEN;

  Team({
    required this.strBadge,
    required this.strDescriptionEN,
    required this.strTeam,
    required this.strStadium,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      strTeam: json['strTeam'],
      strStadium: json['strStadium'],
      strBadge: json['strBadge'],
      strDescriptionEN: json['strDescriptionEN'],
    );
  }
  bool get isDataComplete {
    return strTeam.isNotEmpty &&
        strStadium.isNotEmpty &&
        strBadge.isNotEmpty &&
        strDescriptionEN.isNotEmpty;
  }
}