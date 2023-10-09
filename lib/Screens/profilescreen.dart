import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Const/Constants.dart';
import 'package:untitled3/Const/profileitem.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Cubit/Todo_States.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_Cubit, Todo_States>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Todo_Cubit.get(context).GetAllTasks();
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          toolbarHeight: 45,
        ),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: 180,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(250),
                            bottomRight: Radius.circular(250)),
                        color: Todo_Cubit.get(context).isdark
                            ? Colors.grey.shade900
                            : Color.fromARGB(255, 83, 30, 230),
                      ),
                      height: 150,
                    ),
                  ),
                  Container(
                    child: Hero(
                        tag: 1,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    'Done Tasks of Today',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                itemBuilder: (ctx, index) =>
                    ProfileItem(Todo_Cubit.get(context).done[index]),
                scrollDirection: Axis.horizontal,
                itemCount: Todo_Cubit.get(context).done.length,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
