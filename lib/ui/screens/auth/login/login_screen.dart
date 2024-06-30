import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/loginController/LoginController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget_Items_list/Loader.dart';
import '../../home/home_screen.dart';

class LoginScreen extends GetView<LoginController>{

  final loginController=Get.put(LoginController());
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context=context;
    return  SafeArea(
            child: Scaffold(
              body: Directionality(
                        textDirection: controller.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size.height,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                24, 100, 24, 0),
                            child: Container(
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 254,
                                      height: 71,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/Logo_black.png'),
                                        alignment: Alignment.center,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 45,),
                                  Container(
                                    width: 327,
                                    height: 35,
                                    child: Text("${getLang(context, "hello")}",
                                      style: TextStyle(fontSize: 24,
                                          fontFamily: 'din_next_arabic_hevy',
                                          fontWeight: FontWeight.w700,
                                          color: MyColors.Dark1),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 327,
                                    height: 24,
                                    child: Text("${getLang(
                                        context, "Log_in_to_your_account")}",
                                      style: TextStyle(fontSize: 16,
                                          fontFamily: 'din_next_arabic_regulare',
                                          fontWeight: FontWeight.normal,
                                          color: MyColors.Dark2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 32,),
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 21,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          "${getLang(context, "phone_number")}",
                                          style: TextStyle(fontSize: 14,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.normal,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                          color: MyColors.Dark5,
                                          width: 1.0,
                                        ),
                                        color: MyColors.DarkWHITE
                                    ),
                                    child: PhoneNumber(),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 21,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          "${getLang(context, "password")}",
                                          style: TextStyle(fontSize: 14,
                                              fontFamily: 'din_next_arabic_regulare',
                                              fontWeight: FontWeight.normal,
                                              color: MyColors.Dark1),
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: new Border.all(
                                          color: MyColors.Dark5,
                                          width: 1.0,
                                        ),
                                        color: MyColors.DarkWHITE
                                    ),
                                    child: PasswordContainer(),
                                  ),
                                  SizedBox(height: 24,),
                                  Obx(() =>
                                      Visibility(
                                          visible: loginController.isVisable
                                              .value,
                                          child: Loader()
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(left: 8, right: 8),
                                    width: double.infinity,
                                    height: 60,
                                    child: TextButton(
                                      style: flatButtonStyle,
                                      onPressed: () {
                                        ValidationAndApisCall();
                                      },
                                      child: Text("${getLang(context, "login")}",
                                        style: TextStyle(fontSize: 14,
                                            fontFamily: 'din_next_arabic_bold',
                                            fontWeight: FontWeight.w500,
                                            color: MyColors.DarkWHITE),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
            )
        );
  }

  Widget PhoneNumber (){
    return TextFormField(
      controller: loginController.phoneController,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon:  Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8,0,0,0),
                child: Image(image: AssetImage('assets/flage.png',))
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('(+966)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),),
            )
          ],
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context!, "enter_phone_number")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.normal),
      ),
      style: TextStyle(color: MyColors.Dark2),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)],
    );
  }

  Widget PasswordContainer(){
    return Obx(() => TextFormField(
      controller: loginController.PasswordController,
      maxLines: 1,
      obscureText: loginController.obscureText.value,

      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
            child:Image(image: AssetImage('assets/pass_img.png',))
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(style: BorderStyle.none)
        ),
        hintText: "${getLang(context!, "enter_password")}",
        hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.normal),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: new GestureDetector(
            onTap: (){
              //setState(() {
                loginController.obscureText.value = !loginController.obscureText.value;
              //});
            },
            child: Icon(loginController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: TextStyle(color: MyColors.Dark2),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  ValidationAndApisCall() {
    if (loginController.phoneController.text == null ||
        loginController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (loginController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (loginController.PasswordController.text == null ||
        loginController.PasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (loginController.PasswordController.text.length <6) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_correct_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      loginController.isVisable.value = true;
      loginController.loginUse(context!);
    }
  }

  Widget NoIntrnet(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/error_img.svg'),
          SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

}