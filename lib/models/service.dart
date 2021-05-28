import "package:flutter/foundation.dart";

import './profile.dart';

class Service {
  final String id;
  final String userId;
  final String name;
  final double price;
  final String workType;
  final Profile profile;

  Service({
    @required this.id,
    @required this.userId,
    @required this.name,
    @required this.price,
    @required this.workType,
    @required this.profile,
  });
}
