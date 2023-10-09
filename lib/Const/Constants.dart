import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Model/Task.dart';

import '../Screens/Details.dart';

class item extends StatefulWidget {
  const item(this.t, {super.key});
  final Task t;

  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        lowerBound: 0,
        upperBound: 1);
    //_controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

    double opacityLevel = 1.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0),
          end: Offset(1, 0),
        ).animate(_controller),
        // duration: Duration(milliseconds: 400),
        // offset: Offset(0 - _controller.value * 2, 0),
        child: child,
      ),
      child: Dismissible(

        key: ValueKey(widget.t.id.toString()),
        onDismissed: (direction) {
          HapticFeedback.lightImpact();
          Todo_Cubit.get(context).deletitem(widget.t, context);
          if (Todo_Cubit.get(context).Datetask[widget.t.date]!.length > 0)
            Todo_Cubit.get(context).changeProgg();
          else
            Todo_Cubit.get(context).prog = 0.0;
        },
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          padding: const EdgeInsetsDirectional.only(end: 15.0),
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onLongPress: () {
                    HapticFeedback.heavyImpact();

Navigator.of(context).push( PageRouteBuilder(pageBuilder: (BuildContext context,Animation<double>animation
,Animation<double>secondryAnimation){
  return Details(t: widget.t,); },

barrierDismissible: true,
opaque: false,

),
);

                  }
                  ,
                  child: Container(
                    height: 130,
                    child: Hero(
                      tag: widget.t.startTime,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            height: 85,
                            child: Row(

                              crossAxisAlignment: CrossAxisAlignment.start,

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
                                    if (!Bool) {
                                      _controller.reverse();
                                    } else {
                                      _controller.forward();
                                      //_controller.reset();
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        setState(() {
                                          HapticFeedback.lightImpact();
                                          Todo_Cubit.get(context)
                                              .updateDatedDonetasks(widget.t);
                                          _controller.reset();
                                        });
                                      });
                                    }
                                  },
                                  shape: const CircleBorder(),
                                  checkColor: Colors.black,
                                  focusColor: Colors.green,
                                  activeColor: Colors.green,
                                  fillColor:
                                      MaterialStateProperty.resolveWith(getColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:11.0),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.t.title}",
                                        style: const TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          "${widget.t.description}",
                                          maxLines: 2,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),

                                Padding(
                                  padding: const EdgeInsets.only(top:12.0),
                                  child: Text(

                                    "${widget.t.startTime.toString().substring(0,5)}${enddate}",style: TextStyle(fontSize: 13),
                                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
