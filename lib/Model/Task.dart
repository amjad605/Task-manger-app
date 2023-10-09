enum Priority { urgent, normal, low }
Map<String,Priority> prior={
 'urgent':Priority.urgent,'normal':Priority.normal,'low':Priority.low

};
class Task{
 final Priority priority;
 final String pr;
 final  int id;
  final String title;
 final String date;
 final String startTime;
 final String endTime;
  final String description;
   String status;
    bool Check;
  Task(this.id,this.title,this.startTime,this.endTime,this.date, this.description, this.status,this.Check,this.pr):priority=prior[pr]!;
}