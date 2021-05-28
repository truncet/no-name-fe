import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final String work;
  final String userName;
  final double price;
  final String workType;

  ServiceItem({this.userName, this.work, this.price, this.workType});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      height: 200,
      width: 200,
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.black26,
          title: Text(
            userName,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Image.network(
                "https://bit.ly/3p0fYLD",
                fit: BoxFit.cover,
              ),
              Text(work),
            ],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Text(this.price.toString()),
          trailing: IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
