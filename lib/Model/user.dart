import 'package:untitled3/Screens/TaskScreen.dart';

class User {
  final String uId;
  final String name;
  final String imageUrl;
  final List<Tasks> alltasks;
  final List<Tasks> done;
  User(
      {required this.uId,
      required this.name,
      required this.imageUrl,
      required this.alltasks,
      required this.done});
}
