import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';

class TodoHomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  TodoHomePage({required this.onToggleTheme});

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _todos = [];
  final List<String> _filters = ['All', 'Active', 'Completed'];
  String _selectedFilter = 'All';

  // A palette of light colors for cards
  final List<Color> _cardColors = [
    Colors.amber.shade100,
    Colors.lightBlue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
  ];

  void _addTodo() async {
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String input = '';
        return AlertDialog(
          title: Text('New Task'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter task title'),
            onChanged: (v) => input = v,
            onSubmitted: (_) => Navigator.of(ctx).pop(input),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(input), child: Text('Add')),
          ],
        );
      },
    );

    if (title != null && title.trim().isNotEmpty) {
      setState(() => _todos.add(Todo(title: title.trim())));
    }
  }

  List<Todo> get _filteredTodos {
    switch (_selectedFilter) {
      case 'Active':
        return _todos.where((t) => !t.isDone).toList();
      case 'Completed':
        return _todos.where((t) => t.isDone).toList();
      case 'All':
      default:
        return _todos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with theme-toggle and add buttons
      appBar: AppBar(
        title: Text('To Do App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.add_task),
            tooltip: 'Add Task',
            onPressed: _addTodo,
          ),
        ],
      ),

      // FloatingActionButton as another add trigger
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Task',
        onPressed: _addTodo,
      ),

      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('Show:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: _filters.map((f) {
                    return DropdownMenuItem(value: f, child: Text(f));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedFilter = v);
                  },
                ),
              ],
            ),
          ),

          // To-Do List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTodos.length,
              itemBuilder: (ctx, i) {
                final todo = _filteredTodos[i];
                final cardColor = _cardColors[i % _cardColors.length];
                return Card(
                  color: cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: Checkbox(
                      checkColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: MaterialStateProperty.all(
    Theme.of(context).colorScheme.secondary,
  ),
                      value: todo.isDone,
                      onChanged: (v) {
                        setState(() => todo.isDone = v ?? false);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: todo.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      tooltip: 'Remove',
                      onPressed: () {
                        setState(() => _todos.remove(todo));
                      },
                    ),
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