import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: 5, // تم تحديث عدد الفئات إلى 5
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4, // إضافة تأثير الارتفاع للبطاقة
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIconForCategory(index),
                    size: 40,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _getTitleForCategory(index),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForCategory(int index) {
    switch (index) {
      case 0:
        return Icons.phone_android;
      case 1:
        return Icons.laptop;
      case 2:
        return Icons.power;
      case 3:
        return Icons.watch;
      case 4:
        return Icons.camera_alt;
      default:
        return Icons.category;
    }
  }

  String _getTitleForCategory(int index) {
    switch (index) {
      case 0:
        return 'Phones';
      case 1:
        return 'Laptops';
      case 2:
        return 'Electricals';
      case 3:
        return 'Watches';
      case 4:
        return 'Cameras';
      default:
        return 'Unknown Category';
    }
  }
}
