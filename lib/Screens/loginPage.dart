import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:incidencias_reportes/Constants/colors.dart';
import 'package:incidencias_reportes/Screens/CategoriasPage.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool opcion = false;
  bool _loading = false;
  
  double top = 0;
  double Height = 0;
  double w = 0;
  double he = 0;

  Color fillColor = Palette.letras;
  
  late Icon ic = Icon(Icons.lock, color: fillColor);

  String? email;
  String? password;

  loginUsingEmailPassword({required String email, required String password}) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if(user != null){
        _loading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.green,
          )
        );
      }else{
        _loading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
            backgroundColor: Colors.red,
          )
        );
      }
      return user;
    }catch(e){
      _loading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No user found for that email.'),
          backgroundColor: Colors.red,
        )
      );
      return null;
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/registro');
  }

  double heightC(BuildContext context) {
    setState(() {
      var mediaQuery = MediaQuery.of(context);
      Size size = mediaQuery.size;
      double h = size.height;
      he = h;
      w = size.width;
      if (!opcion) {
        Height = h * 0.48;
        ic = Icon(Icons.lock, color: fillColor);
        top = 260;
      } else {
        Height = h * 0.20;
        top = 150;
      }
    });
    return Height;
  }

  

  // metodos onchanged
  void onChangedUser(String? value) {
    setState(() {
      email = value;
    });
  }

  void onChangedPass(String? value) {
    setState(() {
      password = value;
    });
  }

  String? validatorUser (String? value) {
    String pass = value.toString();
        if (pass.isEmpty || pass.toString().trim() == " ") {
          _loading = false;
          opcion = false;
          ic =  Icon(Icons.lock, color: Palette.letras);
          return 'Ingrese su contraseña por favor';
        }
        return null;
  }

  String? validatorPass (String? value) {
    String pass = value.toString();
        if (pass.isEmpty || pass.toString().trim() == " ") {
          _loading = false;
          opcion = false;
          ic =  Icon(Icons.lock, color: Palette.letras);
          return 'Ingrese su contraseña por favor';
        }
        return null;
  }

  void onTapL() {
    setState(() {
      opcion = true;
      ic = const Icon(Icons.lock_open);
    });
  }

  @override
  Widget build(BuildContext context) {
    heightC(context);
    //double w = size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          opcion = false;
          _loading = false;
          ic = Icon(Icons.lock, color: fillColor);
        });
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              opcion = false;
              ic = Icon(Icons.lock, color: fillColor);
            });
            return Future.value(false);
          } else {
            setState(() {
              _loading = false;
            });
            return Future.value(true);
            
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                FadeInUp(
                  duration: const Duration(microseconds: 500),
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: Height * 1.25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 25, 26, 79),
                          Color(0xFF2D3091),
                          Color.fromRGBO(97, 100, 198, 1)          
                        ],
                      ),
                    ),
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 800),
                      child: Image.asset(
                        'assets/ITZ1.png',
                        height: Height * 0.8,
                      )
                    ),
                  ),
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 800),
                  child: Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: w > 500 ? 500 : w,
                        child: Card(
                          shadowColor: Colors.black,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(
                            left: 30, 
                            right: 30, 
                            top: top, 
                            bottom: 10
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FadeInDown(
                                    duration: const Duration(milliseconds: 500),
                                    delay: const Duration(milliseconds: 900),
                                    child: Text(
                                      'BIENVENIDO',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.letras,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  FadeInDown(
                                    duration: const Duration(milliseconds: 500),
                                    delay: const Duration(milliseconds: 1000),
                                    child: _usuario()
                                  ),
                                  const SizedBox(height: 10),
                                  FadeInDown(
                                    duration: const Duration(milliseconds: 500),
                                    delay: const Duration(milliseconds: 1100),
                                    child: _password(),
                                  ),
                                  const SizedBox(height: 20),
                                  FadeInDown(
                                    duration:const Duration(milliseconds: 500),
                                    delay: const Duration(milliseconds: 1200),
                                    child: _bLogin()
                                  ),
                                  const SizedBox(height: 20),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }

  Widget _usuario() {
    return TextFormField(
      validator: (value) {
        String u = value.toString();
        if (u.isEmpty || u.toString().trim() == " ") {
          _loading = false;
          opcion = false;
          ic = Icon(Icons.lock, color: Palette.letras);
          return 'Ingrese su usuario o email por favor';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      onTap: () {
        setState(() {
          opcion = true;
          ic =  Icon(Icons.lock, color: Palette.letras);
        });
      },
      style:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Palette.letras,
      ),
      decoration: InputDecoration(
        labelText: 'Usuario o Email',
        labelStyle:  TextStyle(color: Palette.letras.withOpacity(0.7)),
        prefixIcon:  Icon(Icons.person, color: Palette.letras),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: Palette.letras, width: 2.0),
        ),
      ),
    );
  }

  /*Widget pa(){
    return MyTextFormField(obscureText: true, 
    validator: validatorPass, 
    fillColor: fillColor, 
    colorTextLabelStyle: labelStyle, prefixIcon: prefixIcon, labelText: labelText);
  }*/
  Widget _password() {
    return TextFormField(
      validator: validatorPass,
      onTap: onTapL,
      onChanged: onChangedPass,
      obscureText: _obscureText,
      style:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: fillColor,
      ),
      decoration: InputDecoration(
        prefixIcon: ic,
        labelText: 'Contraseña',
        labelStyle:  TextStyle(color: Palette.letras.withOpacity(0.7)),
        suffixIcon: IconButton(
          padding: const EdgeInsetsDirectional.only(end: 12),
          icon: _obscureText
              ?  Icon(Icons.visibility, color: Palette.letras)
              :  Icon(Icons.visibility_off,color: Palette.letras),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: fillColor, width: 2.0),
        ),
      ),
    );
  }

  Widget _bLogin() {
    return ElevatedButton(
      style: ButtonStyle(iconSize: MaterialStateProperty.all(40)),
      onPressed: () async {
        // _login(context);
        if (_formKey.currentState!.validate()) {
          setState(() {
            _loading = true;
            opcion = false;
            ic = const Icon(Icons.lock_open);
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          });

          User? user = await loginUsingEmailPassword(email: email!, password: password!);
          if(user != null){
            _loading = false;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriasPage(user: user,)));
          }
        } else{
          setState(() {
            _loading = false;
            opcion = false;
            
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Iniciar Sesión ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.login),
          if (_loading)
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(left: 10),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
        ],
      ),
    );
  }
}
