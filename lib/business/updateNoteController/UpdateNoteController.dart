import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/updateNoteModel/UpdateNotesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/notes/notes_screen.dart';

class UpdateNotesController extends GetxController {
  Repo repo = Repo(WebService());
  var updateNotesResponse = UpdateNotesResponse().obs;
  var isLoading = false.obs;
  var token = "";
  var tittle;
  var body;
  var idOrder;
  Rx<bool> isVisable = false.obs;
  TextEditingController NotesAddressController = TextEditingController();
  TextEditingController NotesController = TextEditingController();

  getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    tittle=prefs.getString("tittle")!;
    body=prefs.getString("body")!;
    NotesAddressController.text=tittle;
    NotesController.text=body;
  }

  UpdateNotes(BuildContext context,int id)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    isLoading.value=true;
    updateNotesResponse.value = await repo.updateNotes(token,NotesAddressController.text,NotesController.text,id);
    if(updateNotesResponse.value.success==true){
      isVisable.value=false;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return NotesScreen(orderId: idOrder,);
          }));
    }
    isLoading.value=false;
    return updateNotesResponse.value;
  }
}