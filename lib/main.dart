import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFDB58),
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 20),
            _buildNavigationButton(context),
            const SizedBox(height: 30),
            _buildDescriptionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      "images/cat.jpeg",
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Welcome to my To Do list app!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ToDoPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'To Do List',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: const Color(0xFFFFC0CB),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: const Text(
            'About This App',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          children: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'This is my first Flutter app. It is a little rough at the moment but it is a starting place. Currently I have a home page (which you are currently on) and a to do list page that will allow you to make a to do list.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Defines the new page
class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController _taskController = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];
  //_taskController: Tracks what the user types into the input box.
  //_tasks: A list of tasks, each one has a title and a done status.

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'title': _taskController.text, 'done': false});
        _taskController.clear();
      });
      _saveTasks();
    }
  }
  //Adds a new task if the input box isn’t empty.
  //Clears the input box and saves the list.

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
    _saveTasks();
  }
  //When the checkbox is clicked, toggles the task between done/not done.

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
  //Called when the page is first created.
  //Loads saved tasks from storage.

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      setState(() {
        _tasks = List<Map<String, dynamic>>.from(json.decode(tasksString));
      });
    }
  }
  //Gets saved tasks (as JSON string), decodes them back into a list.

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString = json.encode(_tasks);
    await prefs.setString('tasks', tasksString);
  }
  //Saves the current list of tasks to storage (as a JSON string).

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }
  //Removes a task from the list and saves the change.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFFFDB58),
      //Sets up the To-Do List page with a pink app bar and yellow background.
      body: Padding(
      padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //Adds padding and starts a column layout for input + task list.
            Card(
              color: Colors.white,
              //White card that contains the task input field and the add button.
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          hintText: 'Enter a task...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: _addTask,
                      //Button to add the typed task.
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                //Shows a scrollable list of task cards.
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: _tasks[index]['done'],
                        onChanged: (value) => _toggleTask(index),
                      ),
                      title: Text(
                        _tasks[index]['title'],
                        style: TextStyle(
                          decoration: _tasks[index]['done']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                        //Each task is shown as a card:
                        //
                        // Checkbox to mark done
                        //
                        // Task text
                        //
                        // Delete button
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}