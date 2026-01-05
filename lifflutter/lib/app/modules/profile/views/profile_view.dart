import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../core/theme/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.settings, color: AppColors.primary),
                        title: const Text('Settings'),
                        onTap: () {
                          Get.back();
                          Get.snackbar('Settings', 'Settings page coming soon');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit, color: AppColors.primary),
                        title: const Text('Edit Profile'),
                        onTap: () {
                          Get.back();
                          Get.snackbar('Edit Profile', 'Edit profile page coming soon');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Get.back();
                          // Show logout confirmation
                          Get.defaultDialog(
                            title: 'Logout',
                            middleText: 'Are you sure you want to logout?',
                            textConfirm: 'Yes, Logout',
                            textCancel: 'Cancel',
                            confirmTextColor: Colors.white,
                            cancelTextColor: AppColors.textPrimary,
                            buttonColor: Colors.red,
                            backgroundColor: Colors.white,
                            radius: 12,
                            onConfirm: () {
                              Get.back();
                              controller.logout();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuSection('Account', [
              _buildMenuItem(Icons.person_outline, 'Personal Info', () {}),
              _buildMenuItem(Icons.location_on_outlined, 'Addresses', () {}),
              _buildMenuItem(Icons.payment, 'Payment Methods', () {}),
            ]),
            const SizedBox(height: 16),
            _buildMenuSection('Preferences', [
              _buildMenuItem(Icons.notifications_outlined, 'Notifications', () {}),
              _buildMenuItem(Icons.language, 'Language', () {}),
              _buildMenuItem(Icons.dark_mode_outlined, 'Dark Mode', () {}),
            ]),
            const SizedBox(height: 16),
            _buildMenuSection('Support', [
              _buildMenuItem(Icons.help_outline, 'Help Center', () {}),
              _buildMenuItem(Icons.info_outline, 'About', () {}),
              _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
              _buildMenuItem(Icons.description_outlined, 'Terms of Service', () {}),
            ]),
            const SizedBox(height: 16),
            _buildMenuSection('More', [
              _buildMenuItem(Icons.star_outline, 'Rate Us', () {}),
              _buildMenuItem(Icons.share_outlined, 'Share App', () {}),
              _buildMenuItem(Icons.feedback_outlined, 'Send Feedback', () {}),
            ]),
            const SizedBox(height: 24),
            _buildLogoutButton(),
            const SizedBox(height: 24), // Extra padding at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Text(
                controller.userName.value.substring(0, 1),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.userName.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.userEmail.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.userPhone.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      )),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Card(
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Get.defaultDialog(
          title: 'Logout',
          middleText: 'Are you sure you want to logout?',
          textConfirm: 'Yes, Logout',
          textCancel: 'Cancel',
          confirmTextColor: Colors.white,
          cancelTextColor: AppColors.textPrimary,
          buttonColor: Colors.red,
          backgroundColor: Colors.white,
          radius: 12,
          onConfirm: () {
            Get.back(); // Close dialog
            controller.logout(); // Call logout method
          },
          onCancel: () {
            Get.back(); // Just close dialog
          },
        );
      },
      icon: const Icon(Icons.logout),
      label: const Text(
        'Logout',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }
}

