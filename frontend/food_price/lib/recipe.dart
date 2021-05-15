import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  //const RecipePage({Key key}) : super(key: key);

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text('41'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
        Image.network('https://tokyo-kitchen.icook.network/uploads/recipe/cover/373636/5dc990636b76eb32.jpg')  ,
        titleSection],
      ),
    );
  }
}
