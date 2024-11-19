import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/auth_controller.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/responsive_controller.dart';
import 'package:pas1_mobile_11pplg1_23/pages/login/login_page.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController;

  const ProfilePage({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBlue,
      body: Responsive(
        mobile: _buildProfileContent(context),
        tablet: _buildProfileContent(context, isTablet: true),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, {bool isTablet = false}) {
    final isLandscape = Responsive.isLandscape(context);

    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context, isTablet),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(context.spacing),
                child: isLandscape
                    ? _buildLandscapeLayout(context, isTablet)
                    : _buildPortraitLayout(context, isTablet),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(context.spacing),
      color: AppColor.primaryBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 30.0 : 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, bool isTablet) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 600 : double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.spacing * 2),
            _buildProfileImage(context, isTablet),
            SizedBox(height: context.spacing),
            _buildUsername(context, isTablet),
            SizedBox(height: context.spacing * 2),
            _buildInfoList(context, isTablet),
            SizedBox(height: context.spacing * 2),
            _buildLogoutButton(context, isTablet),
            SizedBox(height: context.spacing),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, bool isTablet) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 900 : double.infinity,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.spacing),
                  _buildProfileImage(context, isTablet),
                  SizedBox(height: context.spacing),
                  _buildUsername(context, isTablet),
                ],
              ),
            ),
            SizedBox(width: context.spacing * 3),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.spacing * 2),
                  _buildInfoList(context, isTablet),
                  SizedBox(height: context.spacing * 3),
                  _buildLogoutButton(context, isTablet),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, bool isTablet) {
    return CircleAvatar(
      radius: isTablet ? 100 : 50,
      backgroundImage: AssetImage('lib/assets/COMMS_RIZALP1_BGWHITE.png'),
      backgroundColor: AppColor.primaryBlue.withOpacity(0.2),
    );
  }

  Widget _buildUsername(BuildContext context, bool isTablet) {
    return Obx(
      () => Text(
        authController.username.value.isNotEmpty
            ? authController.username.value
            : "Username",
        style: TextStyle(
          fontSize: isTablet ? context.fontSize * 2 : context.fontSize * 1.2,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoList(BuildContext context, bool isTablet) {
    return Container(
      width: isTablet ? 500 : 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: isTablet ? 8 : 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(
            context: context,
            icon: Icons.email,
            title: "Email Address",
            subtitle: "user@example.com",
            isTablet: isTablet,
          ),
          Divider(height: 1),
          _buildListTile(
            context: context,
            icon: Icons.phone,
            title: "Phone Number",
            subtitle: "+62 8226 ****",
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isTablet,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.spacing,
        vertical: context.spacing / 2,
      ),
      leading: Icon(
        icon,
        color: AppColor.primaryBlue,
        size: isTablet ? 32 : 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: isTablet ? 20 : 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: isTablet ? 20 : 15,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: context.iconSize - 4,
      ),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isTablet) {
    return Container(
      width: isTablet ? 150 : 100,
      height: isTablet ? 50 : 45,
      child: ElevatedButton(
        onPressed: () {
          Get.offAll(() => LoginPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: context.spacing / 2,
            horizontal: context.spacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radius / 2),
          ),
          elevation: isTablet ? 3 : 2,
        ),
        child: Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.fontSize - 2,
          ),
        ),
      ),
    );
  }
}
