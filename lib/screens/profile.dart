import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  Map<String, dynamic> userData = {
    'name': 'John Eco Warrior',
    'email': 'john.eco@greenfields.com',
    'phone': '+1 (234) 567-8900',
    'address': '123 Green Street, Eco City',
    'memberSince': '2023-03-15',
    'profileImage': null, // null for placeholder, you can use actual image URL
  };

  // Statistics
  Map<String, dynamic> stats = {
    'totalPickups': 45,
    'kgRecycled': 245,
    'ecoPoints': 1250,
    'communityRank': 'Top 10%',
    'streakDays': 7,
  };

  // Settings options
  final List<ProfileOption> profileOptions = [
    ProfileOption(
      icon: Icons.person_outline,
      title: 'Personal Information',
      subtitle: 'Update your personal details',
      color: Colors.blue,
    ),
    ProfileOption(
      icon: Icons.notifications_outlined,
      title: 'Notifications',
      subtitle: 'Manage your notification preferences',
      color: Colors.orange,
    ),
    ProfileOption(
      icon: Icons.lock_outline,
      title: 'Privacy & Security',
      subtitle: 'Manage your account security',
      color: Colors.purple,
    ),
    ProfileOption(
      icon: Icons.payment_outlined,
      title: 'Payment Methods',
      subtitle: 'Add or update payment options',
      color: Colors.green,
    ),
    ProfileOption(
      icon: Icons.help_outline,
      title: 'Help & Support',
      subtitle: 'Get help or contact support',
      color: Colors.red,
    ),
    ProfileOption(
      icon: Icons.info_outline,
      title: 'About Green Fields',
      subtitle: 'Learn more about our mission',
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Header with Gradient
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green, Colors.green.shade700],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Background Pattern
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.eco, size: 150, color: Colors.white),
                    ),
                  ),

                  // Profile Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Image/Icon
                        GestureDetector(
                          onTap: _changeProfileImage,
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: userData['profileImage'] == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.green,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          userData['profileImage']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // User Name
                        Text(
                          userData['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // User Email
                        Text(
                          userData['email'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Edit Profile Button
                        OutlinedButton(
                          onPressed: () => _showEditProfileDialog(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Eco Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 18,
                mainAxisSpacing: 20,
                children: [
                  _buildStatCard(
                    title: 'Total Pickups',
                    value: stats['totalPickups'].toString(),
                    icon: Icons.local_shipping,
                    color: Colors.blue,
                    subtitle: 'Completed',
                  ),
                  _buildStatCard(
                    title: 'Kg Recycled',
                    value: stats['kgRecycled'].toString(),
                    icon: Icons.recycling,
                    color: Colors.green,
                    subtitle: 'Environmental Impact',
                  ),
                  _buildStatCard(
                    title: 'Eco Points',
                    value: stats['ecoPoints'].toString(),
                    icon: Icons.emoji_events,
                    color: Colors.amber,
                    subtitle: 'Your Score',
                  ),
                  _buildStatCard(
                    title: 'Current Streak',
                    value: '${stats['streakDays']} days',
                    icon: Icons.flash_on,
                    color: Colors.orange,
                    subtitle: 'Keep it up!',
                  ),
                ],
              ),
            ),

            // Profile Information Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Profile Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: userData['email'],
                  ),
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: userData['phone'],
                  ),
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Address',
                    value: userData['address'],
                  ),
                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    title: 'Member Since',
                    value: _formatDate(userData['memberSince']),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings Options
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  ...profileOptions.map(
                    (option) => _buildSettingOption(option),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Community Rank Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade100, Colors.green.shade50],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.leaderboard,
                      color: Colors.green,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Community Rank',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stats['communityRank'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.9, // 90% progress
                          backgroundColor: Colors.green.shade100,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Next rank: Eco Champion',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () => _showShareDialog(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: Colors.green),
                        SizedBox(width: 12),
                        Text(
                          'Share Green Fields',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 12),
                        Text('Logout', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),

            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _editInfoField(title),
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption(ProfileOption option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: option.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(option.icon, color: option.color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  option.subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    // Simple date formatting
    final parts = date.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    }
    return date;
  }

  void _changeProfileImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: const Text('Choose an option to update your profile picture'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement camera functionality
              Navigator.pop(context);
            },
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () {
              // Implement gallery functionality
              Navigator.pop(context);
            },
            child: const Text('Choose from Gallery'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userData['name']),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userData['email']),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userData['phone']),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userData['address']),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Save changes logic
              setState(() {
                // Update user data
              });
              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _editInfoField(String field) {
    // Implement specific field editing
    print('Editing $field');
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.share, size: 50, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Share Green Fields',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Help spread awareness about sustainable waste management!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 28),
              Column(
                children: [
                  _buildShareOption(
                    icon: Icons.message,
                    label: 'Share via Message',
                    onTap: () {
                      // Implement message sharing
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildShareOption(
                    icon: Icons.email,
                    label: 'Share via Email',
                    onTap: () {
                      // Implement email sharing
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildShareOption(
                    icon: Icons.link,
                    label: 'Copy Link',
                    onTap: () {
                      // Implement copy link
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text('Logout'),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class ProfileOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
