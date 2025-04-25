import 'package:fany_masr/login.dart';
import 'package:flutter/material.dart';
// Ensure this file contains the LoginPage class

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '0123456789',
      'role': 'مستخدم',
      'status': 'نشط',
    },
    // Add more users as needed
  ];

  final List<Map<String, dynamic>> _reservations = [
    {
      'id': '1',
      'userName': 'أحمد محمد',
      'service': 'صيانة تكييف',
      'date': '2024-03-20',
      'time': '10:00',
      'status': 'قيد الانتظار',
    },
    // Add more reservations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم المشرف'),
        backgroundColor: const Color(0xFFB71C1C),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          NavigationRail(
            extended: MediaQuery.of(context).size.width >= 800,
            backgroundColor: Colors.white,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFB71C1C),
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'المشرف',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('لوحة التحكم'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('المستخدمين'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('الحجوزات'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('الإعدادات'),
              ),
            ],
          ),
          // Main Content
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildUsersList();
      case 2:
        return _buildReservationsList();
      case 3:
        return _buildSettings();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'لوحة التحكم',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard(
                  'إجمالي المستخدمين',
                  _users.length.toString(),
                  Icons.people,
                  Colors.blue,
                ),
                _buildStatCard(
                  'الحجوزات النشطة',
                  _reservations.length.toString(),
                  Icons.calendar_today,
                  Colors.green,
                ),
                _buildStatCard(
                  'الحجوزات المعلقة',
                  '5',
                  Icons.pending_actions,
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'المستخدمين',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement add user
                },
                icon: const Icon(Icons.add),
                label: const Text('إضافة مستخدم'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFB71C1C),
                      child: Text(
                        user['name'][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(user['name']),
                    subtitle: Text(user['email']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // TODO: Implement edit user
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // TODO: Implement delete user
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الحجوزات',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: ListView.builder(
                itemCount: _reservations.length,
                itemBuilder: (context, index) {
                  final reservation = _reservations[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFB71C1C),
                      child: Icon(Icons.calendar_today, color: Colors.white),
                    ),
                    title: Text(reservation['userName']),
                    subtitle: Text(
                      '${reservation['service']} - ${reservation['date']} ${reservation['time']}',
                    ),
                    trailing: Chip(
                      label: Text(
                        reservation['status'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFB71C1C),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الإعدادات',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('الإشعارات'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Implement notifications toggle
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('اللغة'),
                  trailing: const Text('العربية'),
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('الأمان'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('المساعدة والدعم'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
