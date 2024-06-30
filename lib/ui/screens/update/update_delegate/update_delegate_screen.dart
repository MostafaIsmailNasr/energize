import 'package:energize_flutter/business/updateDelegateController/UpdateDelegateController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../menu/delegate/delegate_screen.dart';

class UpdateDelegateScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpdateDelegateScreen();
  }
}

class _UpdateDelegateScreen extends State<UpdateDelegateScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final updateDelegateController=Get.put(UpdateDelegateController());

  @override
  void initState() {
    updateDelegateController.getBranch();
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
                return Directionality(
                    textDirection: updateDelegateController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return DelegateScreen();
                                }));
                          },
                          icon: const Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                      title: Text(
                        "${getLang(context, 'update_delegate_screen')}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                      backgroundColor: MyColors.DarkWHITE,
                    ),
                    body: Obx(() => !updateDelegateController.isLoading.value?  SingleChildScrollView(
                      child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 82,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getLang(context, "delegate_name")}",
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
                                        child: delegateNameInput(),
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
                              branchesRow(),
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
                                                      groupValue: updateDelegateController.isActive.value,
                                                      onChanged: (value){
                                                        setState(() {
                                                          updateDelegateController.isActive.value=1;
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
                                                      groupValue: updateDelegateController.isActive.value,
                                                      onChanged: (value){
                                                        setState(() {
                                                          updateDelegateController.isActive.value=0;
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
                              Obx(() => Visibility(
                                visible: updateDelegateController.isVisabl.value,
                                child: const CircularProgressIndicator(color: MyColors.MAINCOLORS,),
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: TextButton(
                                  style: flatButtonStyle ,
                                  onPressed: (){
                                    ValidationAndApisCall();
                                  },
                                  child: Text("${getLang(context, "save")}",
                                    style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w500,color: MyColors.DarkWHITE),),
                                ),
                              )
                            ],
                          )
                      ),
                    )
                        :const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),)),
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

  Widget delegateNameInput(){
    return TextFormField(
      controller: updateDelegateController.delegate_nameController,
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
        hintText: "${getLang(context, "enter_delegate_name")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget PhoneNumberInput(){
    return TextFormField(
      controller: updateDelegateController.phoneController,
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
        LengthLimitingTextInputFormatter(11),],
    );
  }

  Widget PasswordInput(){
    return Obx(() => TextFormField(
      controller: updateDelegateController.passwordController,
      maxLines: 1,
      obscureText: updateDelegateController.obscureText.value,

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
              updateDelegateController.obscureText.value = !updateDelegateController.obscureText.value;
              //});
            },
            child: Icon(updateDelegateController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
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
      controller: updateDelegateController.confirmPasswordController,
      maxLines: 1,
      obscureText: updateDelegateController.obscureText2.value,

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
              updateDelegateController.obscureText2.value = !updateDelegateController.obscureText2.value;
              //});
            },
            child: Icon(updateDelegateController.obscureText2.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }

  Widget branchesRow(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 53,
        padding: const EdgeInsets.only(left: 8,right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            //color: MyColors.Dark6,
            border: Border.all(width: 1,color: MyColors.Dark5)
        ),
        child: Center(
          child: Obx(
                () => DropdownButton<dynamic>(
              isExpanded: true,
              icon: const Image(image: AssetImage('assets/arrow-down- outline.png')),
              underline: Container(),
              alignment: Alignment.center,
              value: updateDelegateController.defultBranch,
              items: updateDelegateController.branches.value
                  .map<DropdownMenuItem<brunch>>((dynamic value) {
                return DropdownMenuItem<brunch>(
                  value: value,
                  child: Text(
                    value.name ?? "",
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'din_next_arabic_regulare',
                        color: MyColors.Dark2,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (dynamic? newValue) {
                setState(() {
                  updateDelegateController.defultBranch = newValue;
                });
                updateDelegateController.choose_branches = newValue!.id!;
              },
            ),
          ),
        ),
      ),
    );
  }

  ValidationAndApisCall() {
    if (updateDelegateController.delegate_nameController.text == null ||
        updateDelegateController.delegate_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateDelegateController.phoneController.text == null ||
        updateDelegateController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (updateDelegateController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      updateDelegateController.isVisabl.value = true;
      //controller.updateToken();
      updateDelegateController.updateDelegate(context!);
    }
  }

}