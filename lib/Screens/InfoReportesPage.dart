import 'package:flutter/material.dart';

class InfoReportesPage extends StatefulWidget {

  final String cat;
  final String path;
  final String descripcion;
  final String estado;
  final String fecha;
  final String imagen;
  final String nombreCompleto;
  final String ubicacion;

  const InfoReportesPage({
    Key? key, 
    required this.cat, 
    required this.path,
    required this.descripcion,
    required this.estado,
    required this.fecha,
    required this.imagen,
    required this.nombreCompleto,
    required this.ubicacion,
  })
      : super(key: key);
  @override
  State<InfoReportesPage> createState() => _InfoReportesPageState();
}

class _InfoReportesPageState extends State<InfoReportesPage> {
  double h = 0;
  double w = 0; 

  @override
  void initState() {
    super.initState();
    
  }

  resolucion() {
    setState(() {
      h = MediaQuery.of(context).size.height;
      w = MediaQuery.of(context).size.width;
    });
  }

  


  @override
  Widget build(BuildContext context) {
    resolucion();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalles del reporte'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf)
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: w > 500 ? w * 0.4 : w,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.cat,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                      height: h * 0.4,
                      width: w * 0.8,
                      child: imagen(),
                    ),
                    const SizedBox(height: 20.0,),
                    Text(
                      widget.nombreCompleto,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Text(
                      widget.ubicacion,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ), 
                    ),
                    const SizedBox(height: 20.0,),
                    Text(
                      widget.fecha,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Text(
                      widget.estado,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Text(
                      widget.descripcion,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  imagen(){
    if(widget.imagen.isEmpty){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else if(widget.imagen == 'img'){
      return Image.asset(
        widget.path,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }else{
      return Image.network(
        widget.imagen,
        width: 100,
        height: 140,
        fit: BoxFit.cover,
      );
    }
  }
}