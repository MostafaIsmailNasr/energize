import 'package:dotted_border/dotted_border.dart';
import 'package:energize_flutter/business/updateDriverController/UpdateDriverController.dart';
import 'package:energize_flutter/ui/screens/menu/drivers/drivers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpdateDreiverScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpdateDreiverScreen();
  }
}
class _UpdateDreiverScreen extends State<UpdateDreiverScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final imagePicker=ImagePicker();
  final updateDriverController=Get.put(UpdateDriverController());

  @override
  void initState() {
    updateDriverController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return  Directionality(
                    textDirection: updateDriverController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize:20,
                          onPressed: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return DriverScreen();
                                }));
                          },
                          icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                      ),
                      title: Text(
                        "${getLang(context, "update_driver")}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                      backgroundColor: MyColors.DarkWHITE,
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 15,right: 15,top: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 82,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getLang(context, "driver_name")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_regulare',
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 53,
                                    child: Container(
                                      width: 327,
                                      height: 53,
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          //color: MyColors.Dark6,
                                          border: Border.all(width: 1, color: MyColors.Dark5)),
                                      child: driverNameInput(),
                                    ),

                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 82,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getLang(context, "phone_number")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_regulare',
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 53,
                                    child: Container(
                                      width: 327,
                                      height: 53,
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          //color: MyColors.Dark6,
                                          border: Border.all(width: 1, color: MyColors.Dark5)),
                                      child: Row(
                                        children: [
                                          SizedBox(width:30,height:30,child: SvgPicture.asset("assets/saudi.svg")),
                                          const SizedBox(
                                            height: 16,
                                            child: VerticalDivider(
                                              thickness: 2,
                                              color: MyColors.Dark4,
                                            ),
                                          ),
                                          Expanded(child: PhoneNumberInput())
                                        ],

                                      ),
                                    ),

                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 82,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getLang(context, "status")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_regulare',
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 53,
                                      child: Row(
                                        children: [
                                          Obx(() =>   Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    activeColor:MyColors.MAINCOLORS,
                                                    value: 1,
                                                    groupValue: updateDriverController.isActive.value,
                                                    onChanged: (value){
                                                      setState(() {
                                                        updateDriverController.isActive.value=1;
                                                      });

                                                    },),
                                                  const SizedBox(width: 5,),
                                                  Text("${getLang(context, "active")}")
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    activeColor:MyColors.MAINCOLORS,
                                                    value: 0,
                                                    groupValue: updateDriverController.isActive.value,
                                                    onChanged: (value){
                                                      setState(() {
                                                        updateDriverController.isActive.value=0;
                                                        //value=addDelegateController.isActive.value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(width: 5,),
                                                  Text("${getLang(context, "inActive")}")
                                                ],
                                              ),
                                            ],)),
                                        ],
                                      )
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 82,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getLang(context, "password")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_regulare',
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 53,
                                    child: Container(
                                      width: 327,
                                      height: 53,
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          //color: MyColors.Dark6,
                                          border: Border.all(width: 1, color: MyColors.Dark5)),
                                      child: PasswordInput(),
                                    ),

                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 82,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getLang(context, "confirm_password")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_regulare',
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 53,
                                    child: Container(
                                      width: 327,
                                      height: 53,
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          //color: MyColors.Dark6,
                                          border: Border.all(width: 1, color: MyColors.Dark5)),
                                      child: confirmPasswordInput(),
                                    ),

                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 156,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${getLang(context, "License_picture")}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'din_next_arabic_regulare',
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColors.Dark2),
                                              textAlign: TextAlign.start,
                                            ),
                                          const SizedBox(height: 10,),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                _uploadImage();
                                              });
                                            },
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(15),
                                              color: MyColors.MAINCOLORS,//color of dotted/dash line
                                              strokeWidth: 1, //thickness of dash/dots
                                              dashPattern: const [10,6],
                                              child:updateDriverController.imageLicense!=null? Container(
                                                height:100,
                                                width: 157.5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image:updateDriverController.imageLicense!=null?
                                                  DecorationImage(image: FileImage(updateDriverController.imageLicense!)
                                                      ,fit: BoxFit.fill):
                                                  DecorationImage(image: NetworkImage(updateDriverController.licence!)
                                                      ,fit: BoxFit.fill
                                                  )
                                                ),
                                              ):Container(
                                                height:100,
                                                width: 157.5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color:MyColors.framedashed,
                                                ),
                                                child: updateDriverController.licence!=null?
                                                Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      image: DecorationImage(image: NetworkImage(updateDriverController.licence!)
                                                          ,fit: BoxFit.fill
                                                      )
                                                  ),
                                                ) : Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(width: 29,height: 21,child: Image(image: AssetImage('assets/up.png'))),
                                                      Text(
                                                        "${getLang(context, "Add_photo")}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'din_next_arabic_regulare',
                                                            fontWeight: FontWeight.w400,
                                                            color: MyColors.MAINCOLORS),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    opaque: false,
                                                    barrierDismissible: true,
                                                    pageBuilder:  (BuildContext context,_,__){
                                                      return Scaffold(appBar: AppBar(
                                                            leading: IconButton(
                                                                iconSize:20,
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                                                            ),
                                                            backgroundColor: MyColors.DarkWHITE),
                                                            body: Center(child: Hero(tag: "Zoom", child: Image(image: NetworkImage(updateDriverController.licence!),))));
                                                    },)
                                              );
                                            },
                                            child: Text(
                                              "${getLang(context, "display")}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'din_next_arabic_regulare',
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColors.MAINCOLORS),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 156,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${getLang(context, "car_registration_picture")}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'din_next_arabic_regulare',
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColors.Dark2),
                                              textAlign: TextAlign.start,
                                            ),
                                          const SizedBox(height: 10,),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                uploadImageCar();
                                              });
                                            },
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(15),
                                              color: MyColors.MAINCOLORS,//color of dotted/dash line
                                              strokeWidth: 1, //thickness of dash/dots
                                              dashPattern: const [10,6],
                                              child:updateDriverController.imageCar!=null? Container(
                                                height:100,
                                                width: 157.5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(image: FileImage(updateDriverController.imageCar!)
                                                      ,fit: BoxFit.fill)
                                                ),
                                              ):
                                              Container(
                                                height:100,
                                                width: 157.5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color:MyColors.framedashed,
                                                ),
                                                child: Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color:MyColors.framedashed,
                                                  ),
                                                  child:updateDriverController.car!=null?
                                                  Container(
                                                    height:100,
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        image: DecorationImage(image: NetworkImage(updateDriverController.car!)
                                                            ,fit: BoxFit.fill
                                                        )
                                                    ),
                                                  ) : Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(width: 29,height: 21,child: Image(image: AssetImage('assets/up.png'))),
                                                        Text(
                                                          "${getLang(context, "Add_photo")}",
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'din_next_arabic_regulare',
                                                              fontWeight: FontWeight.w400,
                                                              color: MyColors.MAINCOLORS),
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    opaque: false,
                                                    barrierDismissible: true,
                                                    pageBuilder:  (BuildContext context,_,__){
                                                      return Scaffold(appBar: AppBar(
                                                      leading: IconButton(
                                                      iconSize:20,
                                                          onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                                                      ),
                                                      backgroundColor: MyColors.DarkWHITE),
                                                      body:Center(child: Hero(tag: "Zoom", child: Image(image: NetworkImage(updateDriverController.car!),))));
                                                    },)
                                              );
                                            },
                                            child: Text(
                                              "${getLang(context, "display")}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'din_next_arabic_regulare',
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColors.MAINCOLORS),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 156,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                      "${getLang(context, "residence_picture")}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.Dark1),
                                      textAlign: TextAlign.start,
                                    ),
                                  const SizedBox(height: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        uploadImageResidence();
                                      });
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(15),
                                      color: MyColors.MAINCOLORS,//color of dotted/dash line
                                      strokeWidth: 1, //thickness of dash/dots
                                      dashPattern: const [10,6],
                                      child:updateDriverController.ImageResidence!=null? Container(
                                        height:100,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image:
                                          //updateDriverController.ImageResidence!=null?
                                          DecorationImage(image: FileImage(updateDriverController.ImageResidence!)
                                              ,fit: BoxFit.fill)
                                                //:
                                          // DecorationImage(image: NetworkImage(updateDriverController.rese!)
                                          //     ,fit: BoxFit.fill
                                          // )
                                        ),
                                      ): Container(
                                        height:100,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color:MyColors.framedashed,
                                        ),
                                        child:updateDriverController.rese!=null?
                                        Container(
                                          height:100,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(image: NetworkImage(updateDriverController.rese!)
                                                  ,fit: BoxFit.fill
                                              )
                                          ),
                                        ) : Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 29,height: 21,child: Image(image: AssetImage('assets/up.png'))),
                                              Text(
                                                "${getLang(context, "Add_photo")}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'din_next_arabic_regulare',
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.MAINCOLORS),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                            opaque: false,
                                            barrierDismissible: true,
                                            pageBuilder:  (BuildContext context,_,__){
                                              return Scaffold(appBar: AppBar(
                                              leading: IconButton(
                                              iconSize:20,
                                                  onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                                              ),
                                              backgroundColor: MyColors.DarkWHITE),
                                              body:Center(child: Hero(tag: "Zoom", child: Image(image:NetworkImage(updateDriverController.rese!),))));
                                            },)
                                      );
                                    },
                                    child: Text(
                                      "${getLang(context, "display")}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.MAINCOLORS),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Obx(() => Visibility(
                              visible: updateDriverController.isVisabl.value,
                              child: const CircularProgressIndicator(color: MyColors.MAINCOLORS,),
                            )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 53,
                              child: TextButton(
                                style: flatButtonStyle ,
                                onPressed: (){
                                  ValidationAndApisCall();
                                },
                                child: Text("${getLang(context, "save")}",
                                  style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return  Scaffold(body: NoIntrnet());
              }
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.MAINCOLORS,
              ),
            ),
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
          const SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget driverNameInput(){
    return TextFormField(
      controller: updateDriverController.driverNameController,
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "enter_client_name")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget PhoneNumberInput(){
    return TextFormField(
      controller: updateDriverController.phoneController,
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "hint")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    );
  }

  Widget PasswordInput(){
    return Obx(() => TextFormField(
      controller: updateDriverController.passwordController,
      maxLines: 1,
      obscureText: updateDriverController.obscureText.value,

      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "enter_password")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: GestureDetector(
            onTap: (){
              //setState(() {
              updateDriverController.obscureText.value = !updateDriverController.obscureText.value;
              //});
            },
            child: Icon(updateDriverController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  Widget confirmPasswordInput(){
    return Obx(() => TextFormField(
      controller: updateDriverController.confirmPasswordController,
      maxLines: 1,
      obscureText: updateDriverController.obscureText2.value,

      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "enter_password")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: GestureDetector(
            onTap: (){
              //setState(() {
              updateDriverController.obscureText2.value = !updateDriverController.obscureText2.value;
              //});
            },
            child: Icon(updateDriverController.obscureText2.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  /*void uploadImage({required ImageSource source})async{
    var pickedImage=await ImagePicker().pickImage(source: source);
    if(pickedImage?.path!=null){
      setState(() {
        updateDriverController.imageLicense=File(pickedImage!.path);
      });
    }
  }

  void uploadImageCar({required ImageSource source})async{
    var pickedImageCar=await ImagePicker().pickImage(source: source);
    if(pickedImageCar?.path!=null){
      setState(() {
        updateDriverController.imageCar=File(pickedImageCar!.path);
      });
    }
  }

  void uploadImageResidence({required ImageSource source})async{
    var pickedImageResidence=await ImagePicker().pickImage(source: source);
    if(pickedImageResidence?.path!=null){
      setState(() {
        updateDriverController.ImageResidence=File(pickedImageResidence!.path);
      });
    }
  }*/

  Future<void> _uploadImage() async {
    final picker = ImagePicker();

    // Show a dialog to choose between camera and gallery options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.camera,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.imageLicense=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.imageLicense=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> uploadImageCar() async {
    final picker = ImagePicker();

    // Show a dialog to choose between camera and gallery options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.camera,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.imageCar=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.imageCar=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> uploadImageResidence() async {
    final picker = ImagePicker();

    // Show a dialog to choose between camera and gallery options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.camera,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.ImageResidence=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        updateDriverController.ImageResidence=File(pickedImage!.path);
                      });
                      // Perform the upload operation with the selected image
                      // uploadImageToServer(imageFile);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ValidationAndApisCall() {
    if (updateDriverController.driverNameController.text == null ||
        updateDriverController.driverNameController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateDriverController.phoneController.text == null ||
        updateDriverController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateDriverController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      updateDriverController.isVisabl.value = true;
      //controller.updateToken();
      updateDriverController.updateDriver(context!);
    }
  }

}