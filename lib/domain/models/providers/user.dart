import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  final String id;
  final String name;

  User({
    required this.id,
    required this.name,
  });
}
