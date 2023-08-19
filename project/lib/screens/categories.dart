import 'package:flutter/material.dart';
import 'package:project/data/dummy_data.dart';
import 'package:project/models/category.dart';
import 'package:project/screens/meals.dart';
import 'package:project/widgets/category_grid_item.dart';
import 'package:project/models/meal.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.availablemeals});

  final List<Meal> availablemeals;

  @override
  State<Categories> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final fileteredMeals = widget.availablemeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: fileteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: availableCategories
              .map((data) => CategoryGridItem(
                  category: data,
                  onSelectCategory: () {
                    _selectCategory(context, data);
                  }))
              .toList(),
        ),
        builder: (context, child) => SlideTransition(
          position: Tween(
              begin: const Offset(0,0.3),
              end: const Offset(0, 0)
            ).animate(CurvedAnimation(
              parent: _animationController, 
              curve: Curves.easeOut,
              )),
          child: child,
          ),
        );
  }
}
