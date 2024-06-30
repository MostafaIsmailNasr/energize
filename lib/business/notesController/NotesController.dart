import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/deleteNoteModel/DeleteNoteResponse.dart';
import '../../data/model/notesModel/NotesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class NotesController extends GetxController {
  Repo repo = Repo(WebService());
  var notesResponse = NotesResponse().obs;
  var deletResponse = DeleteNoteResponse().obs;
  var isLoading = false.obs;
  var token = "";
  var lang="";
  RxList<dynamic> NotesList=[].obs;

  getNotes(int orderId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString("tokenUser")!;
    lang= prefs.getString('lang')!;
    isLoading.value=true;
    notesResponse.value = await repo.getNotes(token,orderId);
    NotesList.value=notesResponse.value.data as List;
    isLoading.value=false;
    return notesResponse.value;
  }

  deleteNotes(BuildContext context,String token,int id,int orderId)async{
    isLoading.value=true;
    deletResponse.value=await repo.deleteNote(token,id);
    isLoading.value=false;
    Get.back();
    getNotes(orderId);
    return deletResponse.value;
  }
}