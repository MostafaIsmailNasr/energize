import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../conustant/AppLocale.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/notificationModel/NotificationResponse.dart';
class Item extends StatelessWidget{
  final Notifications notifi;

  Item({required this.notifi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.DarkWHITE,
          boxShadow: const [
            BoxShadow(
              color: MyColors.Dark5,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ]
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5,),
                  Text(notifi.data??"",maxLines: 4,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: MyColors.Dark2,),
                  ),
                  SizedBox(height: 5,),
                  Text(notifi.id??"",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: MyColors.Dark3,),
                  ),
                  SizedBox(height: 5,),
                  Text(notifi.createdAt??"",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: MyColors.Dark3,),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

}
