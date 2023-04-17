import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';
import '../widgets/event_form.dart';
import '../widgets/item_event_data.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  DatabaseHelper? database;
  bool view = true;
  late List<CalendarEventData> events;

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
  }

  void event_modal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: const FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.7,
                child: EventForm(),
              ));
        });
  }


  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: flag.getFlag_eventList() == true
            ? database!.GETALLEVENTS()
            : database!.GETALLEVENTS(),
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            List<CalendarEventData> events =
                Event.getEventList(snapshot.data as List<Event>);
            return CalendarControllerProvider(
              controller: EventController()..addAll(events),
              child: MaterialApp(
                home: Scaffold(
                  floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      onPressed: () {
                        event_modal();
                      },
                      label: const Text('Add new event'),
                      icon: const Icon(Icons.calendar_month_outlined)),
                  appBar: AppBar(title: const Text('Events'), actions: [
                    IconButton(
                      icon: view
                          ? const Icon(
                              Icons.calendar_month_outlined,
                            )
                          : const Icon(
                              Icons.event_note,
                            ),
                      onPressed: () {
                        view = view ? false : true;
                        setState(() {});
                      },
                    )
                  ]),
                  body: view
                      ? MonthView()
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var event = snapshot.data![index];
                            return EventData(
                              event: event,
                            );
                          },
                        ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error")));
          } else {
            return const CircularProgressIndicator.adaptive();
          }
          throw '';
        },
      ),
    );
  }
}