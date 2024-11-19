import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/databases/task_controller.dart';
import 'package:pas1_mobile_11pplg1_23/pages/detail_page.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteTeamController favoriteController =
      Get.find<FavoriteTeamController>();

  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Favorite Teams',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        final favorites = favoriteController.favoriteTeams;

        if (favorites.isEmpty) {
          return Center(
            child: Text(
              'No favorite teams yet',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final team = favorites[index];
            return Card(
              color: AppColor.backgroundColor,
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => DetailPage(post: team, team: team));
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Team Badge
                      Container(
                        width: 80,
                        height: 80,
                        child: Hero(
                          tag: 'team-${team.strTeam}',
                          child: Image.network(
                            team.strBadge,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.error_outline,
                                color: Colors.white,
                                size: 40,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Team Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              team.strTeam,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              team.strStadium,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Favorite Button
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await favoriteController.toggleFavorite(team);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
