
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class Event {
  int? idEvent;
  String title;
  String? dscEvent;
  DateTime initDate;
  DateTime endDate;
  int status;
  late Color color;

  Event(
      {this.idEvent,
      required this.title,
      required this.initDate,
      required this.endDate,
      this.dscEvent,
      required this.status}) {
    color = setEventColor(endDate, status);
  }
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        idEvent: map['idEvent'],
        title: map['title'],
        dscEvent: map['dscEvent'],
        initDate: DateTime.parse(map['initDate']),
        endDate: DateTime.parse(map['endDate']),
        status: map['status']);
  }

  static List<CalendarEventData> getEventList(List<Event> events) {
    List<CalendarEventData<Event>> calendarEvents = [];
    for (var event in events) {
      calendarEvents.add(CalendarEventData(
          title: event.title,
          startTime: event.initDate,
          endTime: event.endDate,
          date: event.initDate,
          description: event.dscEvent ?? "",
          color: event.color));
    }
    return calendarEvents;
  }

  Color setEventColor(DateTime endTime, int status) {
    if (endTime.difference(DateTime.now()).inSeconds < 0 && status == 0) {
      return Colors.red;
    }
    if (endTime.difference(DateTime.now()).inDays <= 0) {
      return Colors.green;
    }
    if (endTime.difference(DateTime.now()).inDays <= 2) {
      return Colors.yellow;
    }
    return Colors.blue;
  }
}