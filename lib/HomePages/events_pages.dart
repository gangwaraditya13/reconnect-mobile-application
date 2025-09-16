import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconnect/Components/event_post.dart';

import '../repos/user_repo.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<dynamic> allEvents = [];
  String? selectedStatus = "All";
  String? selectedDate = "All Dates";
  bool isLoading = true;

  final ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3000/api');

  String formatDate(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    setState(() {
      isLoading = true;
    });
    var events = await apiService.getEvents();
    setState(() {
      allEvents = events ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dateOptions = allEvents
        .map((event) => formatDate(event["date"] ?? ""))
        .toSet()
        .toList();
    dateOptions.sort();
    dateOptions.insert(0, "All Dates");

    List<Map<String, dynamic>> filteredEvents = allEvents.where((event) {
      final eventDate = event["date"] != null ? formatDate(event["date"]) : '';
      final matchesStatus =
          selectedStatus == "All" || event["status"] == selectedStatus;
      final matchesDate =
          selectedDate == "All Dates" || eventDate == selectedDate;
      return matchesStatus && matchesDate;
    }).cast<Map<String, dynamic>>().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Status",
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                    ),
                    value: selectedStatus,
                    items: [
                      "All",
                      "upcoming",
                      "ongoing",
                      "completed",
                      "cancelled"
                    ]
                        .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value ?? "All";
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    value: selectedDate,
                    items: dateOptions
                        .map((date) =>
                        DropdownMenuItem(value: date, child: Text(date)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDate = value ?? "All Dates";
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return EventPost(
                  title: event["title"],
                  date: event["date"],
                  description: event["description"],
                  location: event["location"],
                  status: event["status"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}