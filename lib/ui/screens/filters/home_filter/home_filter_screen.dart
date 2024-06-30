import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/addPayloadController/AddPayloadController.dart';
import '../../../../business/reportsController/ComprehensiveController.dart';
import '../../../../business/shipmentCategoryDetailsController/ShipmentCategoryDetailsController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../../../../data/model/addPayloadModel/cities/CitiesResponse.dart';
import 'choose_branch_filter/choose_branch_filter_screen.dart';
import 'choose_client_filter/choose_client_filter_screen.dart';
import 'choose_delegate_filter/choose_delegate_filter_screen.dart';
import 'choose_driver_filter/choose_driver_filter_screen.dart';

enum dateGroup{today,yesterday,last_seven_days,this_month,last_month,last_ninety_days,this_year,last_year,from_start,custom}
class HomeFilterScreen extends StatefulWidget{
  String fromWhere;
  HomeFilterScreen({required this.fromWhere});

  @override
  State<StatefulWidget> createState() {
    return _HomeFilterScreen(fromWhere: fromWhere);
  }
}

class _HomeFilterScreen extends State<HomeFilterScreen>{
  dateGroup date=dateGroup.today;
  DateTime?FromDate;
  DateTime?ToDate;
  String fromWhere;
  bool isVisible=false;
  _HomeFilterScreen({required this.fromWhere});
  final shipmentCategoryController=Get.put(ShipmentCategoryDetailsController());
  final comprehensiveController=Get.put(ComprehensiveController());

@override
  void initState() {
  comprehensiveController.isButtonEnabled=true;
  comprehensiveController.getData();
    super.initState();
  comprehensiveController.getCities();
  comprehensiveController.getCarType();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15,left: 15,top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return  Directionality(
                textDirection: comprehensiveController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomBar(),
                Obx(() =>!comprehensiveController.isLoading.value?FilterContainer(context)
                :const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.MAINCOLORS,
                  ),
                )),
                  ],
                ),
              );
            } else {
              return Padding(
                     padding: const EdgeInsets.only(top: 100),
                     child: NoIntrnet(),
                   );
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

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 60,
            height: 5,
            color: MyColors.Dark6,),
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
                  child: Text("${getLang(context, "filter")}",
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

  Widget FilterContainer(BuildContext context){
    return Column(
      children: [
        FilterByDate(),
        chooseDate(context),
        SizedBox(height: 8,),
        graduationStatement(),
        const SizedBox(height: 8,),
        (fromWhere=="ComprehensiveReportsScreen")?Container():CarNum(),
        DriverClientRow(),
        (fromWhere=="ComprehensiveReportsScreen")? locationRow():Container(),
          (fromWhere=="ComprehensiveReportsScreen")? CarRow():Container(),
        ButtonSave()
      ],
    );
  }
  Widget FilterByDate(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${getLang(context, "date")}",
          style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark2,),
          textAlign: TextAlign.start,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "today")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.today,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "yesterday")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.yesterday,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "last7days")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.last_seven_days,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "current_month")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.this_month,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "Last_month")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.last_month,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "last90days")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.last_ninety_days,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "current_year")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.this_year,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "last_year")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.last_year,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),

          ],
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title: Text("${getLang(context, "From_the_beginning")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.from_start,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=false;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: MyColors.MAINCOLORS,
                contentPadding: EdgeInsets.all(0),
                title:  Text("${getLang(context, "custom")}",
                    style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2)),
                value: dateGroup.custom,
                groupValue: date,
                onChanged: (dateGroup? val){
                  setState(() {
                    date = val!;
                    isVisible=!isVisible;
                  });
                },
              ),
            ),

          ],
        )
      ],
    );
  }

  Widget chooseDate(BuildContext context){
    DateTime date=DateTime.now();
    DateTime?newDate;
    DateTime?newDate2;
    return Visibility(
      visible: isVisible,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    setState(() async{
                      newDate =await showDatePicker(
                        builder: (context,child){
                          return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: MyColors.MAINCOLORS,
                                  onPrimary: MyColors.DarkWHITE,
                                  onSurface: MyColors.Dark2,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: MyColors.MAINCOLORS, // button text color
                                  ),
                                ),
                              ),
                              child: child!);
                        },
                        context:context,
                        initialDate: date,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2100),);
                      if(newDate==null) return;
                      setState(() {
                        FromDate=newDate!;
                        // String inputTime=newDate.toString();
                        // final inputFormat = DateFormat('yyyy-MM-dd');
                        // DateTime dateTime = inputFormat.parse(inputTime);
                        // FromDate = dateTime;
                        print(FromDate);
                      });
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    //margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: MyColors.Dark5,
                        width: 1
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/calendar.svg'),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(FromDate==null?"${getLang(context, "from_date")}":FromDate.toString(),maxLines: 1,
                            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    setState(() async{
                      newDate2 =await showDatePicker(
                        builder: (context,child){
                          return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  onPrimary: MyColors.DarkWHITE,
                                    primary: MyColors.MAINCOLORS,
                                onSurface: MyColors.Dark1,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: MyColors.MAINCOLORS, // button text color
                                  ),
                                ),
                              ),
                              child: child!);
                        },
                        context:context,
                        initialDate: date,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2100),);
                      if(newDate2==null) return;
                      setState(() {
                        ToDate=newDate2!;
                        print(ToDate);
                      });
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    //margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: MyColors.Dark5,
                          width: 1
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/calendar.svg'),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Text(ToDate==null?"${getLang(context, "to_date")}":ToDate.toString(),maxLines: 1,
                            style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget DriverClientRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               Text(
                 "${getLang(context, "Sort_by")}",
                 style: const TextStyle(
                     fontSize: 16,
                     fontFamily: 'din_next_arabic_medium',
                     fontWeight: FontWeight.w500,
                     color: MyColors.Dark2),
                 textAlign: TextAlign.start,
               ),
               const SizedBox(width: 5,),
               Text(
                 "${getLang(context, "select")}",
                 style: const TextStyle(
                     fontSize: 14,
                     fontFamily: 'din_next_arabic_regulare',
                     fontWeight: FontWeight.w400,
                     color: MyColors.Dark3),
                 textAlign: TextAlign.start,
               ),
             ],
           ),
           const SizedBox(height: 10,),
           Row(
             children: [
               Expanded(
                 child: GestureDetector(
                  onTap: () {
                    FilterHomeDriver();
                  },
                  child: Container(
                     width: MediaQuery.of(context).size.width,
                     height: 53,
                     padding: EdgeInsets.only(left: 8,right: 8),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         //color: MyColors.Dark6,
                         border: Border.all(width: 1,color: MyColors.Dark5)
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "${getLang(context, "choose_driver")}",
                           style: TextStyle(
                               fontSize: 14,
                               fontFamily: 'din_next_arabic_regulare',
                               fontWeight: FontWeight.w400,
                               color: MyColors.Dark2),
                           textAlign: TextAlign.start,
                         ),
                         Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                       ],
                     ),
                   ),
                 ),
               ),
               SizedBox(width: 10,),
               Expanded(
                 child: GestureDetector(
                   onTap: (){
                     FilterHomeClient();
                   },
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     height: 53,
                     padding: EdgeInsets.only(left: 8,right: 8),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8),
                         //color: MyColors.Dark6,
                         border: Border.all(width: 1,color: MyColors.Dark5)
                     ),
                     child:Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "${getLang(context, "choose_client")}",
                           style: TextStyle(
                               fontSize: 14,
                               fontFamily: 'din_next_arabic_regulare',
                               fontWeight: FontWeight.w400,
                               color: MyColors.Dark2),
                           textAlign: TextAlign.start,
                         ),
                         Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                       ],
                     ),
                   ),
                 ),
               ),
             ],
           ),
           SizedBox(height: 10,),
           GestureDetector(
             onTap: (){
               FilterHomeDelegate();
             },
             child: Container(
               width: MediaQuery.of(context).size.width,
               height: 53,
               padding: EdgeInsets.only(left: 8,right: 8),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),

                   border: Border.all(width: 1,color: MyColors.Dark5)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     "${getLang(context, "Choose_delegate")}",
                     style: TextStyle(
                         fontSize: 14,
                         fontFamily: 'din_next_arabic_regulare',
                         fontWeight: FontWeight.w400,
                         color: MyColors.Dark2),
                     textAlign: TextAlign.start,
                   ),
                   Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                 ],
               ),
             ),
           ),
           SizedBox(height: 10,),
           fromWhere== "ShipmentCategoryDetailsScreen"?GestureDetector(
             onTap: (){
               FilterHomeBranch();
             },
             child: Container(
               width: MediaQuery.of(context).size.width,
               height: 53,
               padding: EdgeInsets.only(left: 8,right: 8),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),

                   border: Border.all(width: 1,color: MyColors.Dark5)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     "${getLang(context, "choose_branch")}",
                     style: const TextStyle(
                         fontSize: 14,
                         fontFamily: 'din_next_arabic_regulare',
                         fontWeight: FontWeight.w400,
                         color: MyColors.Dark2),
                     textAlign: TextAlign.start,
                   ),
                   Icon(Icons.arrow_forward_ios,color: MyColors.Dark7,size: 20,)
                 ],
               ),
             ),
           ):Container(),
         ],
      ),
    );
  }

  Widget locationRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          /*Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Center(
                child:
                Obx(() => DropdownButton<dynamic>(
                  isExpanded: true,
                  icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                  underline:Container(),
                  alignment: Alignment.center,
                  value: addPayloadController.city,
                  items: addPayloadController.cities.value.map<DropdownMenuItem<City>>((dynamic value) {
                    return DropdownMenuItem<City>(
                      value: value,
                      child: Text(
                        value.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (dynamic? newValue) {
                    setState(() {
                      addPayloadController.city=newValue;
                    });
                    addPayloadController.launch_area = newValue!.id!;
                  },
                ),)
              ),
            ),
          ),*/
          Expanded(
              child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: comprehensiveController.cities.value,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Select City",
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.Dark5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    comprehensiveController.city = newValue;
                  });
                  comprehensiveController.launch_area = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  City city = item as City;
                  return city!.name!;
                },
                //selectedItem: addPayloadController.city!.name),
              )
          ),
          SizedBox(width: 5,),
          Expanded(
            child: DropdownSearch<dynamic>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (ctx, item, isSelected) {
                  return Container(
                    height: 40,
                    child: Text(
                      item.name??"",
                      style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,),
                  );
                },
              ),
              items: comprehensiveController.cities.value,
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Select City",
                  hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.Dark5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              onChanged: (dynamic? newValue) {
                setState(() {
                  comprehensiveController.cityArrived = newValue;
                });
                comprehensiveController.access_area = newValue!.id!;
              },
              filterFn: (item, query) {
                return item.name.toLowerCase().contains(query.toLowerCase());
              },
              itemAsString: (dynamic item) {
                City city = item as City;
                return city!.name!;
              },
              //selectedItem: addPayloadController.cityArrived!.name
            ),
          ),
          /*Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 53,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //color: MyColors.Dark6,
                  border: Border.all(width: 1,color: MyColors.Dark5)
              ),
              child: Center(
                child: Obx(() => DropdownButton<dynamic>(
                  isExpanded: true,
                  icon:Image(image: AssetImage('assets/arrow-down- outline.png')) ,
                  underline:Container(),
                  alignment: Alignment.center,
                  value: addPayloadController.cityArrived,
                  items: addPayloadController.cities.value.map<DropdownMenuItem<City>>((dynamic value) {
                    return DropdownMenuItem<City>(
                      value: value,
                      child: Text(
                        value.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (dynamic? newValue) {
                    setState(() {
                      addPayloadController.cityArrived=newValue;
                    });
                    addPayloadController.access_area = newValue!.id!;
                  },
                ),)
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget CarRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      child: Row(
        children: [
          Expanded(
              child: DropdownSearch<dynamic>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (ctx, item, isSelected) {
                    return Container(
                      height: 40,
                      child: Text(
                        item.name??"",
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    );
                  },
                ),
                items: comprehensiveController.carType2.value,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Select car",
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',color: MyColors.Dark2,fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.Dark5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                onChanged: (dynamic? newValue) {
                  setState(() {
                    comprehensiveController.car = newValue;
                  });
                  comprehensiveController.dropdownValue = newValue!.id!;
                },
                filterFn: (item, query) {
                  return item.name.toLowerCase().contains(query.toLowerCase());
                },
                itemAsString: (dynamic item) {
                  TypeCar typeCar = item as TypeCar;
                  return typeCar!.name!;
                },
                //selectedItem: addPayloadController.car!.name.toString()),
              )
          ),
        ],
      ),
    );
  }

  Widget graduationStatement(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      padding: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1, color: MyColors.Dark5)),
      child: TextFormField(
        controller: shipmentCategoryController.GraduationController,
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
          hintText: "${getLang(context, "Graduation_statement")}",
          hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
        ),
        style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
        //keyboardType: TextInputType.number,
        //textInputAction: TextInputAction.done,
          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true)
      ),
    );
  }

  Widget CarNum(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 53,
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: MyColors.Dark6,
          border: Border.all(width: 1, color: MyColors.Dark5)),
      child: TextFormField(
        controller: shipmentCategoryController.CarNumController,
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
          hintText: "${getLang(context, "car_number")}",
          hintStyle: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
        ),
        style: TextStyle(color: MyColors.Dark2,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'din_next_arabic_regulare'),
        //keyboardType: TextInputType.number,
        //textInputAction: TextInputAction.done,
        //keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true)
      ),
    );
  }

  Widget ButtonSave(){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        backgroundColor: MyColors.MAINCOLORS,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width:MediaQuery.of(context).size.width,
      height: 60,
      child: TextButton(
        style: flatButtonStyle ,
        onPressed:comprehensiveController.isButtonEnabled ? () => press():null,
        child: Text("${getLang(context, "apply")}",
          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.DarkWHITE),),
      ),
    );
  }
  press()async{
    {
      if(fromWhere=="ComprehensiveReportsScreen"){
        if(date.name.toString()=="custom"){
          comprehensiveController.filterKey="";
        }else{
          comprehensiveController.filterKey=date.name.toString();
        }
        comprehensiveController.filterStartDate=(FromDate.toString()!="null"?FromDate.toString():"");
        comprehensiveController.filterEndDate=(ToDate.toString()!="null"?ToDate.toString():"");
        comprehensiveController.launch_area=comprehensiveController.launch_area ?? 0;
        comprehensiveController.access_area=comprehensiveController.access_area ?? 0;
        comprehensiveController.dropdownValue==comprehensiveController.dropdownValue ?? 0;
        comprehensiveController.filterInReports(
            comprehensiveController.filterKey,
            comprehensiveController.filterStartDate,
            comprehensiveController.filterEndDate,
            comprehensiveController.launch_area!,
            comprehensiveController.access_area!,
            comprehensiveController.dropdownValue!);
        setState(() {
          comprehensiveController.isButtonEnabled=false;
        });

      }
      else{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var state=prefs.getString("status1")!;
        if(date.name.toString()=="custom"){
          shipmentCategoryController.filterKey="";
        }else{
          shipmentCategoryController.filterKey=date.name.toString();
        }
        shipmentCategoryController.filterStartDate=(FromDate.toString()!="null"?FromDate.toString():"");
        shipmentCategoryController.filterEndDate=(ToDate.toString()!="null"?ToDate.toString():"");
        shipmentCategoryController.filter(
            state,
            shipmentCategoryController.filterKey,
            shipmentCategoryController.filterStartDate,
            shipmentCategoryController.filterEndDate);
      }
    }
  }

  FilterHomeDriver(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDriverFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDriverFilterScreen(FromWhere: "fromCategoriesStatus")));
    }
  }

  FilterHomeClient(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseClientFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseClientFilterScreen(FromWhere: "fromCategoriesStatus")));
    }
  }

  FilterHomeDelegate(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDelegateFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseDelegateFilterScreen(FromWhere: "fromCategoriesStatus")));
    }
  }

  FilterHomeBranch(){
    if(fromWhere=="ComprehensiveReportsScreen"){
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseBranchFilterScreen(FromWhere: "ComprehensiveReportsScreen")));
    }
    else{
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      }
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          backgroundColor: MyColors.DarkWHITE,
          builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChooseBranchFilterScreen(FromWhere: "fromCategoriesStatus")));
    }
  }
}