import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Cubit/Todo_States.dart';

import 'package:untitled3/Model/Task.dart';
import 'package:untitled3/Screens/profilescreen.dart';
import 'package:untitled3/Screens/StartScreen.dart';
import 'package:untitled3/Screens/drawer.dart';

class HomeLayout extends StatelessWidget {
  void _showBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) return "title must not be empty";

                      return null;
                    },
                    // style: const TextStyle(color: Colors.white),
                    controller: titleController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit),
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: describtionController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description),
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          enableInteractiveSelection: true,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Start time must not be empty";
                            }
                            return null;
                          },
                          onTap: () {
                            HapticFeedback.lightImpact();
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              startTimeController.text = value!.format(context);
                            });
                          },
                          //style: const TextStyle(color: Colors.white),
                          controller: startTimeController,

                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.access_time_filled_outlined,
                            ),
                            labelText: "Start Time",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40)),
                            //  counterStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          enableInteractiveSelection: true,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Time must not be empty";
                            }
                            return null;
                          },
                          onTap: () {
                            HapticFeedback.lightImpact();
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              endTimeController.text = value!.format(context);
                            });
                          },
                          //style: const TextStyle(color: Colors.white),
                          controller: endTimeController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.access_time_filled_outlined,
                            ),
                            labelText: "End Time",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40)),
                            //  counterStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                labelText: "Priorty",
                                //   counterStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            value: Todo_Cubit.get(ctx).pickedvalue,
                            items: Priority.values
                                .map(
                                  (pr) => DropdownMenuItem(
                                    value: pr,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          pr.name.toUpperCase(),
                                          style: const TextStyle(
                                              //color:
                                              // Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                        ),
                                        Icon(
                                          Icons.flag,
                                          color:
                                              Todo_Cubit.get(ctx).prColor[pr],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              Todo_Cubit.get(ctx).OnPickedValue(value);
                            }),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Date must not be empty ";
                            }
                            return null;
                          },
                          // style: const TextStyle(color: Colors.white),
                          controller: dateController,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-03-20'),
                            ).then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
                            ),
                            labelText: "Date",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            //  counterStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (startTimeController.text.trim().isEmpty ||
                              titleController.text.trim().isEmpty ||
                              dateController.text.trim().isEmpty) {
                            showCupertinoDialog(
                                context: context,
                                builder: (ctx) => CupertinoAlertDialog(
                                      title: const Text(
                                          'Please Make Sure you add all fields'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Okay'))
                                      ],
                                    ));
                            return;
                          }

                          // Todo_Cubit.get(context).Getvalidate(true);
                          var newTask = Task(
                              Todo_Cubit.get(ctx).taskId,
                              titleController.text,
                              startTimeController.text,
                              endTimeController.text,
                              dateController.text,
                              describtionController.text,
                              statusController.text,
                              false,
                              Todo_Cubit.get(ctx).pickedvalue.name);
                          Todo_Cubit.get(context).AddTask(newTask);

                          Navigator.pop(ctx);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            autoHide: const Duration(milliseconds: 1100),
                            title: "",
                            dialogBorderRadius: BorderRadius.circular(40),
                            // dialogBackgroundColor: Colors.black,
                            borderSide: const BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 2.5,
                            ),
                            desc: "Successfully Added",
                            descTextStyle: const TextStyle(
                              fontSize: 30,
                            ),
                          ).show();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.deepPurpleAccent),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(context) {}

  void _showAwsomeDialog(context) {
    AwesomeDialog(
            headerAnimationLoop: false,
            context: context,
            dialogType: DialogType.infoReverse,
            barrierColor: Colors.black,
            animType: AnimType.bottomSlide,
            title: 'ADD TASK',
            desc: 'Dialog description here...',
            descTextStyle: const TextStyle(color: Colors.white),
            titleTextStyle: const TextStyle(color: Colors.white),
            buttonsTextStyle: const TextStyle(color: Colors.white),
            showCloseIcon: false,
            enableEnterKey: true,
            borderSide: const BorderSide(
              color: Colors.deepPurpleAccent,
              width: 2.5,
            ),
            body: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) return "title must not be empty";

                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: titleController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit),
                      prefixIconColor: Colors.white,
                      labelText: "Title",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: describtionController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description),
                      prefixIconColor: Colors.white,
                      labelText: "Description",
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          enableInteractiveSelection: true,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Time must not be empty";
                            }
                            return null;
                          },
                          onTap: () {
                            HapticFeedback.lightImpact();
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              startTimeController.text = value!.format(context);
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: startTimeController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.access_time_filled_outlined,
                              color: Colors.white,
                            ),
                            labelText: "Time",
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40)),
                            counterStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Date must not be empty ";
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: dateController,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-03-20'),
                            ).then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            labelText: "Date",
                            labelStyle: TextStyle(color: Colors.white),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            counterStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Priorty",
                          labelStyle: TextStyle(color: Colors.white),
                          counterStyle: TextStyle(color: Colors.white),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      dropdownColor: Colors.black,
                      value: Todo_Cubit.get(context).pickedvalue,
                      items: Priority.values
                          .map(
                            (pr) => DropdownMenuItem(
                              value: pr,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    pr.name.toUpperCase(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                  Icon(
                                    Icons.flag,
                                    color: Todo_Cubit.get(context).prColor[pr],
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        Todo_Cubit.get(context).OnPickedValue(value);
                      }),
                ],
              ),
            ),
            dialogBorderRadius: BorderRadius.circular(40),
            customHeader: Image.network(
              'https://media.giphy.com/media/UGWe6UilLu4320UccP/giphy.gif',
              width: 150,
              fit: BoxFit.cover,
            ),
            dismissOnBackKeyPress: false,
            btnCancelOnPress: () {
              if (startTimeController.text.trim().isEmpty ||
                  titleController.text.trim().isEmpty ||
                  dateController.text.trim().isEmpty) {
                showCupertinoDialog(
                    context: context,
                    builder: (ctx) => CupertinoAlertDialog(
                          title:
                              const Text('Please Make Sure you add all fields'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showAwsomeDialog(context);
                                },
                                child: Text('Okay'))
                          ],
                        ));
              } else {
                Todo_Cubit.get(context).Getvalidate(true);

                var newTask = Task(
                    Todo_Cubit.get(context).taskId,
                    titleController.text,
                    startTimeController.text,
                    endTimeController.text,
                    dateController.text,
                    describtionController.text,
                    statusController.text,
                    false,
                    Todo_Cubit.get(context).pickedvalue.name);
                Todo_Cubit.get(context).AddTask(newTask);
                if (newTask.date == DateFormat.yMMMd().format(DateTime.now())) {
                  Todo_Cubit.get(context).changeProgg();
                }

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  autoHide: const Duration(milliseconds: 1100),
                  title: "Successfully",
                  dialogBorderRadius: BorderRadius.circular(40),
                  dialogBackgroundColor: Colors.black,
                  borderSide: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 2.5,
                  ),
                  desc: "Successfully Added",
                  descTextStyle: const TextStyle(
                      fontSize: 30, color: Colors.deepPurpleAccent),
                ).show();
              }
            },
            btnCancelColor: Colors.deepPurpleAccent,
            btnCancelText: "ADD",
            dialogBackgroundColor: Colors.grey[900],
            useRootNavigator: false)
        .show();
  }

  final List<String> titles = ["TASK", "DONE", "ARCHIVE"];

  final describtionController = TextEditingController();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final statusController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final scaffoldkey = GlobalKey<ScaffoldState>();

  final formkey = GlobalKey<FormState>();

  HomeLayout({super.key});

  Widget build(BuildContext context) {
    print('home build is called ');
    startTimeController.text =
        DateFormat('hh:mm:a').format(DateTime.now()).toString();

    dateController.text = DateFormat.yMMMd().format(DateTime.now()).toString();

    return BlocConsumer<Todo_Cubit, Todo_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: Todo_Cubit.get(context).currIndex == 0
            ? AppBar(
                leading: Builder(
                  builder: (context) => Column(children: [
                    const SizedBox(
                      height: 8,
                    ),
                    IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu),
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ]),
                ),
                elevation: 0,
                actions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: Hero(
                            tag: 1,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        style: TextButton.styleFrom(iconColor: Colors.white),
                        onPressed: () {
                          Todo_Cubit.get(context).changeOrder();
                        },
                        label: const Text('Priorty',
                            style: TextStyle(color: Colors.white)),
                        icon: Todo_Cubit.get(context).order != 'asc'
                            ? Icon(Icons.arrow_upward)
                            : Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ],
                toolbarHeight: 160,
                title: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(DateFormat.yMMMd().format(DateTime.now())
                            as String),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 45.0),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "${Todo_Cubit.get(context).Datetask[DateFormat.yMMMd().format(DateTime.now())]?.length ?? 0} | ${Todo_Cubit.get(context).done.length} Tasks",
                    //         style: const TextStyle(fontSize: 15),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.values.last,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                "Progresss",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 83,
                              ),
                              Text(
                                "${(Todo_Cubit.get(context).prog * 100).toInt()} %",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              start: 30, end: 20, top: 10, bottom: 30),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40.0)),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              value: Todo_Cubit.get(context).prog,
                              minHeight: 6,
                              color: Todo_Cubit.get(context).c,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                leadingWidth: 30,
                excludeHeaderSemantics: true,
              )
            : null,
        drawer: const MainDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Todo_Cubit.get(context).Screen[Todo_Cubit.get(context).currIndex],
        floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 50,
          child: const Icon(Icons.add),
          onPressed: () {
            HapticFeedback.mediumImpact();
            _showBottomSheet(context);
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: BottomNavigationBar(
                enableFeedback: true,
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepPurpleAccent,
                items: Todo_Cubit.get(context).bottomnav,
                onTap: (index) {
                  HapticFeedback.lightImpact();
                  Todo_Cubit.get(context).ChangeBottomnav(index);
                },
                currentIndex: Todo_Cubit.get(context).currIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
