import 'package:energize_flutter/conustant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/model/addPayloadModel/brunchesModel/BranchesResponse.dart';
import '../../data/model/addPayloadModel/chooseDriverModel/ChooseDriverResponse.dart';
import '../../data/model/addPayloadModel/chooseUserModel/ChooseUserResponse.dart';
import '../../data/model/chooseDelegateModel/ChooseDelegateResponse.dart';

class ClientAndDriverItem extends StatefulWidget{
  String fromWhere;
   ChooseDriver? driver;
   ChooseUser? user;
  final bool selected;
  GestureTapCallback? onTap;
  ChooseDelegate? delegate;
  brunch? branch;

  ClientAndDriverItem(this.driver, this.fromWhere,this.user,this.selected,this.onTap,this.delegate,this.branch);

  @override
  State<StatefulWidget> createState() {
    return _ClientAndDriverItem(driver,fromWhere, user,onTap,delegate);
  }
}

class _ClientAndDriverItem extends State<ClientAndDriverItem>{
  List<ChooseDriver> SelectedDriverList=[];
  String fromWhere;
  final ChooseDriver? driver;
  final ChooseUser? user;
  GestureTapCallback? onTap;
  ChooseDelegate? delegate;


  _ClientAndDriverItem(this.driver, this.fromWhere,this.user,this.onTap,this.delegate);

  @override
  Widget build(BuildContext context) {
    if(fromWhere=="ChooseDriverScreen"){
      return InkWell(
        onTap: onTap,
        child: Container(
            width:MediaQuery.of(context).size.width,
            padding: EdgeInsetsDirectional.all(10),
            margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: MyColors.Dark5
                  )
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration:driver!.avatar!.isNotEmpty?
                  BoxDecoration(
                      image: DecorationImage(image: NetworkImage(driver!.avatar!),fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(50)):
                  BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/pic.png")),
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(driver!.name!,
                          style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                        ),
                        Text(driver!.mobile!,
                          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: widget.selected?
                  Center(
                    child: SvgPicture.asset('assets/checked.svg'),
                  ):
                  Center(
                    child: Image(image: AssetImage('assets/Rectangle_6.png')),
                  ),
                ),
              ],
            ),
        ),
      );
    }
    else if(fromWhere=="ChooseClientFilterScreen"){
      return InkWell(
        onTap: onTap,
        child: Container(
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.all(10),
          margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: MyColors.Dark5
                )
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration:user!.avatar!.isNotEmpty?
                BoxDecoration(
                    image: DecorationImage(image: NetworkImage(user!.avatar!),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(50)):
                BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/pic.png")),
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user!.name!,
                        style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                      ),
                      Text(user!.mobile!,
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                child: widget.selected?
                Center(
                  child: SvgPicture.asset('assets/checked.svg'),
                ):
                Center(
                  child: Image(image: AssetImage('assets/Rectangle_6.png')),
                ),
              ),
            ],
          ),

        ),
      );
    }
    else if(fromWhere=="ChooseDelegateScreen"){
      return InkWell(
        onTap: onTap,
        child: Container(
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.all(10),
          margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: MyColors.Dark5
                )
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration:delegate!.avatar!.isNotEmpty?
                BoxDecoration(
                    image: DecorationImage(image: NetworkImage(delegate!.avatar!),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(50)):
                BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/pic.png")),
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(delegate!.name!,
                        style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                      ),
                      Text(delegate!.mobile!,
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                child: widget.selected?
                Center(
                  child: SvgPicture.asset('assets/checked.svg'),
                ):
                Center(
                  child: Image(image: AssetImage('assets/Rectangle_6.png')),
                ),
              ),
            ],
          ),

        ),
      );
    }
    else if(fromWhere=="ChooseBranchScreen"){
      return InkWell(
        onTap: onTap,
        child: Container(
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.all(10),
          margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: MyColors.Dark5
                )
            ),
          ),
          child: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(image: AssetImage('assets/logo2.png',),fit: BoxFit.fill),
                      border: Border.all(
                          width: 1,
                          color: MyColors.Dark3
                      )
                  )
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Text(widget.branch!.name!,
                  style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                child: widget.selected?
                Center(
                  child: SvgPicture.asset('assets/checked.svg'),
                ):
                Center(
                  child: Image(image: AssetImage('assets/Rectangle_6.png')),
                ),
              ),
            ],
          ),

        ),
      );
    }
    else{
      return InkWell(
        onTap: onTap,
        child: Container(
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.all(10),
          margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: MyColors.Dark5
                )
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration:user!.avatar!.isNotEmpty?
                BoxDecoration(
                    image: DecorationImage(image: NetworkImage(user!.avatar!),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(50)):
                BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/pic.png")),
                    borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user!.name!,
                        style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                      ),
                      Text(user!.mobile!,
                        style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                child: widget.selected?
                Center(
                  child: SvgPicture.asset('assets/checked.svg'),
                ):
                Center(
                  child: Image(image: AssetImage('assets/Rectangle_6.png')),
                ),
              ),
            ],
          ),

        ),
      );
    }

  }

}