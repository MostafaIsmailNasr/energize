import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/notesController/CreateNotesController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';

class AddNotesScreen extends StatefulWidget{
  var orderId;

  AddNotesScreen({required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return _AddNotesScreen();
  }
}

class _AddNotesScreen extends State<AddNotesScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final createNotesController=Get.put(CreateNotesController());

  @override
  void initState() {
    createNotesController.idOrder=widget.orderId;
    createNotesController.getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return Directionality(
            textDirection: createNotesController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: MyColors.DarkWHITE,
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBar(),
                    content(context),
                  ],
                ),
              ),
            ),
          );
        } else {
          return  NoIntrnet();
        }
      },
      child: Center(
        child: CircularProgressIndicator(
          color: MyColors.MAINCOLORS,
        ),
      ),
    );

  }
  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/internet.svg'),
          SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
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
                  child: Text("${getLang(context, "Add_note")}",
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
final formkey=GlobalKey<FormState>();
  Widget content(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 82,
      margin: EdgeInsets.only(top: 10),
      child: Form(
        key: formkey,
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
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: TextFormField(
                controller: createNotesController.NotesAddressController,
                maxLines: 1,
                validator: (String? validate){
                  if(createNotesController.NotesAddressController.text.isEmpty){
                    return "${getLang(context, "Enter_note_title")}";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "Enter_note_title")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
                ),
                style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
              ),
            ),
            SizedBox(height: 10,),
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
                controller: createNotesController.NotesController,
                maxLines: 1,
                validator: (String? validate){
                  if(createNotesController.NotesController.text.isEmpty){
                    return "${getLang(context, "enter_your_comment_here")}";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none)
                  ),
                  hintText: "${getLang(context, "enter_your_comment_here")}",
                  hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
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
                visible: createNotesController.isVisable.value,
                child: Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,))
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              child: TextButton(
                style: flatButtonStyle ,
                onPressed: (){
                  if(formkey.currentState!.validate()){
                    createNotesController.isVisable.value = true;
                    createNotesController.CreateNotes(context!,widget.orderId!);
                  }
                },
                child: Text("${getLang(context, "save")}",
                  style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
              ),
            ),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }


}