import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Cubit/Todo_States.dart';

import '../Cubit/Todo_Cubit.dart';
import '../Model/Task.dart';

class Details extends StatefulWidget{
  const Details({super.key,required this.t});
  final Task t;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final enddate=widget.t.endTime.length>4?'- ${widget.t.endTime.substring(0,5)}':' ';
    Color? getColor(Set<MaterialState> states) {
      Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Todo_Cubit.get(context).prColor[widget.t.priority];
    }

    // TODO: implement build
    return BlocConsumer<Todo_Cubit,Todo_States>(
      listener: (context,state){},
      builder:(context,state)=> Container(
        height: 500,
        child: Hero(
          tag: widget.t.startTime,

          child: Dialog(shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(40)),

            child: Container(
height: 200,



              padding: EdgeInsetsDirectional.all(20),

              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: widget.t.Check,
                          onChanged: (bool? Bool) {
                            HapticFeedback.lightImpact();
                            Todo_Cubit.get(context)
                                .ChangeCheck(Bool!, widget.t);
                            Todo_Cubit.get(context).update(widget.t);
                            Todo_Cubit.get(context).addDone(widget.t);
                            Todo_Cubit.get(context).changeProgg();

                            Future.delayed(const Duration(seconds: 1),
                                    () {
                                  setState(() {
                                    Navigator.pop(context);
                                    HapticFeedback.lightImpact();
                                    Todo_Cubit.get(context)
                                        .updateDatedDonetasks(widget.t);

                                  });
                                });


                          },
                          shape: const CircleBorder(),
                          checkColor: Colors.black,
                          focusColor: Colors.green,
                          activeColor: Colors.green,
                          fillColor:
                          MaterialStateProperty.resolveWith(getColor),
                        ),
                        Text(
                          "${widget.t.title}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(

                          "${widget.t.startTime.toString().substring(0,5)}${enddate}",style: TextStyle(fontSize: 13),
                        ),


                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.t.description}",

                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}