import 'package:energize_flutter/business/addDriverController/AddDriverController.dart';
import 'package:energize_flutter/ui/screens/menu/drivers/drivers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/CompressionUtil.dart';
import '../../../../../conustant/my_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class AddDriverScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddDriverScreen();
  }
}

class _AddDriverScreen extends State<AddDriverScreen>{

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MAINCOLORS,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
  final imagePicker=ImagePicker();
  final addDriverController=Get.put(AddDriverController());

  @override
  void initState() {
    addDriverController.getLang();
    addDriverController.isActive.value=1;
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
                    textDirection: addDriverController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return DriverScreen();
                                  }));
                              //Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "add_driver")}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1),
                          textAlign: TextAlign.start,
                        ),
                        backgroundColor: MyColors.DarkWHITE,
                      ),
                      body:Obx(() => !addDriverController.isLoading.value?
                      SingleChildScrollView(
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
                                      style: TextStyle(
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
                                        padding: EdgeInsets.only(left: 8, right: 8),
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
                                                      groupValue: addDriverController.isActive.value,
                                                      onChanged: (value){
                                                        setState(() {
                                                          addDriverController.isActive.value=1;
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
                                                      groupValue: addDriverController.isActive.value,
                                                      onChanged: (value){
                                                        setState(() {
                                                          addDriverController.isActive.value=0;
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width:MediaQuery.of(context).size.width,
                                        height: 135,
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
                                                  //uploadImage(source: ImageSource.gallery);
                                                  _uploadImage();
                                                });
                                              },
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(15),
                                                color: MyColors.MAINCOLORS,//color of dotted/dash line
                                                strokeWidth: 1, //thickness of dash/dots
                                                dashPattern: const [10,6],
                                                child:addDriverController.imageLicense!=null? Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image:DecorationImage(image: FileImage(addDriverController.imageLicense!),fit: BoxFit.fill),
                                                  ),
                                                ):Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color:MyColors.framedashed,
                                                  ),
                                                  child: Center(
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
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 135,
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
                                                child:addDriverController.imageCar!=null? Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image:DecorationImage(image: FileImage(addDriverController.imageCar!),fit: BoxFit.fill),
                                                  ),
                                                ): Container(
                                                  height:100,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color:MyColors.framedashed,
                                                  ),
                                                  child: Center(
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
                                            )
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
                                height: 135,
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
                                        child:addDriverController.ImageResidence!=null? Container(
                                          height:100,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image:DecorationImage(image: FileImage(addDriverController.ImageResidence!),fit: BoxFit.fill),
                                          ),
                                        ): Container(
                                          height:100,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color:MyColors.framedashed,
                                          ),
                                          child: Center(
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Obx(() => Visibility(
                                visible: addDriverController.isVisabl.value,
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
                      ):const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),)
                      )),
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
      controller: addDriverController.driverNameController,
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
        hintText: "${getLang(context, "enter_driver_name")}",
        hintStyle: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
      //keyboardType: TextInputType.number,
    );
  }

  Widget PhoneNumberInput(){
    return TextFormField(
      controller: addDriverController.phoneController,
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
      controller: addDriverController.passwordController,
      maxLines: 1,
      obscureText: addDriverController.obscureText.value,

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
              addDriverController.obscureText.value = !addDriverController.obscureText.value;
              //});
            },
            child: Icon(addDriverController.obscureText.value ? Icons.visibility_off :  Icons.visibility),
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
      controller: addDriverController.confirmPasswordController,
      maxLines: 1,
      obscureText: addDriverController.obscureText2.value,

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
              addDriverController.obscureText2.value = !addDriverController.obscureText2.value;
              //});
            },
            child: Icon(addDriverController.obscureText2.value ? Icons.visibility_off :  Icons.visibility),
          ),
        ),
      ),
      style: const TextStyle(color: MyColors.Dark2,fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),],
    ));
  }



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
                        addDriverController.imageLicense=File(pickedImage!.path);
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
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 20);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        addDriverController.imageLicense=File(pickedImage!.path);
                      });
                      addDriverController.imageLicense = await CompressionUtil.compressImage(pickedImage.path);
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
                        addDriverController.imageCar=File(pickedImage!.path);
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
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 20);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        addDriverController.imageCar=File(pickedImage!.path);
                      });
                      addDriverController.imageCar = await CompressionUtil.compressImage(pickedImage.path);

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
                    final pickedImage = await picker.getImage(source: ImageSource.camera,imageQuality: 20);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        addDriverController.ImageResidence=File(pickedImage!.path);
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
                    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 20);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        addDriverController.ImageResidence=File(pickedImage!.path);
                      });
                      addDriverController.ImageResidence = await CompressionUtil.compressImage(pickedImage.path);

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
    if (addDriverController.driverNameController.text == null ||
        addDriverController.driverNameController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_name')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.phoneController.text == null ||
        addDriverController.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_phone_number')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.phoneController.text.length < 10) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'phone_number_length')}"),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.passwordController.text == null ||
        addDriverController.passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.passwordController.text.length <6) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_correct_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.confirmPasswordController.text == null ||
        addDriverController.confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_confirm_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.confirmPasswordController.text.length <6) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_correct_confirm_password')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.imageLicense == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_License_picture')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.imageCar == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_car_registration_picture')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.ImageResidence == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'enter_residence_picture')}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    else if (addDriverController.passwordController.text != addDriverController.confirmPasswordController.text) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("${getLang(context!, 'password_does_not_match_definition')}"),
          backgroundColor: Colors.red,
        ),
      );
    }

    else {
      addDriverController.isVisabl.value = true;
      addDriverController.AddDriver(context!);
    }
  }
}