import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/reportsController/ComprehensiveController.dart';
import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';
import '../../filters/home_filter/home_filter_screen.dart';

class ComprehensiveReportsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ComprehensiveReportsScreen();
  }
}

class _ComprehensiveReportsScreen extends State<ComprehensiveReportsScreen>with TickerProviderStateMixin{

 final comprehensiveController=Get.put(ComprehensiveController());


 @override
  void initState() {
   getData();
   comprehensiveController.filterKey="";
   comprehensiveController.filterStartDate="";
   comprehensiveController.filterEndDate="";
   comprehensiveController.userId=0;
   comprehensiveController.driverId=0;
   comprehensiveController.delegateId=0;
   comprehensiveController.getComprehensiveReports(
       comprehensiveController.filterKey,
       comprehensiveController.filterStartDate,
       comprehensiveController.filterEndDate,
       0,
       0,
       0);
    super.initState();
  }

  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      comprehensiveController.lang= prefs.getString('lang')!;
    });
 }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return  WillPopScope(
                onWillPop: () async {
                  SystemChrome.setSystemUIOverlayStyle(
                    const SystemUiOverlayStyle(
                      statusBarColor: Colors.black, // Set the color of the status bar
                      statusBarBrightness: Brightness.light, // Set the brightness of the status bar text and icons
                    ),
                  );
                  WidgetsFlutterBinding.ensureInitialized();
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown
                  ]);
                  return true;
                },
                child: Directionality(
                    textDirection: comprehensiveController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            iconSize:20,
                            onPressed: (){
                              if (MediaQuery.of(context).orientation == Orientation.landscape) {
                                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
                        ),
                        title: Text(
                          "${getLang(context, "Comprehensive_reports")}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'din_next_arabic_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1),
                          textAlign: TextAlign.start,
                        ),
                        backgroundColor: MyColors.DarkWHITE,
                      ),
                      body:Obx(() => !comprehensiveController.isLoading.value? SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 15,right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${getLang(context, "Shipment_reports")}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'din_next_arabic_bold',
                                        fontWeight: FontWeight.w700,
                                        color: MyColors.Dark1),
                                    textAlign: TextAlign.start,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                          ),
                                          transitionAnimationController: AnimationController(vsync: this,duration: Duration(seconds: 1)),
                                          builder: (BuildContext context)=>DraggableScrollableSheet(
                                              expand: false,
                                              initialChildSize: 0.9,
                                              minChildSize: 0.32,
                                              maxChildSize: 0.9,
                                              builder: (BuildContext context, ScrollController scrollController)=> SingleChildScrollView(
                                                controller:scrollController,
                                                child: HomeFilterScreen(fromWhere: "ComprehensiveReportsScreen"),
                                              )
                                          )
                                      );
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 0,
                                              color: MyColors.Dark3
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: MyColors.Dark5,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset('assets/filter.svg'),
                                            Text("${getLang(context, "filter")}",
                                              style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              ReportsTable(),
                            ],
                          ),
                        ),
                      )
                          :const Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,),))
                  ),
                ),
              );
            } else {
              return  WillPopScope(
                  onWillPop: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown
                    ]);
                    return true;
                  },
                  child: Scaffold(body: NoIntrnet())
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.MAINCOLORS,
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

  Widget ReportsTable(){
    final Columns=["#",
      "${getLang(context, 'date')}",
      "${getLang(context, 'branch')}",
      "${getLang(context, 'car_type')}",
      "${getLang(context, 'car_length')}",
      "${getLang(context, 'delegate')}",
      "${getLang(context, 'clients')}",
      "${getLang(context, 'Download_from')}",
      "${getLang(context, 'Download_to')}",
      "${getLang(context, 'drivers')}",
      "${getLang(context, 'phone_number')}",
      "${getLang(context, 'car_number')}",
      "${getLang(context, 'Graduation_statement')}",
      "${getLang(context, 'car_status')}",
      "${getLang(context, 'rent_type')}",
      "${getLang(context, 'Purchasing_price')}",
      "${getLang(context, 'advance')}",
      "${getLang(context, 'selling_price')}",
      "${getLang(context, 'difference')}",];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) {return MyColors.Dark6;},),
          columns: getColumns(Columns),
          //rows: getRows(rows)
        rows: List.generate(comprehensiveController.comprehensiveList.length, (index) {
          final id = comprehensiveController.reportsResponse.value.data?.orders![index].id ;
          final date = comprehensiveController.reportsResponse.value.data?.orders![index].createdAt ;
          final branchName = comprehensiveController.reportsResponse.value.data?.orders![index].branchName ;
          final carType = comprehensiveController.reportsResponse.value.data?.orders![index].carTypeName ;
          final carLength = comprehensiveController.reportsResponse.value.data?.orders![index].carLengthName ;
          final delegate = comprehensiveController.reportsResponse.value.data?.orders![index].delegateName ;
          final client = comprehensiveController.reportsResponse.value.data?.orders![index].userName ;
          final downloadFrom = comprehensiveController.reportsResponse.value.data?.orders![index].startAreaName ;
          final downloadTo = comprehensiveController.reportsResponse.value.data?.orders![index].reachAreaName ;
          final driver = comprehensiveController.reportsResponse.value.data?.orders![index].driverName ;
          ///
          final phoneNumber = comprehensiveController.reportsResponse.value.data?.orders![index].driverMobile ;
          final carNumber = comprehensiveController.reportsResponse.value.data?.orders![index].carNumber ;
          final graduation = comprehensiveController.reportsResponse.value.data?.orders![index].graduationStatement ;
          ///
          final carStatus = comprehensiveController.reportsResponse.value.data?.orders![index].status ;
          ///
          final rentType = comprehensiveController.reportsResponse.value.data?.orders![index].paymentMethod ;
          final purchasingPrice = comprehensiveController.reportsResponse.value.data?.orders![index].purchasePrice ;
          final advance = comprehensiveController.reportsResponse.value.data?.orders![index].loan ;
          final sellingPrice = comprehensiveController.reportsResponse.value.data?.orders![index].salePrice ;
          final difference = comprehensiveController.reportsResponse.value.data?.orders![index].difference ;

          return DataRow(cells: [
            DataCell(Center(child: Text(id.toString()))),
            DataCell(Center(child: Text(date.toString()))),
            DataCell(Center(child: Text(branchName.toString()))),
            DataCell(Center(child: Text(carType.toString()))),
            DataCell(Center(child: Text(carLength.toString()))),
            DataCell(Center(child: Text(delegate.toString()))),
            DataCell(Center(child: Text(client.toString()))),
            DataCell(Center(child: Text(downloadFrom.toString()))),
            DataCell(Center(child: Text(downloadTo.toString()))),
            DataCell(Center(child: Text(driver.toString()))),
            DataCell(Center(child: Text(phoneNumber.toString()))),
            DataCell(Center(child: Text(carNumber.toString()))),
            DataCell(Center(child: Text(graduation.toString()))),
            DataCell(Center(child: Text(carStatus.toString()))),
            DataCell(Center(child: Text(rentType.toString()))),
            DataCell(Center(child: Text(purchasingPrice.toString()))),
            DataCell(Center(child: Text(advance.toString()))),
            DataCell(Center(child: Text(sellingPrice.toString()))),
            DataCell(Center(child: Text(difference.toString()))),
          ]);
        }),
      ),
    );
  }

  List<DataColumn>getColumns(List<String>Columns)=>Columns
      .map(
          (String column) => DataColumn(label: Text(column))
  ).toList();
 Brightness get preferredStatusBarStyle => Brightness.light;

}