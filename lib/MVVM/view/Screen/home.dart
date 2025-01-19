import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machine_test1/MVVM/model/service/firebaseAuthservices.dart';
import 'package:machine_test1/MVVM/view/Screen/login.dart';

class Student {
  final String name;
  final String fieldOfExpertise;

  Student({required this.name, required this.fieldOfExpertise});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [
    Student(name: "Alice", fieldOfExpertise: "Flutter"),
    Student(name: "Bob", fieldOfExpertise: "UI/UX"),
    Student(name: "Charlie", fieldOfExpertise: "MERN"),
    Student(name: "David", fieldOfExpertise: "Digital Marketing"),
  ];

  String searchQuery = "";
  String selectedCategory = "All";
  bool isSortedByName = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = "";

  @override
  void initState() {
    super.initState();
    userName = _auth.currentUser?.displayName ?? _auth.currentUser?.email ?? "Guest";
  }

  List<Student> get filteredStudents {
    List<Student> filteredList = students;

    if (selectedCategory != "All") {
      filteredList = filteredList
          .where((student) => student.fieldOfExpertise == selectedCategory)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList
          .where((student) =>
              student.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    filteredList.sort((a, b) {
      if (isSortedByName) {
        return a.name.compareTo(b.name);
      } else {
        return a.fieldOfExpertise.compareTo(b.fieldOfExpertise);
      }
    });

    return filteredList;
  }

  Future<void> logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $userName"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: ()async {
              await Firebaceservices().signout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: "Search by name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              items: ["All", "Flutter", "UI/UX", "MERN","Digital marketing"]
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Sort by:"),
                IconButton(
                  icon: Icon(isSortedByName
                      ? Icons.sort_by_alpha
                      : Icons.category),
                  onPressed: () {
                    setState(() {
                      isSortedByName = !isSortedByName;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(student.name),
                    subtitle: Text(student.fieldOfExpertise),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
