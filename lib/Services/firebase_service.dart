import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incidencias_reportes/Screens/CategoriasPage.dart';
import 'package:incidencias_reportes/Screens/SubirReportePage.dart';

class FirebaseServicesInciTec extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  var loading = false.obs;

  var usuario = ''.obs;
  var email = ''.obs;

  User? user;

  snackBarSucces({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      )
    );
  }

  snackBarError({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      )
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> getReportes() async {
    loading.value = true;
    
    Map<String, List<Map<String, dynamic>>> resultMap = {};

    List<Map<String, dynamic>> reportesList = [];

    CollectionReference reportesRef = FirebaseFirestore.instance.collection('reportes');

    QuerySnapshot querySnapshot = await reportesRef.get();

    querySnapshot.docs.forEach((element) {
      reportesList.add(element.data() as Map<String, dynamic>);
    });

    resultMap['Reportes'] = reportesList;

    loading.value = false;
    return resultMap;
  }

  Future<bool> agregarReporte({
    required String descripcion,
    required DateTime fecha,
    required String ubicacion,
    required String estado,
    required String imagen,
    required String categoria,
    required String nombreCompleto,
  }) async{
    try {
      loading.value = true;
      await firestore.collection('reportes').add({
        "descripcion": descripcion,
        "fecha": fecha,
        "ubicacion": ubicacion,
        "estado": estado,
        "imagen": imagen,
        "categoria": categoria,
        "nombreCompleto": nombreCompleto,
      });
      loading.value = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> subirImagen(File imagen) async {

    loading.value = true;

    final String fileName = imagen.path.split('/').last;

    final Reference ref = storage.ref().child('reportes').child(fileName);
    final UploadTask uploadTask = ref.putFile(imagen);

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => true);

    if(taskSnapshot.state == TaskState.success){
      final String url = await taskSnapshot.ref.getDownloadURL();
      loading.value = false;
      return url;
    }else{
      loading.value = false;
      return 'false';
    }

  }

  Future<void> loginUsingEmailPassword({required String numeroControl, required String password, required BuildContext context}) async{
    loading.value = true;
    try{
      email.value = '$numeroControl@tecnamex.com';
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email.value, password: password);
      user = userCredential.user;
      if(user != null){
        usuario.value = numeroControl;
        loading.value = false;
        if(!context.mounted) return;
        snackBarSucces(message: 'Bienvenido', context: context);
        if(numeroControl == 'admin'){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CategoriasPage()));
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SubirReporte()));
        }

      }else{
        loading.value = false;
        if(!context.mounted) return;
        snackBarError(message: 'Error al iniciar sesión', context: context);
      }
    }catch(e){
      loading.value = false;
      print(e);
      snackBarError(message: 'Algo salio mal, por favor intente de nuevo más tarde', context: context);
    }
  }


}


