import 'package:flutter/material.dart';

import '../../conustant/my_colors.dart';

class Loader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: MyColors.MAINCOLORS,);
  }

}