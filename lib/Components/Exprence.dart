import 'package:flutter/material.dart';

class ExperienceAdditionPage extends StatefulWidget {
  final List<Map<String, dynamic>> initialExperience;

  ExperienceAdditionPage({Key? key, required this.initialExperience})
      : super(key: key);

  @override
  _ExperienceAdditionPageState createState() => _ExperienceAdditionPageState();
}

class _ExperienceAdditionPageState extends State<ExperienceAdditionPage> {
  late List<Map<String, dynamic>> experiences;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = [
    for (int y = DateTime.now().year; y >= 1970; y--) y.toString()
  ];

  @override
  void initState() {
    super.initState();
    experiences = widget.initialExperience.isNotEmpty
        ? List<Map<String, dynamic>>.from(widget.initialExperience)
        : [_emptyExperience()];
  }

  Map<String, dynamic> _emptyExperience() => {
    'title': '',
    'company': '',
    'duration': {
      'start': {'month': months[0], 'year': years[0]},
      'end': {'month': months[0], 'year': years[0]}
    }
  };

  void _addExperience() {
    setState(() {
      experiences.add(_emptyExperience());
    });
  }

  void _removeExperience(int index) {
    if (experiences.length > 1) {
      setState(() {
        experiences.removeAt(index);
      });
    }
  }

  Widget _buildExperienceItem(int index) {
    var exp = experiences[index];
    TextEditingController titleController =
    TextEditingController(text: exp['title']);
    TextEditingController companyController =
    TextEditingController(text: exp['company']);
    String startMonth = exp['duration']['start']['month'];
    String startYear = exp['duration']['start']['year'];
    String endMonth = exp['duration']['end']['month'];
    String endYear = exp['duration']['end']['year'];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Experience ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (val) => experiences[index]['title'] = val,
            ),
            SizedBox(height: 10),
            TextField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Company'),
              onChanged: (val) => experiences[index]['company'] = val,
            ),
            SizedBox(height: 10),
            Text('Start Date'),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: startMonth,
                    items: months
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        experiences[index]['duration']['start']['month'] = val!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: startYear,
                    items: years
                        .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        experiences[index]['duration']['start']['year'] = val!;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Text('End Date'),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: endMonth,
                    items: months
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        experiences[index]['duration']['end']['month'] = val!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: endYear,
                    items: years
                        .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        experiences[index]['duration']['end']['year'] = val!;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: experiences.length > 1 ? Colors.red : Colors.grey),
                onPressed: experiences.length > 1 ? () => _removeExperience(index) : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save() {
    Navigator.pop(context, experiences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Experience'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _save),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          ...experiences.asMap().entries.map((e) => _buildExperienceItem(e.key)),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Experience'),
            onPressed: _addExperience,
          )
        ],
      ),
    );
  }
}