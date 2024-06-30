import 'package:energize_flutter/conustant/AppLocale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../screens/menu/branches/branches_details/branches_details_screen.dart';

class BranchesItem extends StatelessWidget{
  String UserImg;
  final brunch branch;

  BranchesItem({required this.UserImg,required this.branch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("titel", branch.name!);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return BranchesBetailsScreen(branchId: branch.id!,);
            }));
        //Navigator.pushNamed(context, '/branches_details_screen',arguments: branch.id!);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            //color: MyColors.Dark6,
            border: Border.all(width: 1,color: MyColors.Dark5)
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(image: AssetImage(UserImg,),fit: BoxFit.fill),
                  border: Border.all(
                      width: 1,
                      color: MyColors.Dark3
                  )
              )
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(branch.name!,
                      style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                    ),
                    Text(branch.usersCount.toString()+" "+"${getLang(context, "delegates")}",
                      style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                    ),
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
          ],
        ),
      ),
    );
  }

}