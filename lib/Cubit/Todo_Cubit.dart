import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/Cubit/Todo_States.dart';
import 'package:untitled3/DataBaseHelper/DBHelper.dart';
import 'package:untitled3/Model/Task.dart';

import 'package:untitled3/Screens/DoneScreen.dart';
import 'package:untitled3/Screens/TaskScreen.dart';
import 'package:untitled3/shared/sharedcomponents.dart';

class Todo_Cubit extends Cubit<Todo_States> {
  bool isdark = true;
  ThemeMode dark = ThemeMode.dark;
  Todo_Cubit() : super(TodoIntialState());
  static Todo_Cubit get(context) => BlocProvider.of(context);
  bool isadd = false;
  DateTime Today = DateTime.now();
  List<Task> t = [];
  Priority pickedvalue = Priority.low;
  Map<String, List<Task>> Datetask = {
    DateFormat.yMMMd().format(DateTime.now()): []
  };
  List<Task> done = [];
  int taskId = 1;
  double prog = 0;
  Color c = Colors.red;
  bool Check = false;
  int currIndex = 0;
  bool validate = false;
  List<Widget> Screen = [
    Tasks(),
    Done(),
  ];
  List<BottomNavigationBarItem> bottomnav = [
    BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: 'TASKS'),
    BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month), label: 'Calender'),
  ];
  void Getvalidate(bool value) {
    validate = value;
    emit(validatestate());
  }

  void GetAllTasks() async {
    t = [];
    Datetask[DateFormat.yMMMd().format(DateTime.now())] = [];
    t = await DataBaseHelper.getallitems();

    Datetask.clear();
    for (var i in _orderedTodos) {
      if (Datetask[i.date] == null) {
        Datetask[i.date] = [];
      }
      if (!(Datetask[i.date]!.contains(i)) && !i.Check) {
        Datetask[i.date]!.add(i);
      }
    }
    ChangeDone();
    changeProgg();
    print('done.length: ${done.length}');
    emit(GetitemsState());
  }

  void ChangeBottomnav(int index) {
    currIndex = index;
    GetAllTasks();

    if (index == 1) {
      DatedTasks(DateTime.now());
    }
    emit(ChangeBottomNavState());
  }

  void AddTask(Task task) {
    DataBaseHelper.insertTask(task);

    GetAllTasks();
  }

  void createDatabase() {
    Datetask[DateFormat.yMMMd().format(DateTime.now())] = [];
    DataBaseHelper.initDB().then((value) {
      GetAllTasks();
    });

    emit(CreateDBState());
  }

  void ChangeCheck(bool b, Task task) {
    task.Check = b;
    if (b) {
      task.status = "done";
    } else {
      task.status = "new";
    }

    emit(CheckBoxState());
  }

  void addtoDone(Task task) {
    done.add(task);
    emit(DoneState());
  }

  void updateDatedDonetasks(Task task) {
    for (final dtask in Datetask.entries) {
      dtask.value.remove(task);
    }
    emit(updateState());
  }

  void addDone(Task task) {
    if (task.Check && task.date == DateFormat.yMMMd().format(DateTime.now())) {
      done.add(task);
    } else {
      done.remove(task);
      done.removeWhere((element) => element.id == task.id);
    }
    emit(DoneState());
  }

  void ChangeDone() {
    done = t
        .where((element) =>
            element.Check &&
            element.date == DateFormat.yMMMd().format(DateTime.now()))
        .toList();
    emit(DoneState());
  }

  void changeProgg() {
    c = Colors.red;
    if (Datetask[DateFormat.yMMMd().format(DateTime.now())] != null) {
      if (Datetask[DateFormat.yMMMd().format(DateTime.now())]!.isEmpty) {
      } else {
        prog = (done.length /
                t
                    .where((element) =>
                        element.date ==
                        DateFormat.yMMMd().format(DateTime.now()))
                    .length) %
            100;
      }
    }
    if (prog >= 0.4) {
      c = Colors.orange;
    }
    if (prog >= 0.7) {
      c = Colors.yellow;
    }
    if (prog == 1) {
      c = Colors.green;
    }
    emit(ProgState());
  }

  void deletitem(Task task, BuildContext context) {
    final index = Datetask[task.date]!.indexOf(task);
    print("Task id : ${task.id}");
    DataBaseHelper.deleteItem(task.id);

    if (Datetask[task.date]!.contains(task)) Datetask[task.date]!.remove(task);
    if (done.contains(task)) {
      done.remove(task);
    }
    if (t.contains(task)) t.remove(task);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text(
        'Task Removed',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey.shade900,
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            Datetask[task.date]!.insert(index, task);
            AddTask(task);
          }),
    ));
    emit(deleteState());
  }

  void DatedTasks(DateTime selected) {
    Today = selected;

    Datetask[DateFormat.yMMMd().format(Today)] = [];

    for (var i in t) {
      if (i.date ==
          DateFormat.yMMMd()
              .format(Today)) if (!Datetask[DateFormat.yMMMd().format(Today)]!
          .contains(i)) Datetask[DateFormat.yMMMd().format(Today)]!.add(i);
    }

    emit(DatedTaskState());
  }

  void added({required bool isadded}) {
    isadd = isadded;
    emit(Addedstate());
  }

  void update(Task task) {
    DataBaseHelper.update(task);
    emit(updateState());
  }

  List<Task> getevents(DateTime day) {
    dynamic list;
    list = Datetask[DateFormat.yMMMd().format(day)]?.toSet().toList();
    return list ?? [];
  }

  Map<Priority, Color> prColor = {
    Priority.urgent: Colors.red,
    Priority.normal: Colors.yellow,
    Priority.low: Colors.blue,
  };

  void OnPickedValue(value) {
    pickedvalue = value;
    emit(PickedValueState());
  }

  String order = 'desc';
  List<Task> get _orderedTodos {
    final sortedTodos = List.of(t);
    sortedTodos.sort((a, b) {
      int bComesAfterA = a.pr.compareTo(b.pr);
      if (bComesAfterA != 0) {
        return order == 'asc' ? bComesAfterA : -bComesAfterA;
      }
      bComesAfterA = a.title.compareTo(b.title);
      return order == 'desc' ? bComesAfterA : -bComesAfterA;
    });
    emit(ChangeorderState());
    return sortedTodos;
  }

  void changeappmode(value) {
    isdark = value ?? true;
    dark = isdark ? ThemeMode.dark : ThemeMode.light;
    Cachehelper.preferences.setBool('isDark', isdark).then((value) {
      emit(ChangeAppModeState());
      print(isdark);
    });
  }

  void changeOrder() {
    order = order == 'asc' ? 'desc' : 'asc';
    GetAllTasks();
    emit(ChangeorderState());
  }
}
