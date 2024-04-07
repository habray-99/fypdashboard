import 'package:flutter/material.dart';
import 'package:fypdashboard/views/dashboard/sidebar.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  // Sample data
  final List<Map<String, dynamic>> data = [
    {'name': 'John Doe', 'age': 30, 'city': 'New York'},
    {'name': 'Jane Doe', 'age': 25, 'city': 'Los Angeles'},
    // Add more data as needed
  ];

  // This list will hold the filtered data
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredData with the original data
    filteredData = List.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Data Table with Search'),
      // ),
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      // Update the list based on the search input
                      setState(() {
                        filteredData = data
                            .where((item) => item['name']
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
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
                      rows: filteredData
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
          ),
        ],
      ),
    );
  }
}
