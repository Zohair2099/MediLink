import 'package:flutter/material.dart';

// Screens
import 'home_screen.dart';
import 'medical_records_system_screen.dart';
import 'screens/smart_emergency_mode_screen.dart';
import 'screens/emergency_access_mode_screen.dart';
import 'screens/add_record_screen.dart';
import 'screens/reports_folder_screen.dart';
import 'screens/prescriptions_folder_screen.dart';
import 'screens/medibot_screen.dart';

void main() {
  runApp(const MedicalRecordsApp());
}

class MedicalRecordsApp extends StatelessWidget {
  const MedicalRecordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Records System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const HomeScreenWithDrawer(),
      routes: {
        '/reports': (context) => const ReportsFolderScreen(),
'/prescriptions': (context) => const PrescriptionsFolderScreen(),
'/medibot': (context) => const MedibotScreen(),
      },
    );
  }
}

class HomeScreenWithDrawer extends StatefulWidget {
  const HomeScreenWithDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenWithDrawer> createState() => _HomeScreenWithDrawerState();
}

class _HomeScreenWithDrawerState extends State<HomeScreenWithDrawer> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const HomeScreen(),
    const MedicalRecordsSystemScreen(),
    const SmartEmergencyModeScreen(),
    const EmergencyAccessModeScreen(),
    const AddRecordScreen(),
  ];

  static final List<String> _titles = [
    'Home',
    'Medical Records System',
    'Smart Emergency Mode',
    'Emergency Access Mode',
    'Add Record',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Medical Records App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', 0),
            _buildDrawerItem(Icons.folder_shared, 'Medical Records System', 1),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('MediBot (AI Chatbot)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/medibot');
              },
            ),
            _buildDrawerItem(Icons.warning_amber, 'Smart Emergency Mode', 2),
            _buildDrawerItem(Icons.map_outlined, 'Emergency Access Mode', 3),
            _buildDrawerItem(Icons.add_circle_outline, 'Add Record', 4),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _onItemTapped(index),
    );
  }
}
