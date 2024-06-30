import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/profileController/ProfileController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import 'dart:io';

import '../../home/home_screen.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen>{
  bool _obscureText = true;
  final imagePicker=ImagePicker();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final profileController=Get.put(ProfileController());

  @override
  void initState() {
    getUserDataFromLocal();
    super.initState();
  }

  getUserDataFromLocal()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileController.name=prefs.getString("full_name")??"";
      profileController.pic=prefs.getString("picture")??"";
      profileController.phone=prefs.getString("phone_number")??"";
      profileController.NameController.text=profileController.name;
      profileController.phoneController.text=profileController.phone;
      profileController.lang=prefs.getString('lang')!;
      print("object222"+profileController.lang);
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  iconSize:20,
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                  },
                  icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
              ),
              title: Text(
                "${getLang(context, "profile")}",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'din_next_arabic_medium',
                    fontWeight: FontWeight.w500,
                    color: MyColors.Dark1),
                textAlign: TextAlign.start,
              ),
              backgroundColor: MyColors.DarkWHITE,
            ),
            body:Obx(() =>!profileController.isLoading.value?
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Column(
                  children: [
                    Center(
                      child:Container(
                        width: 140,
                        height: 169,
                        child:Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  uploadImage(source: ImageSource.gallery);
                                });
                              },
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration:profileController.image!=null?  BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    color: MyColors.Dark5,
                                    image: DecorationImage(image: FileImage(profileController.image!),fit: BoxFit.fill),
                                    border: Border.all(
                                        width: 1,
                                        color: MyColors.Dark3
                                    )
                                ):
                                BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image:
                                    //profileController.pic!=null?
                                    DecorationImage(image: NetworkImage(profileController.pic??"",),fit: BoxFit.fill)//:
                                    //DecorationImage(image: AssetImage('assets/logo.png',),fit: BoxFit.fill),
                                ),
                              ),
                            ) ,
                            SizedBox(height: 8,),
                            Text("${getLang(context, "Change_profile_picture")}",
                              style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 82,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getLang(context, "name_")}",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'din_next_arabic_regulare',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark1),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 53,
                            child: Container(
                              width: 327,
                              height: 53,
                              padding: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  //color: MyColors.Dark6,
                                  border: Border.all(width: 1, color: MyColors.Dark5)),
                              child: NameInput(),
                            ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 82,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getLang(context, "phone_number")}",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'din_next_arabic_regulare',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark1),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 53,
                            child: Container(
                              width: 327,
                              height: 53,
                              padding: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  //color: MyColors.Dark6,
                                  border: Border.all(width: 1, color: MyColors.Dark5)),
                              child: Row(
                                children: [
                                  Container(width:30,height:30,child: SvgPicture.asset("assets/saudi.svg")),
                                  Container(
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
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 82,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getLang(context, "password")}",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'din_next_arabic_regulare',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark1),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 53,
                            child: Container(
                              width: 327,
                              height: 53,
                              padding: EdgeInsets.only(left: 8, right: 8),
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
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: TextButton(
                        style: flatButtonStyle ,
                        onPressed: (){
                          profileController.profile(context);
                        },
                        child: Text("${getLang(context, "save")}",
                          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                      ),
                    )
                  ],
                ),
              ),
            )
                : const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),)
            )
          )
      ),
    );
  }

  void uploadImage({required ImageSource source})async{
    var pickedImage=await ImagePicker().pickImage(source: source);
    if(pickedImage?.path!=null){
      setState(() {
        profileController.image=File(pickedImage!.path);
      });
    }
  }

  Widget NameInput(){
    return TextFormField(
      controller: profileController.NameController,
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
        hintText: "${getLang(context, "enter_name")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget PhoneNumberInput(){
    return TextFormField(
      controller: profileController.phoneController,
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
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
    );

  }

  Widget PasswordInput(){
    return TextFormField(
      controller: profileController.passwordController,
      maxLines: 1,
      obscureText: _obscureText,

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
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: GestureDetector(
            onTap: (){
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(10),],
    );
  }
}