import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/Const/Constants.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';

import 'package:untitled3/Cubit/Todo_States.dart';
import 'package:untitled3/Screens/drawer.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_Cubit, Todo_States>(
        builder: (context, state) => Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              body: ConditionalBuilder(
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => item(
                                Todo_Cubit.get(context).Datetask[
                                    DateFormat.yMMMd()
                                        .format(DateTime.now())]![index],
                              ),
                          separatorBuilder: (context, builder) => Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 0.1,
                                  color: Colors.black,
                                ),
                              ),
                          itemCount: Todo_Cubit.get(context)
                                  .Datetask[
                                      DateFormat.yMMMd().format(DateTime.now())]
                                  ?.length ??
                              0),
                    ),
                  ],
                ),
                condition: Todo_Cubit.get(context).Datetask[
                            DateFormat.yMMMd().format(DateTime.now())] !=
                        null
                    ? Todo_Cubit.get(context)
                            .Datetask[
                                DateFormat.yMMMd().format(DateTime.now())]!
                            .length >
                        0
                    : false,
                fallback: (context) => Container(
                  child: const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 30),
                          child: Image(
                            image: AssetImage("assets/images/NotaskToday.png"),
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Center(
                            child: Text(
                          "Hooray!",
                          style:
                              TextStyle(fontSize: 25, fontFamily: 'RobotoMono'),
                        )),
                        Text(
                          "You Have a Free day",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        listener: (context, state) {});
  }
}
