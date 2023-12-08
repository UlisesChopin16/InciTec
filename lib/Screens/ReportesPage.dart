import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incidencias_reportes/Models/reportes_model.dart';
import 'package:incidencias_reportes/Screens/InfoReportesPage.dart';
import 'package:incidencias_reportes/Services/firebase_service.dart';

class ReportesPage extends StatefulWidget {
  final String cat;
  final String path;
  const ReportesPage({Key? key, required this.cat, required this.path}) : super(key: key);
  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {

  final servicios = Get.put(FirebaseServicesInciTec());

  double w = 0;
  double h = 0;
  var getDataReportes = GetDataModelReportes(reportes: []);


  resolucion(){
    setState(() {
      w = MediaQuery.of(context).size.width;
      h = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    resolucion();
    return
      Scaffold(
        appBar: AppBar(
          title: Text(widget.cat),
        ),
        body: Center(
          child: SizedBox(
            width: w > 500 ? 500 : w,
            height: h * 0.9,
            child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
              future: servicios.getReportes(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  getDataReportes = GetDataModelReportes.fromJson(snapshot.data!);
                  return ListView.builder( 
                    shrinkWrap: true,
                    itemCount: getDataReportes.reportes.length,
                    itemBuilder: (context, index) {
                      final reportes = getDataReportes.reportes[index];
                      if(reportes.categoria != widget.cat){
                        return Container();
                      }else{
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text('Categoria: \n${widget.cat}'),
                              subtitle: Text(
                                '${reportes.ubicacion}\n${reportes.fecha.toString().split(' ')[0]}\nPrioridad: ${reportes.estado}' 
                              ),
                              leading: imagen(index,reportes),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide( width: 2.0)
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoReportesPage(
                                  cat: widget.cat,
                                  path: widget.path,
                                  descripcion: reportes.descripcion,
                                  estado: reportes.estado,
                                  fecha: reportes.fecha.toString().split(' ')[0],
                                  imagen: reportes.imagen,
                                  nombreCompleto: reportes.nombreCompleto,
                                  ubicacion: reportes.ubicacion,
                                )));
                              },
                            ),
                          ),
                        );
                      }
                    },
                  );
                }else{
                  return const Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator()
                    )
                  );
                }
              } ,
            )
          ),
        ),
      );
  }

  imagen(int index, Reporte reportes){
    if(reportes.imagen.isEmpty){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else if(reportes.imagen == 'img'){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else{
      return Image.network(
        reportes.imagen,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }
  }

}