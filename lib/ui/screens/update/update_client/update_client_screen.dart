import 'package:energize_flutter/business/updateUserController/UpdateUserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../menu/clients/clients_screen.dart';

class UpdateClientScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpdateClientScreen();
  }
}

class _UpdateClientScreen extends State<UpdateClientScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final updateUserController=Get.put(UpdateUserController());

  @override
  void initState() {
    updateUserController.getData();
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
                return   Directionality(
                    textDirection: updateUserController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ClientScreen();
                                  }));
                              //Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "update_client")}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1),
                          textAlign: TextAlign.start,
                        ),
                        backgroundColor: MyColors.DarkWHITE,
                      ),
                      body:Obx(() => !updateUserController.isLoading.value? SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 15,right: 15,top: 20),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 82,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "client_name")}",
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
                                        child: clientNameInput(),
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
                                      "${getLang(context, "manager_name")}",
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
                                        child: managerNameInput(),
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
                                height: 82,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "confirm_password")}",
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
                                        child: confirmPasswordInput(),
                                      ),

                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Obx(() => Visibility(
                                visible: updateUserController.isVisabl.value,
                                child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),
                              )),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: TextButton(
                                  style: flatButtonStyle ,
                                  onPressed: (){
                                    ValidationAndApisCall();
                                  },
                                  child: Text("${getLang(context, "save")}",
                                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          :Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),))
                  ),
                );
              } else {
                return  Scaffold(body: NoIntrnet());
              }
            },
            child: Center(
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
          SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget clientNameInput(){
    return TextFormField(
      controller: updateUserController.clientNameController,
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
        hintText: "${getLang(context, "enter_client_name")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget managerNameInput(){
    return TextFormField(
      controller: updateUserController.managerNameController,
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
        hintText: "${getLang(context, "enter_manager_name")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget PhoneNumberInput(){
    return TextFormField(
      controller: updateUserController.phoneController,
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
        hintText: "${getLang(context, "hint")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),],
    );
  }

  Widget PasswordInput(){
    return Obx(() => TextFormField(
      controller: updateUserController.passwordController,
      maxLines: 1,
      obscureText: updateUserController.obscureText.value,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "enter_password")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: new GestureDetector(
            onTap: (){
              //setState(() {
              updateUserController.obscureText.value = !updateUserController.obscureText.value;
              //});
            },
            child: Icon(updateUserController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  Widget confirmPasswordInput(){
    return Obx(() => TextFormField(
      controller: updateUserController.confirmPasswordController,
      maxLines: 1,
      obscureText: updateUserController.obscureText2.value,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context, "enter_password")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: new GestureDetector(
            onTap: (){
              //setState(() {
              updateUserController.obscureText2.value = !updateUserController.obscureText2.value;
              //});
            },
            child: Icon(updateUserController.obscureText2.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  ValidationAndApisCall() {
    if (updateUserController.clientNameController.text == null ||
        updateUserController.clientNameController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateUserController.phoneController.text == null ||
        updateUserController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateUserController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      updateUserController.isVisabl.value = true;
      //controller.updateToken();
      updateUserController.updateUser(context!);
    }
  }

}