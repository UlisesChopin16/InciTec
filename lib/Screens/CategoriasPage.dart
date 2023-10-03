import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incidencias_reportes/Screens/GraficosPage.dart';
import 'package:incidencias_reportes/Screens/ReportesPage.dart';
import 'package:incidencias_reportes/Screens/SubirReportePage.dart';
import 'package:incidencias_reportes/Screens/loginPage.dart';

class CategoriasPage extends StatefulWidget {
  final User user;
  const CategoriasPage({Key? key,required this.user}) : super(key: key);
  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {

  double w = 0;

  resolucion() {
    setState(() {
      w = MediaQuery.of(context).size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    resolucion();
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue[800]
                ),
                accountName: const Text('Margarita Sotelo',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                ),
                accountEmail: Text(widget.user.email!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                ),
                currentAccountPictureSize: Size(150, 150),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text('MS',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ),
              ),
            ),
            ListTile(
              title: Text('Subir reporte'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubirReporte(user: widget.user,)));
              },
            ),
            ListTile(
              title: Text('Estadisticas'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GraficosPage())
                );
              },
            ),
            ListTile(
              title: Text('Productos'),
              onTap: () {
                Navigator.pushNamed(context, '/productos');
              },
            ),
            ListTile(
              title: Text('Usuarios'),
              onTap: () {
                Navigator.pushNamed(context, '/usuarios');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: w > 500 ? 500 : w,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)
                      )
                    ),
                
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Image.asset('assets/fuga.jpg',
                                width: 100,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                              
                              contentPadding: EdgeInsets.all(0.0),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportesPage(cat: 'Agua',path: 'assets/fuga.jpg',)));
                              },
                            ),
                            const Text('Agua',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            ListTile(
                              title: Image.asset('assets/energia.jpg',
                                width: 100,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportesPage(cat: 'Energía Eléctrica',path: 'assets/energia.jpg',)));
                              },
                            ),
                            const Text('Energía Eléctrica',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            ListTile(
                              title: Image.asset('assets/desechosPeligrosos.jpg',
                                width: 100,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportesPage(
                                  cat: 'Desechos Peligrosos',path: 'assets/desechosPeligrosos.jpg',
                                  )
                                ));
                              },
                            ),
                            const Text('Desechos Peligrosos',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            ListTile(
                              title: Image.asset('assets/desechos.jpg',
                                width: 100,
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportesPage(cat: 'Otros',path: 'assets/desechos.jpg',)));
                              },
                            ),
                            const Text('Otros',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}