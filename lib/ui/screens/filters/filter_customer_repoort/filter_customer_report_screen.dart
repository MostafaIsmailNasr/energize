import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../business/reportsController/ComprehensiveController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/addPayloadModel/carTypeModel/CarTypeResponse.dart';
import '../../../../data/model/addPayloadModel/cities/CitiesResponse.dart';

enum dateGroup{today,yesterday,last_seven_days,this_month,last_month,last_ninety_days,this_year,last_year,from_start,custom}
class FilterCustomerReportScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FilterCustomerReportScreen();
  }
}

class _FilterCustomerReportScreen extends State<FilterCustomerReportScreen>{
  dateGroup date=dateGroup.today;
  DateTime?FromDate;
  DateTime?ToDate;
  bool isVisible=false;

  final comprehensiveController=Get.put(ComprehensiveController());

  @override
  void initState() {
    comprehensiveController.isButtonEnabled=true;
    super.initState();
    comprehensiveController.getCities();
    comprehensiveController.getCarType();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
      child: Container(
        //height: 400,
        width: MediaQuery.of(context).size.width,
        child: Directionality(
          textDirection: comprehensiveController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBar(),
              FilterContainer(context),
            ],
          ),
        ),
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
        locationRow(),
        CarRow(),
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
                                  onPrimary: MyColors.Dark1,
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
                      if(newDate==null) return;
                      setState(() {
                        FromDate=newDate!;
                        print(date);
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
                                  primary: MyColors.MAINCOLORS,
                                  onPrimary: MyColors.Dark1,
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
                        print(date);
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

  Widget ButtonSave(){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        backgroundColor: MyColors.MAINCOLORS,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
    return Container(
      margin: EdgeInsets.only(top: 10),
      width:MediaQuery.of(context).size.width,
      height: 60,
      child: TextButton(
        style: flatButtonStyle ,
        onPressed: comprehensiveController.isButtonEnabled ? () => pressButton():null,
        child: Text("${getLang(context, "apply")}",
          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.DarkWHITE),),
      ),
    );
  }

  pressButton(){
    if(date.name.toString()=="custom"){
      comprehensiveController.filterKeyCus="";
    }else{
      comprehensiveController.filterKeyCus=date.name.toString();
    }
    comprehensiveController.filterStartDateCus=(FromDate.toString()!="null"?FromDate.toString():"");
    comprehensiveController.filterEndDateCus=(ToDate.toString()!="null"?ToDate.toString():"");
    comprehensiveController.launch_area=comprehensiveController.launch_area ?? 0;
    comprehensiveController.access_area=comprehensiveController.access_area ?? 0;
    comprehensiveController.dropdownValue==comprehensiveController.dropdownValue ?? 0;
    comprehensiveController.filterInCustomerReports(
        comprehensiveController.filterKeyCus,
        comprehensiveController.filterStartDateCus,
        comprehensiveController.filterEndDateCus,
        comprehensiveController.launch_area!,
        comprehensiveController.access_area!,
        comprehensiveController.dropdownValue!);
    setState(() {
      comprehensiveController.isButtonEnabled=false;
    });
  }

}