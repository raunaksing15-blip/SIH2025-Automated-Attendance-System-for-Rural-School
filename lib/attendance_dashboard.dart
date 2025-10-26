
import 'package:flutter/material.dart';
import 'package:gurukul_manager/notice_service.dart';
import 'package:gurukul_manager/practical_service.dart';
import 'package:gurukul_manager/subject_service.dart';
import 'package:gurukul_manager/timetable_service.dart';
import 'package:gurukul_manager/attendance_service.dart';

class AttendanceDashboard extends StatefulWidget {
  const AttendanceDashboard({super.key});

  @override
  _AttendanceDashboardState createState() => _AttendanceDashboardState();
}

class _AttendanceDashboardState extends State<AttendanceDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PlaceholderWidget(text: 'Months'),
    SubjectsScreen(),
    TimetableScreen(),
    NoticeScreen(),
    PracticalScreen(),
    AttendanceScreen(), // Replaced placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Months',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Timetable',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Practical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Attendance',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceManager _attendanceManager = AttendanceManager();
  List<Map<String, dynamic>> _attendanceRecords = [];
  bool _isLoading = true;
  // In a real app, this would come from your auth service
  final String _studentId = "STUDENT123";

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    setState(() {
      _isLoading = true;
    });
    var records = await _attendanceManager.getAttendance(_studentId);
    setState(() {
      _attendanceRecords = records;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAttendance,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _attendanceRecords.isEmpty
              ? const Center(child: Text('No attendance records found.'))
              : ListView.builder(
                  itemCount: _attendanceRecords.length,
                  itemBuilder: (context, index) {
                    var record = _attendanceRecords[index];
                    var timestamp = record['timestamp']?['_seconds'];
                    var date = timestamp != null
                        ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
                        : null;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      child: ListTile(
                        title: Text('Course: ${record['course_id']}'),
                        subtitle: Text(
                            'Date: ${date?.toLocal().toString() ?? 'N/A'}'),
                      ),
                    );
                  },
                ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Months and Subjects
              Row(
                children: [
                  Expanded(
                    child: _buildDashboardCard(
                      context,
                      title: 'Months',
                      icon: Icons.calendar_today,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDashboardCard(
                      context,
                      title: 'Subjects',
                      icon: Icons.book,
                      onTap: () {
                        // This will be handled by the BottomNavigationBar
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Timetable
              _buildTitledCard(
                context,
                title: 'Timetable',
                child: Column(
                  children: [
                    _buildTextButton(
                      context,
                      label: "View Today's Schedule",
                      onPressed: () {},
                    ),
                    const Divider(),
                    _buildTextButton(
                      context,
                      label: 'Generate New Day Timetable (AI)',
                      onPressed: () {},
                    ),
                    const Divider(),
                    _buildTextButton(
                      context,
                      label: 'Get Full Timetable',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notice of Holidays
              _buildTitledCard(
                context,
                title: 'Notice of Holidays',
                child: const ListTile(
                  leading: Icon(Icons.holiday_village_outlined),
                  title: Text('No upcoming holidays.'),
                ),
              ),
              const SizedBox(height: 16),

              // Practical Timetable
              _buildTitledCard(
                context,
                title: 'Practical (Timetable)',
                child: const ListTile(
                  leading: Icon(Icons.science_outlined),
                  title: Text('View practical schedules.'),
                ),
              ),
              const SizedBox(height: 16),

              // Attendance
              _buildTitledCard(
                context,
                title: 'Final Attendance',
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('View your final attendance.'),
                    ),
                    const Divider(),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.analytics_outlined),
                      label: const Text('Alpha Attendance Analytics'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title, required IconData icon, VoidCallback? onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(height: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitledCard(BuildContext context,
      {required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context,
      {required String label, VoidCallback? onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final SubjectService _subjectService = SubjectService();
  List<String> _subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _loadSubjects() async {
    List<String> subjects = await _subjectService.getSubjects();
    setState(() {
      _subjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      body: ListView.builder(
        itemCount: _subjects.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(_subjects[index]),
              subtitle: const Text('View assignments'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Handle subject tap
              },
            ),
          );
        },
      ),
    );
  }
}

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final TimetableService _timetableService = TimetableService();
  List<Map<String, dynamic>> _timetable = [];

  @override
  void initState() {
    super.initState();
    _loadTimetable();
  }

  void _loadTimetable() async {
    List<Map<String, dynamic>> timetable =
        await _timetableService.getTimetable();
    setState(() {
      _timetable = timetable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: ListView.builder(
        itemCount: _timetable.length,
        itemBuilder: (context, index) {
          var entry = _timetable[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(entry['subject'] ?? ''),
              subtitle: Text(
                  '${entry['day']} - ${entry['startTime']} to ${entry['endTime']}'),
              trailing: Text(entry['teacher'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final NoticeService _noticeService = NoticeService();
  List<Map<String, dynamic>> _notices = [];

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  void _loadNotices() async {
    List<Map<String, dynamic>> notices = await _noticeService.getNotices();
    setState(() {
      _notices = notices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices'),
      ),
      body: ListView.builder(
        itemCount: _notices.length,
        itemBuilder: (context, index) {
          var notice = _notices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(notice['title'] ?? ''),
              subtitle: Text(notice['message'] ?? ''),
              trailing: Text(notice['date'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}

class PracticalScreen extends StatefulWidget {
  const PracticalScreen({super.key});

  @override
  _PracticalScreenState createState() => _PracticalScreenState();
}

class _PracticalScreenState extends State<PracticalScreen> {
  final PracticalService _practicalService = PracticalService();
  List<Map<String, dynamic>> _practicals = [];

  @override
  void initState() {
    super.initState();
    _loadPracticals();
  }

  void _loadPracticals() async {
    List<Map<String, dynamic>> practicals =
        await _practicalService.getPracticals();
    setState(() {
      _practicals = practicals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practicals'),
      ),
      body: ListView.builder(
        itemCount: _practicals.length,
        itemBuilder: (context, index) {
          var practical = _practicals[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(practical['title'] ?? ''),
              subtitle: Text(practical['description'] ?? ''),
              trailing: Text(practical['date'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  const PlaceholderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
