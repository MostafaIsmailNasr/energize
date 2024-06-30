import 'package:energize_flutter/business/updateUserController/UpdateUserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/carOwnerController/CarOwnerController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../menu/carOwner/car_owner_screen.dart';
import '../../menu/clients/clients_screen.dart';

class UpdateCarOwnerScreen extends StatefulWidget{
  int id;
  String name,phone;

  UpdateCarOwnerScreen({required this.id,required this.name,required this.phone});

  @override
  State<StatefulWidget> createState() {
    return _UpdateCarOwnerScreen();
  }
}

class _UpdateCarOwnerScreen extends State<UpdateCarOwnerScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final carOwnerController=Get.put(CarOwnerController());

  @override
  void initState() {
    carOwnerController.getLang();
    carOwnerController.ownerNameUpController.text=widget.name;
    carOwnerController.ownerPhoneUpController.text=widget.phone;
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
                textDirection: carOwnerController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize:20,
                          onPressed: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return CarOwnerScreen();
                                }));
                            //Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                      ),
                      title: Text(
                        "${getLang(context, "update_carOwner")}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                      backgroundColor: MyColors.DarkWHITE,
                    ),
                    body:Obx(() => !carOwnerController.isLoading.value? SingleChildScrollView(
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
                                    "${getLang(context, "car_owner_name")}",
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
                                      child: ownerNameInput(),
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
                            Obx(() => Visibility(
                              visible: carOwnerController.isVisabl.value,
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
                        ),
                      ),
                    )
                        :const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),))
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

  Widget ownerNameInput(){
    return TextFormField(
      controller: carOwnerController.ownerNameUpController,
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
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }


  Widget PhoneNumberInput(){
    return TextFormField(
      controller: carOwnerController.ownerPhoneUpController,
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

  ValidationAndApisCall() {
    if (carOwnerController.ownerNameUpController.text == null ||
        carOwnerController.ownerNameUpController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (carOwnerController.ownerPhoneUpController.text == null ||
        carOwnerController.ownerPhoneUpController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (carOwnerController.ownerPhoneUpController.text.length<10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      carOwnerController.isVisabl.value = true;
      carOwnerController.updateCarOwner(context,widget.id,);
    }
  }

}