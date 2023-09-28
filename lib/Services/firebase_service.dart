import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseStorage storage = FirebaseStorage.instance;

Future<Map<String, List<Map<String, dynamic>>>> getReportes() async {
  Map<String, List<Map<String, dynamic>>> resultMap = {};

  List<Map<String, dynamic>> reportesList = [];

  CollectionReference reportesRef = FirebaseFirestore.instance.collection('reportes');

  QuerySnapshot querySnapshot = await reportesRef.get();

  querySnapshot.docs.forEach((element) {
    reportesList.add(element.data() as Map<String, dynamic>);
  });

  resultMap['Reportes'] = reportesList;

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
  await firestore.collection('reportes').add({
    "descripcion": descripcion,
    "fecha": fecha,
    "ubicacion": ubicacion,
    "estado": estado,
    "imagen": imagen,
    "categoria": categoria,
    "nombreCompleto": nombreCompleto,
  });

  return true;
} on Exception catch (e) {
  return false;
}
}

Future<String> subirImagen(File imagen) async {

  final String fileName = imagen.path.split('/').last;

  final Reference ref = storage.ref().child('reportes').child(fileName);
  final UploadTask uploadTask = ref.putFile(imagen);

  final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => true);

  if(taskSnapshot.state == TaskState.success){
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }else{
    return 'false';
  }

}

