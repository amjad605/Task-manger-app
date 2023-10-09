import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Const/Constants.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Cubit/Todo_States.dart';
import 'package:untitled3/Model/Task.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Map<String, List<Task>> Events;
  late final ValueNotifier<List<Task>> _selectedEvents;
  @override
  void initState() {
    _selectedEvents =
        ValueNotifier(Todo_Cubit.get(context).getevents(DateTime.now()));
    super.initState();
    Events = {};
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_Cubit, Todo_States>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        // backgroundColor: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  eventLoader: (day) => Todo_Cubit.get(context).getevents(day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      HapticFeedback.lightImpact();
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        Todo_Cubit.get(context).GetAllTasks();

                        _selectedEvents.value =
                            Todo_Cubit.get(context).getevents(selectedDay);
                        Todo_Cubit.get(context).DatedTasks(selectedDay);

                        // print(Today.toString().split(" ")[0]);
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              SizedBox(
                height: 290,
                child: ConditionalBuilder(
                    builder: (context) => Container(
                          child: ListView.separated(
                              itemBuilder: (context, index) => item(
                                    Todo_Cubit.get(context).Datetask[
                                        DateFormat.yMMMd().format(
                                            Todo_Cubit.get(context)
                                                .Today)]![index],
                                  ),
                              separatorBuilder: (context, builder) => Padding(
                                    padding: const EdgeInsets.only(left: 90.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      //color: Colors.black,
                                    ),
                                  ),
                              itemCount: Todo_Cubit.get(context).Datetask[
                                          DateFormat.yMMMd().format(
                                              Todo_Cubit.get(context).Today)] ==
                                      null
                                  ? 0
                                  : Todo_Cubit.get(context)
                                      .Datetask[DateFormat.yMMMd().format(
                                          Todo_Cubit.get(context).Today)]!
                                      .length),
                        ),
                    condition: Todo_Cubit.get(context).Datetask[
                                DateFormat.yMMMd()
                                    .format(Todo_Cubit.get(context).Today)] ==
                            null
                        ? false
                        : Todo_Cubit.get(context)
                            .Datetask[DateFormat.yMMMd()
                                .format(Todo_Cubit.get(context).Today)]!
                            .isNotEmpty,
                    fallback: (context) => SingleChildScrollView(
                          child: Container(
                              //color: Colors.black,
                              child: const SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 40.0, top: 30),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/NotaskToday.png"),
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Text(
                                  "Hooray!",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'RobotoMono'),
                                ),
                                Text(
                                  "You Have a Free day",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                )
                              ],
                            ),
                          )),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
