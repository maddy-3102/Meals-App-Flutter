import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
