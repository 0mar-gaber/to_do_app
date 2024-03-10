void main() {
  // Create a map of lists
  Map<String, List<String>> mapOfLists = {
    'numbers': ['1', '2', '3'],
    'letters': ['a', 'b', 'c'],
    'evenNumbers': ['2', '4', '6'],
  };

  // Function to add a key and value to the map
  void addOrUpdateList(String key, String value) {
    if (mapOfLists.containsKey(key)) {
      // If the key already exists, append the value to the existing list
      mapOfLists[key]!.add(value);
    } else {
      // If the key doesn't exist, create a new list with the value
      mapOfLists[key] = [value];
    }
  }

  // Add or update the lists with new values
  addOrUpdateList('numbers', '4');
  addOrUpdateList('colors', 'red');
  addOrUpdateList('letters', 'd');

  // Print the updated map of lists
  print('Updated Map of Lists: $mapOfLists');
}
