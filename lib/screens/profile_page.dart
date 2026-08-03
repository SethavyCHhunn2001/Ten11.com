import 'package:flutter/material.dart';
import '../widgets/app_back_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.purple.shade100],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome, Fashionista!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TEN11 Member',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Gold Member',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Orders', '12', Icons.receipt_long),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Wishlist', '8', Icons.favorite),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Points', '450', Icons.star),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Menu Items
            _buildMenuItem(
              icon: Icons.history,
              title: 'Order History',
              subtitle: 'View your past orders',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.local_shipping,
              title: 'Track Order',
              subtitle: 'Track your current orders',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.location_on,
              title: 'Shipping Addresses',
              subtitle: 'Manage your addresses',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.payment,
              title: 'Payment Methods',
              subtitle: 'Manage your payment options',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.card_giftcard,
              title: 'Vouchers & Offers',
              subtitle: 'Available: 3 vouchers',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.headset_mic,
              title: 'Customer Support',
              subtitle: 'We\'re here to help',
              onTap: () {},
            ),

            const SizedBox(height: 8),

            // Settings Section
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                      activeThumbColor: Colors.pink,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.notifications,
                    title: 'Push Notifications',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeThumbColor: Colors.pink,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.email,
                    title: 'Email Updates',
                    trailing: Switch(
                      value: _emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      },
                      activeThumbColor: Colors.pink,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.language,
                    title: 'Language',
                    trailing: const Text(
                      'English',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showLogoutDialog();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.pink.shade300, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.pink, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
