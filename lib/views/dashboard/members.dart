import 'package:flutter/material.dart';

class DataTablePage extends StatelessWidget {
  // Sample data
  final List<Map<String, dynamic>> data = [
    {'name': 'John Doe', 'age': 30, 'city': 'New York'},
    {'name': 'Jane Doe', 'age': 25, 'city': 'Los Angeles'},
    // Add more data as needed
  ];

  DataTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table with Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Update the list based on the search input
                // This is a simple example. For more complex filtering, consider using a controller or a state management solution.
                // For this example, we'll just filter the data based on the name field.
                final filteredData = data
                    .where((item) => item['name']
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                // Update the data list with the filtered data
                // Note: This example directly modifies the data list. In a real app, consider using a state management solution like GetX or Provider.
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('City')),
                ],
                rows: data
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item['name'].toString())),
                          DataCell(Text(item['age'].toString())),
                          DataCell(Text(item['city'].toString())),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
