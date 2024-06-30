import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/updateNoteController/UpdateNoteController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';

class UpdateNoteScreen extends StatefulWidget{
  int id;
  var orderId;
  UpdateNoteScreen({required this.id,required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return _UpdateNoteScreen(id: id);
  }
}

class _UpdateNoteScreen extends State<UpdateNoteScreen>{
  int id;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  _UpdateNoteScreen({required this.id});
  final updateNotesController=Get.put(UpdateNotesController());

  @override
  void initState() {
    updateNotesController.idOrder=widget.orderId;
    updateNotesController.getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: MyColors.DarkWHITE,
        margin: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBar(),
            content(),
          ],
        ),
      ),
    );
  }

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 100,
            height: 5,
            margin: EdgeInsets.only(top: 5),
            color: MyColors.Dark5,),
        ),
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: Stack(
            children: [
              Positioned(
                left: -10,
                child: IconButton(
                    icon: Icon(Icons.close),
                    color: MyColors.Dark3,
                    onPressed:(){
                      Navigator.pop(context);
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "update_notes")}",
                    style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.Dark1,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            color: MyColors.Dark6,
            margin: EdgeInsets.only(top: 5),),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget content(){
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 82,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${getLang(context, "note_title")}",
            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1,),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: MyColors.Dark5)),
            child: TextFormField(
              controller: updateNotesController.NotesAddressController,
              maxLines: 1,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(style: BorderStyle.none)
                ),
                ),
              style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
            ),
          ),
          const SizedBox(height: 10,),
          Text("${getLang(context, "note")}",
            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1,),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 116,
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: MyColors.Dark5)),
            child: TextFormField(
              controller: updateNotesController.NotesController,
              maxLines: 1,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(style: BorderStyle.none)
                ),
               ),
              style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: MyColors.Dark6,
              margin: EdgeInsets.only(top: 5),),
          ),
          SizedBox(height: 24,),
          Obx(() => Visibility(
              visible: updateNotesController.isVisable.value,
              child: Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,))
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 53,
            child: TextButton(
              style: flatButtonStyle ,
              onPressed: (){
                updateNotesController.isVisable.value=true;
                updateNotesController.UpdateNotes(context, id);
              },
              child: Text("${getLang(context, "save")}",
                style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
            ),
          ),
          SizedBox(height: 24,),
        ],
      ),
    );
  }

}