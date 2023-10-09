import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Cubit/Todo_States.dart';
import 'package:untitled3/Model/Task.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(this.t, {super.key});
  final Task t;

  @override
  Widget build(BuildContext context) {
    Color? getColor(Set<MaterialState> states) {
      Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Todo_Cubit.get(context).prColor[t.priority];
    }

    return BlocConsumer<Todo_Cubit, Todo_States>(
      listener: (context, state) {},
      builder: (context, state) {
        final endTime=t.endTime.length>3?'- ${t.endTime.substring(0,5)}':' ';
        return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 290,
          height: 220,

          child: InkWell(
            onLongPress: (){
              HapticFeedback.heavyImpact();

              Navigator.push(context, PageRouteBuilder(pageBuilder: (ctx,_,__)=>

                  Hero(


                    tag: t.title,
                    child: Dialog(shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(40)),

                      child: Container(
                        height: 220
                        ,
                        padding: EdgeInsetsDirectional.all(20),

                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    value: t.Check,
                                    onChanged: (bool? Bool) {
                                      HapticFeedback.lightImpact();
                                      Todo_Cubit.get(context)
                                          .ChangeCheck(Bool!, t);
                                      Todo_Cubit.get(context).update(t);
                                      Todo_Cubit.get(context).addDone(t);
                                      Todo_Cubit.get(context).changeProgg();
                                    },
                                    shape: const CircleBorder(),
                                    checkColor: Colors.black,
                                    focusColor: Colors.green,
                                    activeColor: Colors.green,
                                    fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                  ),
                                  Text(
                                    "${t.title}",
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(

                                    "${t.startTime.toString().substring(0,5)}${endTime}",style: TextStyle(fontSize: 13),
                                  ),


                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${t.description}",

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

                barrierDismissible: true,
                opaque: false,

              ),
              );

            },
            child: Hero(
              tag: t.title,
              child: Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90,
                        height: 75,
                        padding: const EdgeInsetsDirectional.all(4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(

                              "${t.startTime.toString().substring(0,5)}${endTime}",style: TextStyle(fontSize: 13),
                            ),
                            Checkbox(
                              value: t.Check,
                              onChanged: (bool? Bool) {
                                HapticFeedback.lightImpact();
                                Todo_Cubit.get(context).ChangeCheck(Bool!, t);
                                Todo_Cubit.get(context).update(t);
                                Todo_Cubit.get(context).addDone(t);
                                Todo_Cubit.get(context).changeProgg();
                              },
                              shape: const CircleBorder(),
                              checkColor: Colors.black,
                              focusColor: Colors.green,
                              activeColor: Colors.green,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${t.title}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              "${t.description}",
                              maxLines: 2,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      //Spacer(),
                      // Icon(Icons.flag,color:Todo_Cubit.get(context).prColor[t.priority],),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );}
    );
  }
}
