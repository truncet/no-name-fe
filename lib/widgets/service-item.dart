import 'package:flutter/material.dart';

import '../screens/service_detail_screen.dart';

class ServiceItem extends StatelessWidget {
  final String work;
  final String userName;
  final double price;
  final String workType;
  final String id;

  ServiceItem({this.id, this.userName, this.work, this.price, this.workType});
  @override
  Widget build(BuildContext context) {
    void bookNow(String id) {
      Navigator.of(context)
          .pushNamed(ServiceDetailScreen.routeName, arguments: id);
    }

    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          key: ValueKey(id),
          header: GridTileBar(
            backgroundColor: Colors.black26,
            title: Text(work.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          child: GestureDetector(
            onTap: () {
              print("gesture");
            },
            child: Image.network(
              "https://bit.ly/2SdPlXv",
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Text(
              "\$$price/$workType",
              style: TextStyle(color: Colors.white),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                bookNow(
                  id,
                );
              },
              child: Text('Details'),
            ),
            title: Text(
              '$userName'.toUpperCase(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
