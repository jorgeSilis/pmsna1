import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

DateTime get _now => DateTime.now();

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  DatabaseHelper? database;

  DateTime selectedDate = DateTime(
    _now.year,
    _now.month,
    _now.day,
  );
  DateTime selectedEndDate = DateTime(_now.year, _now.month, _now.day);
  TimeOfDay initHour =
      TimeOfDay(hour: _now.add(const Duration(hours: 1)).hour, minute: 00);
  TimeOfDay endHour =
      TimeOfDay(hour: _now.add(const Duration(hours: 2)).hour, minute: 00);

  late TextEditingController date = TextEditingController(
      text: "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
  late TextEditingController date2 = TextEditingController(
      text:
          "${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}");
  late TextEditingController time =
      TextEditingController(text: initHour.format(context));
  late TextEditingController time2 =
      TextEditingController(text: endHour.format(context));
  TextEditingController title = TextEditingController(text: "New Event");
  TextEditingController desc = TextEditingController(text: "Event!");
  bool simpleDate = true;

  late Event created;
  Event? selected;
  late String aux;

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
  }

  Future<void> _selectInitDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        (picked.day >= _now.day ||
            picked.month >= _now.month ||
            picked.year >= _now.year)) {
      setState(() {
        if (simpleDate && (!selectedDate.compareWithoutTime(picked))) {
          selectedDate =
              DateTime(picked.year, picked.month, picked.day, 00, 00);
        } else {
          selectedDate = DateTime(
              picked.year, picked.month, picked.day, _now.hour, _now.minute);
        }
        date.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        (picked.day >= selectedDate.day ||
            picked.month >= selectedDate.month ||
            picked.year >= selectedDate.year)) {
      setState(() {
        selectedEndDate = DateTime(picked.year, picked.month, picked.day);
        date2.text = "${selectedEndDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectHour(BuildContext context) async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: initHour,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked2 != null &&
        (picked2.minute > TimeOfDay.now().minute ||
            picked2.hour > TimeOfDay.now().hour)) {
      setState(() {
        //initHour = TimeOfDay(hour: picked2.hour, minute: picked2.minute);
        //time.text = initHour.format(context);
        selectedDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, picked2.hour, picked2.minute);
        time.text = TimeOfDay.fromDateTime(selectedDate).format(context);
      });
    }
  }

  Future<void> _selectEndHour(BuildContext context) async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: endHour,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked2 != null &&
        (picked2.minute > initHour.minute || picked2.hour > initHour.hour)) {
      setState(() {
        //endHour = TimeOfDay(hour: picked2.hour, minute: picked2.minute);
        //time2.text = endHour.format(context);
        selectedEndDate = DateTime(selectedEndDate.year, selectedEndDate.month,
            selectedEndDate.day, picked2.hour, picked2.minute);
        time2.text = TimeOfDay.fromDateTime(selectedEndDate).format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      selected = ModalRoute.of(context)!.settings.arguments as Event;
      selectedDate = selected!.initDate;
      selectedEndDate = selected!.endDate;

      date.text = "${selectedDate.toLocal()}".split(' ')[0];
      date2.text = "${selectedEndDate.toLocal()}".split(' ')[0];
      time.text = TimeOfDay.fromDateTime(selectedDate).format(context);
      time2.text = TimeOfDay.fromDateTime(selectedEndDate).format(context);
      desc.text = selected!.dscEvent ?? "";
      title.text = selected!.title;
    }
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    aux = selected != null ? 'Edit event' : 'New event';
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aux,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // Lógica para cerrar la vista o pantalla actual
                  },
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Date of event",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: date,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Pick a date',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    _selectInitDate(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    shape: const CircleBorder(),
                    minimumSize: const Size(40, 40),
                  ),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                  ),
                ),
              ],
            ),
            !simpleDate
                ? Column(
                    children: [
                      Row(
                        children: [
                          TextField(
                            controller: time,
                            readOnly: true,
                            decoration: const InputDecoration(
                                constraints: BoxConstraints(maxWidth: 150)),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.timer,
                            ),
                            onPressed: () {
                              _selectHour(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextField(
                            controller: date2,
                            readOnly: true,
                            decoration: const InputDecoration(
                                constraints: BoxConstraints(maxWidth: 150)),
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                            onPressed: () {
                              _selectEndDate(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextField(
                            controller: time2,
                            readOnly: true,
                            decoration: const InputDecoration(
                                constraints: BoxConstraints(maxWidth: 150)),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.timer,
                            ),
                            onPressed: () {
                              _selectEndHour(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 1.0,
                  ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Description",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: desc,
                readOnly: false,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Event Description',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            selected != null
                ? Row(
                    children: [
                      const Text("Finishied",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                          )),
                      Checkbox(
                        value: selected?.status == 1,
                        onChanged: (value) {
                          setState(() {
                            selected?.status = value! ? 1 : 0;
                          });
                        },
                      )
                    ],
                  )
                : const SizedBox(
                    height: 1.0,
                  ),
            ElevatedButton(
              onPressed: () => {
                if (selected == null)
                  {
                    created = Event(
                        title: title.text,
                        initDate: selectedDate,
                        dscEvent: desc.text,
                        endDate: simpleDate
                            ? DateTime(selectedDate.year, selectedDate.month,
                                selectedDate.day, 23, 59, 59)
                            : selectedEndDate,
                        status: 0),
                    database?.INSERT('tblEvent', {
                      'title': created.title,
                      'dscEvent': created.dscEvent,
                      'initDate': created.initDate.toIso8601String(),
                      'endDate': created.endDate.toIso8601String(),
                      'status': 0
                    }).then((value) {
                      var msg = value > 0 ? 'Event Saved' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      flag.setFlag_eventList();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    })
                  }
                else
                  {
                    selected!.title = title.text,
                    selected!.dscEvent = desc.text,
                    selected!.initDate = selectedDate,
                    selected!.endDate = simpleDate
                        ? DateTime(selectedDate.year, selectedDate.month,
                            selectedDate.day, 23, 59, 59)
                        : selectedEndDate,
                    database?.UPDATE_EVENT('tblEvent', {
                      'idEvent': selected!.idEvent,
                      'title': selected!.title,
                      'dscEvent': selected!.dscEvent,
                      'initDate': selected!.initDate.toIso8601String(),
                      'endDate': selected!.endDate.toIso8601String(),
                      'status': selected!.status
                    }).then((value) {
                      var msg = value > 0 ? 'Changes updated' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      flag.setFlag_eventList();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    })
                  }
              },
              child: const Text('Save'),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
