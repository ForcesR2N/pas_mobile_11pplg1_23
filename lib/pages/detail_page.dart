import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/databases/task_controller.dart';
import 'package:pas1_mobile_11pplg1_23/models/team_model.dart';
import 'package:pas1_mobile_11pplg1_23/utils/snackbar_helper.dart';
import 'package:pas1_mobile_11pplg1_23/widget/expanded_description.dart';

class DetailPage extends StatefulWidget {
  final Team post;
  DetailPage({super.key, required this.post, required team});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final favoriteController = Get.find<FavoriteTeamController>();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    isFavorite = await favoriteController.isTeamFavorite(widget.post.strTeam);
    if (mounted) {
      setState(() {});
    }
  }

  void toggleFavorite() async {
    await favoriteController.toggleFavorite(widget.post);
    setState(() {
      isFavorite = !isFavorite;
    });
    
    if (isFavorite) {
      SnackbarHelper.showSuccess(
        'Successfully added to favorites',
        title: 'Added to Favorites',
      );
    } else {
      SnackbarHelper.showError(
        'Successfully removed from favorites',
        title: 'Removed from Favorites',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.post.strBadge.isNotEmpty)
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: AppColor.backgroundColor,
                    ),
                    Hero(
                      tag: 'team-${widget.post.strTeam}',
                      child: Container(
                        width: 200,
                        height: 200,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            AppColor.backgroundColor,
                            BlendMode.dstATop,
                          ),
                          child: Image.network(
                            widget.post.strBadge,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.strTeam,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (widget.post.strStadium.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stadium, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Stadium: ${widget.post.strStadium}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  if (widget.post.strDescriptionEN.isNotEmpty)
                    ExpandableDescription(
                      description: widget.post.strDescriptionEN,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}