import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../business/addDelegateController/AddDelegateController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';
import '../../../../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../delegate_screen.dart';


class AddDelegateScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _AddDelegateScreen();
  }
}

class _AddDelegateScreen extends State<AddDelegateScreen>{

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final addDelegateController=Get.put(AddDelegateController());

  @override
  void initState() {
    addDelegateController.getBranch();
    addDelegateController.isActive.value=1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !addDelegateController.isLoading.value?
    SafeArea(
      child: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Directionality(
                    textDirection: addDelegateController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return DelegateScreen();
                                }));
                            //Navigator.pushNamed(context, '/delegate_screen');
                          },
                          icon: Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                      title: Text(
                        "${getLang(context, "add_delegate")}",
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
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 53,
                                      child: Container(
                                        width: 327,
                                        height: 53,
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            //color: MyColors.Dark6,
                                            border: Border.all(
                                                width: 1, color: MyColors.Dark5)),
                                        child: clientNameInput(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                                            border: Border.all(
                                                width: 1, color: MyColors.Dark5)),
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
                              const SizedBox(
                                height: 10,
                              ),
                              branchesRow(),
                              const SizedBox(
                                height: 10,
                              ),
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
                                                    groupValue: addDelegateController.isActive.value,
                                                    onChanged: (value){
                                                      setState(() {
                                                        addDelegateController.isActive.value=1;
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
                                                    groupValue: addDelegateController.isActive.value,
                                                    onChanged: (value){
                                                      setState(() {
                                                        addDelegateController.isActive.value=0;
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
                              const SizedBox(
                                height: 10,
                              ),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 53,
                                      child: Container(
                                        width: 327,
                                        height: 53,
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            //color: MyColors.Dark6,
                                            border: Border.all(
                                                width: 1, color: MyColors.Dark5)),
                                        child: PasswordInput(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                                            border: Border.all(
                                                width: 1, color: MyColors.Dark5)),
                                        child: confirmPasswordInput(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(() => Visibility(
                                visible: addDelegateController.isVisabl.value,
                                child: const CircularProgressIndicator(
                                  color: MyColors.MAINCOLORS,
                                ),
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: TextButton(
                                  style: flatButtonStyle,
                                  onPressed: () {
                                    ValidationAndApisCall();
                                    // addDelegateController.isVisabl.value = true;
                                    // addDelegateController.AddDelegate(context);
                                  },
                                  child: Text(
                                    "${getLang(context, "save")}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'din_next_arabic_bold',
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.DarkWHITE),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  )
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
    )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: MyColors.MAINCOLORS,
              ),
            ),
          ));
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

  Widget clientNameInput(){
    return TextFormField(
      controller: addDelegateController.delegate_nameController,
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
      controller: addDelegateController.phoneController,
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)],
    );
  }

  Widget PasswordInput(){
    return Obx(() => TextFormField(
      controller: addDelegateController.passwordController,
      maxLines: 1,
      obscureText: addDelegateController.obscureText.value,

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
          padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
          child: GestureDetector(
            onTap: (){
              //setState(() {
                addDelegateController.obscureText.value = !addDelegateController.obscureText.value;
              //});
            },
            child: Icon(addDelegateController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
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
      controller: addDelegateController.confirmPasswordController,
      maxLines: 1,
      obscureText: addDelegateController.obscureText2.value,

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
                addDelegateController.obscureText2.value = !addDelegateController.obscureText2.value;
              //});
            },
            child: Icon(addDelegateController.obscureText2.value ? Icons.visibility_off :  Icons.visibility),
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
              value: addDelegateController.defultBranch,
              items: addDelegateController.branches.value
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
                  addDelegateController.defultBranch = newValue;
                });
                addDelegateController.choose_branches = newValue!.id!;
              },
            ),
          ),
        ),
      ),
    );
  }

  ValidationAndApisCall() {
    if (addDelegateController.delegate_nameController.text == null ||
        addDelegateController.delegate_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.phoneController.text == null ||
        addDelegateController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context, 'phone_number_length')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.passwordController.text == null ||
        addDelegateController.passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${getLang(context, 'enter_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.passwordController.text.length <6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${getLang(context, 'enter_correct_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.confirmPasswordController.text == null ||
        addDelegateController.confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${getLang(context, 'enter_confirm_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDelegateController.confirmPasswordController.text.length <6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${getLang(context, 'enter_correct_confirm_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      addDelegateController.isVisabl.value = true;
      //controller.updateToken();
      addDelegateController.AddDelegate(context);
    }
  }

}