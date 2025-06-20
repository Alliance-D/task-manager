# task_manager

A simple and elegant To-Do List app built using Flutter's `StatefulWidget`, offering task filtering, dynamic theming, and a user-friendly UI.

# Features

- Add, complete, and delete tasks effortlessly  
- Toggle between light and dark mode  (using icon button)
- Filter tasks by All, Active, or Completed (using dropdown button) 
- Colorful card layout with a polished UI

-DropdownButton widget allows users to select a single value from a list, 

DropdownButton<String>(
  value: _selectedFilter,
  items: _filters.map((f) {
    return DropdownMenuItem(value: f, child: Text(f));
  }).toList(),
  onChanged: (v) {
    if (v != null) setState(() => _selectedFilter = v);
  },
),

- value; Defines the currently selected value from the dropdown.	
- items; List of dropdown options constructed from _filters.
- onChanged; Callback when user selects an item; updates _selectedFilter.

-while IconButton provides an interactive icon that can trigger actions like theme toggling or adding tasks.

IconButton(
  icon: Icon(Icons.brightness_6),
  tooltip: 'Toggle Theme',
  onPressed: widget.onToggleTheme,
),

- icon	Sets the icon shown in the button.
- tooltip	Provides a hover/long-press label for accessibility.
- onPressed	Defines the callback when the button is tapped.

# attributes

## DropdownButton;

- isExpanded; When set to true, expands the dropdown to use the full width of its parent container.
- dropdownColor; Changes the background color of the dropdown menu that appears when the button is tapped.
- underline; Allows you to customize or remove the line shown under the dropdown.

## icon button
it was used in the appbar to toggle the teme and to add tasks and deleting them.

- iconSize;	Sets the size in pixels of the icon inside the button, making it appear larger or smaller.
- color; Changes the color of the icon (separate from the button background).
- splashRadius;	Sets the radius of the ripple (splash) animation when the user taps the button.

# Getting Started

1. clone the repo
2. make sure you have all the necessary dependencies by running `flutter pub get`
3. run the app using `flutter run`
