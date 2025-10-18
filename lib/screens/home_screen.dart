import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../data/dummy_courses.dart'; // your course data file
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  List<Map<String, dynamic>> filteredCourses = [];
  String selectedCategory = 'All';
  Set<String> categories = {'All'};

  final Set<String> bookmarkedCourses = {};
  String username = "Hifsa"; // This should be dynamically fetched if needed

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    categories.addAll(dummyCourses.map((c) => c['category'] as String).toSet());
    filteredCourses = List.from(dummyCourses);
    _searchController.addListener(_filterCourses);
  }

  void _filterCourses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCourses = dummyCourses.where((course) {
        final matchesCategory = selectedCategory == 'All' || course['category'] == selectedCategory;
        final matchesSearch = course['title'].toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    _filterCourses();
  }

  void _toggleBookmark(String title) {
    setState(() {
      if (bookmarkedCourses.contains(title)) {
        bookmarkedCourses.remove(title);
      } else {
        bookmarkedCourses.add(title);
      }
    });
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _searchController.text = val.recognizedWords;
              _filterCourses();
            });
          },
          localeId: 'en_US',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileScreen = const Center(child: Text('Profile Screen'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel LearnHub'),
        automaticallyImplyLeading: false,
      ),
      body: _selectedIndex == 0 ? _buildHomeContent() : profileScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message and tagline
          Text(
            'Welcome, $username 👋',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Continue your learning journey!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Search bar with mic button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for courses...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 24,
                backgroundColor: _isListening ? Colors.orange : Colors.grey[300],
                child: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.white : Colors.black54,
                  ),
                  onPressed: _listen,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          // Category filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => _onCategorySelected(cat),
                    selectedColor: Colors.orange,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Course list
          Expanded(
            child: filteredCourses.isEmpty
                ? const Center(child: Text('No courses found.'))
                : ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      final title = course['title'] as String;
                      return CourseCard(
                        title: title,
                        level: course['level'],
                        lessons: course['lessons'],
                        hours: course['hours'],
                        progress: course['progress'] ?? 0.0,
                        isBookmarked: bookmarkedCourses.contains(title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseDetailScreen(
                                courseTitle: title,
                                level: course['level'],
                                lessons: course['lessons'],
                                hours: course['hours'],
                              ),
                            ),
                          );
                        },
                        onBookmarkToggle: () => _toggleBookmark(title),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
