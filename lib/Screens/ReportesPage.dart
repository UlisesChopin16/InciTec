import 'package:flutter/material.dart';
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
        body: Container(
          child: Center(
            child: SizedBox(
              width: w > 500 ? 500 : w,
              height: h * 0.9,
              child: FutureBuilder(
                future: getReportes(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    getDataReportes = GetDataModelReportes.fromJson(snapshot.data!);
                    return ListView.builder( 
                      shrinkWrap: true,
                      itemCount: getDataReportes.reportes.length,
                      itemBuilder: (context, index) {
                        if(getDataReportes.reportes[index].categoria != widget.cat){
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
                                    offset: Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text('Categoria: \n${widget.cat}'),
                                subtitle: Text(
                                  '${getDataReportes.reportes[index].ubicacion}\n'
                                  +'${getDataReportes.reportes[index].fecha.toString().split(' ')[0]}\n'
                                  +'Prioridad: ${getDataReportes.reportes[index].estado}' 
                                ),
                                leading: imagen(index),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide( width: 2.0)
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoReportesPage(
                                    cat: widget.cat,
                                    path: widget.path,
                                    descripcion: getDataReportes.reportes[index].descripcion,
                                    estado: getDataReportes.reportes[index].estado,
                                    fecha: getDataReportes.reportes[index].fecha.toString().split(' ')[0],
                                    imagen: getDataReportes.reportes[index].imagen,
                                    nombreCompleto: getDataReportes.reportes[index].nombreCompleto,
                                    ubicacion: getDataReportes.reportes[index].ubicacion,
                                  )));
                                },
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                } ,
              )
            ),
          ),
        ),
      );
  }

  imagen(int index){
    if(getDataReportes.reportes[index].imagen.isEmpty){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else if(getDataReportes.reportes[index].imagen == 'img'){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else{
      return Image.network(
        getDataReportes.reportes[index].imagen,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }
  }

  // ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: getDataReportes.reportes.length,
  //                     itemBuilder: (context, index) {
  //                       return  Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black.withOpacity(0.5),
  //                                 spreadRadius: 2,
  //                                 blurRadius: 2,
  //                                 offset: Offset(2, 3),
  //                               ),
  //                             ],
  //                           ),
  //                           child: ListTile(
  //                             title: Text('Categoria: \n${widget.cat}'),
  //                             subtitle: Text(
  //                               '${getDataReportes.reportes[index].ubicacion}\n'
  //                               +'${getDataReportes.reportes[index].fecha}\n'
  //                               +'Prioridad: ${getDataReportes.reportes[index].estado}' 
  //                             ),
  //                             leading: Image.asset(
  //                               widget.path,
  //                               width: 100,
  //                               height: 140,
  //                               fit: BoxFit.cover,
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                               side: BorderSide( width: 2.0)
  //                             ),
  //                             onTap: () {
  //                               Navigator.push(context, MaterialPageRoute(builder: (context) => InfoReportesPage(
  //                                 cat: widget.cat,
  //                                 path: widget.path,
  //                                 descripcion: getDataReportes.reportes[index].descripcion,
  //                                 estado: getDataReportes.reportes[index].estado,
  //                                 fecha: getDataReportes.reportes[index].fecha.toString(),
  //                                 imagen: getDataReportes.reportes[index].imagen,
  //                                 nombreCompleto: getDataReportes.reportes[index].nombreCompleto,
  //                                 ubicacion: getDataReportes.reportes[index].ubicacion,
  //                               )));
  //                             },
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   );

  // Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.black.withOpacity(0.5),
  //                             spreadRadius: 2,
  //                             blurRadius: 2,
  //                             offset: Offset(2, 3),
  //                           ),
  //                         ],
  //                       ),
  //                       child: ListTile(
  //                         title: Text('Categoria: \n${widget.cat}'),
  //                         subtitle: Text(
  //                           'Tecnologico de Zacatepec\n'
  //                           +'${DateTime.now().toString().substring(0, 19)}\n'
  //                           +'Prioridad: Alta' 
  //                         ),
  //                         leading: Image.asset(widget.path,
  //                           width: 100,
  //                           height: 140,
  //                           fit: BoxFit.cover,
  //                         ),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           side: BorderSide( width: 2.0)
  //                         ),
  //                         onTap: () {
  //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  InfoReportesPage(cat: widget.cat,path: widget.path,)));
  //                         },
  //                       ),
  //                     ),
  //                   ),

  // FutureBuilder(
  //               future: getReportes(),
  //               builder: (context, snapshot) {
  //                 if(snapshot.hasData){
  //                   List reportes = snapshot.data as List;
  //                   return ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: reportes.length,
  //                     itemBuilder: (context, index) {
  //                       return Card(
  //                         child: ListTile(
  //                           onTap: (){
  //                             Navigator.push(context, MaterialPageRoute(builder: (context) => InfoReportesPage(
  //                               cat: reportes[index]['categoria'],
  //                               path: reportes[index]['imagen'],
  //                               descripcion: reportes[index]['descripcion'],
  //                               estado: reportes[index]['estado'],
  //                               fecha: reportes[index]['fecha'],
  //                               imagen: reportes[index]['imagen'],
  //                               nombreCompleto: reportes[index]['nombreCompleto'],
  //                               ubicacion: reportes[index]['ubicacion'],
  //                             )));
  //                           },
  //                           title: Text(snapshot.data[index]['titulo']),
  //                           subtitle: Text(snapshot.data[index]['descripcion']),
  //                           trailing: Text(snapshot.data[index]['estado']),
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 }else{
  //                   return CircularProgressIndicator();
  //                 }
  //               },
  //             ),
}