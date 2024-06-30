import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../conustant/AppLocale.dart';
import '../../conustant/my_colors.dart';


class ListCategoryItem extends StatelessWidget{
  final String Icon;
  final String Name;
  final String value;
  bool is_selected;
  GestureTapCallback? onTap;
  ListCategoryItem({required this.Icon,required this.Name,required this.value,required this.is_selected,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        width: 109,
        height: 114,
        padding: EdgeInsetsDirectional.all(8),
        margin: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  is_selected? MyColors.SECONDERYCOLORS:MyColors.DarkWHITE,
            boxShadow: [
              BoxShadow(
                color: MyColors.Dark5,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(Icon,),
            Text(value.toString(),
              style:is_selected?
              TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.DarkWHITE):
              TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_hevy',fontWeight: FontWeight.w700,color: MyColors.Dark1),
              textAlign: TextAlign.center,),
            Text(Name,
              style:is_selected?
              TextStyle(fontSize: 12,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark5):
              TextStyle(fontSize: 12,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
              textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

}