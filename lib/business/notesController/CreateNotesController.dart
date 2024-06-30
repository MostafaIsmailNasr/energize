
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/createNotesModel/CreateNotesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/notes/notes_screen.dart';

class CreateNotesController extends GetxController {
  Repo repo = Repo(WebService());
  var createNotesResponse = CreateNotesResponse().obs;
  var isLoading = false.obs;
  var token = "";
  var lang="";
  var idOrder;
  Rx<bool> isVisable = false.obs;
  TextEditingController NotesAddressController=TextEditingController();
  TextEditingController NotesController=TextEditingController();

  getLang()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang= prefs.getString('lang')!;
  }

  CreateNotes(BuildContext context,int orderId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    createNotesResponse.value = await repo.createNotes(token,NotesAddressController.text,NotesController.text,orderId);
    if(createNotesResponse.value.success==true){
      isVisable.value=false;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return NotesScreen(orderId: idOrder);
          }));
      NotesAddressController.clear();
    NotesController.clear();
    }
    isLoading.value=false;
    return createNotesResponse.value;
  }
}