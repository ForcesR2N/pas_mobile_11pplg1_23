import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/models/team_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteTeamController extends GetxController {
  static Database? _db;
  var favoriteTeams = <Team>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteTeams();
  }

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'favorite_teams.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorite_teams(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            strTeam TEXT,
            strStadium TEXT,
            strBadge TEXT,
            strDescriptionEN TEXT
          )
        ''');
      },
    );
  }

  Future<void> loadFavoriteTeams() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('favorite_teams');
    favoriteTeams.assignAll(queryResult.map((data) => Team(
      strTeam: data['strTeam'],
      strStadium: data['strStadium'],
      strBadge: data['strBadge'],
      strDescriptionEN: data['strDescriptionEN'],
    )).toList());
  }

  Future<bool> isTeamFavorite(String teamName) async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query(
      'favorite_teams',
      where: 'strTeam = ?',
      whereArgs: [teamName],
    );
    return queryResult.isNotEmpty;
  }

  Future<void> toggleFavorite(Team team) async {
    var dbClient = await db;
    bool isFavorite = await isTeamFavorite(team.strTeam);

    if (isFavorite) {
      // Remove from favorites
      await dbClient!.delete(
        'favorite_teams',
        where: 'strTeam = ?',
        whereArgs: [team.strTeam],
      );
    } else {
      // Add to favorites
      await dbClient!.insert('favorite_teams', {
        'strTeam': team.strTeam,
        'strStadium': team.strStadium,
        'strBadge': team.strBadge,
        'strDescriptionEN': team.strDescriptionEN,
      });
    }
    
    // Reload favorite teams
    await loadFavoriteTeams();
  }

  Future<void> removeFavorite(String teamName) async {
    var dbClient = await db;
    await dbClient!.delete(
      'favorite_teams',
      where: 'strTeam = ?',
      whereArgs: [teamName],
    );
    await loadFavoriteTeams();
  }

  List<Team> getAllFavoriteTeams() {
    return favoriteTeams;
  }
}