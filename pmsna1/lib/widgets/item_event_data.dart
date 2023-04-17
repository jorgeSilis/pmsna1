import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class EventData extends StatefulWidget {
  const EventData({super.key, required this.event});
  final Event? event;

  @override
  State<EventData> createState() => _EventDataState();
  Event getevent() {
    return event!;
  }
}

class _EventDataState extends State<EventData> {
  DatabaseHelper? database;
  late Event event;
  @override
  void initState() {
    super.initState();
    event = widget.event!;
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: ${event.title}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Begins: ${event.initDate.toString()}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text('Ends: ${event.endDate.toString()}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description:',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(event.dscEvent ?? "Without Description? :)",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/edit_event', arguments: event);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  print(event.idEvent);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Confirm delete'),
                            content:
                                const Text('Do you want to delete the event?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    database
                                        ?.DELETE_EVENT(
                                            'tblEvent', event.idEvent!)
                                        .then((value){
                                          print(event.idEvent);
                                          var msg = value > 0 ? 'Changes updated' : 'Error';
                                          var snackBar = SnackBar(content: Text(msg));
                                          flag.setFlag_eventList();
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'))
                            ],
                          ));
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
