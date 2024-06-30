import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business/notesController/NotesController.dart';
import '../../conustant/AppLocale.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/notesModel/NotesResponse.dart';
import '../screens/update/update_notes/update_notes_screen.dart';

class NotesItemList extends StatelessWidget{
  // String notesName;
  // String date;
  // String notesdesc;
  int orderId;
  String des;
  Notes notes;
  final notesController=Get.put(NotesController());

  NotesItemList({required this.des,required this.notes,required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.all(8),
      margin: EdgeInsetsDirectional.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.DarkWHITE,
          boxShadow: const [
            BoxShadow(
              color: MyColors.Dark5,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Center(
                              child: SvgPicture.asset('assets/notes_img.svg', )
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notes.title!,
                              style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                            ),
                            Text(notes.createdAt!,
                              style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                            ),
                          ],
                        )
                      ],
                    ),
                Container(
                    width: 56,
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: ()async{
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString("tittle", notes.title!);
                              await prefs.setString("body", notes.note!);
                              // ignore: use_build_context_synchronously
                              showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor:MyColors.DarkWHITE,
                                  builder: (BuildContext context)=> Padding(
                                      padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: UpdateNoteScreen(id: notes.id!,orderId: orderId)
                                  )
                              );
                            },
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset('assets/edit.svg',)
                            )
                        ),
                        GestureDetector(
                            onTap: (){
                              _onAlertButtonsPressed(context,des);
                            },
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset('assets/trash.svg',)
                            )
                        )
                      ],
                    ),
                  ),
              ],
            ),
          Container(
            margin: EdgeInsets.only(left: 50,right: 10),
            child: Text(notes.note!,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'din_next_arabic_regulare',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50,right: 10),
            child: Text(notes.user?.name??"",
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'din_next_arabic_regulare',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.start,
            ),
          ),
        ],

      ),
    );
  }

  _onAlertButtonsPressed(context,String des) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/delete_dialog_img.svg',),
      title: "${getLang(context, 'confirm_deletion')}",
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
      ),
      desc: des,
      buttons: [
        DialogButton(
          height: 53,
          onPressed: ()async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            var token=prefs.getString("tokenUser")!;
            notesController.deleteNotes(context, token, notes.id!,orderId!);
          },
          color: MyColors.SideRed,
          child: Text(
            "${getLang(context, 'delete')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
        ),
        DialogButton(
          height: 53,
          onPressed: () => Navigator.pop(context),
          color: MyColors.Secondry_Color,
          child: Text(
            "${getLang(context, 'cancel')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),

        )
      ],
    ).show();
  }
}