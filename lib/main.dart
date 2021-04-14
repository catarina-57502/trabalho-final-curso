import 'package:flutter/material.dart';
import 'package:projeto_tfc/colors.dart';
import 'package:projeto_tfc/plafond.dart';
import 'package:provider/provider.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<Plafond>(
      builder: (context) => Plafond(),
        child: MaterialApp(
      title: 'Sistema de Gestão de Eventos',
      theme: ThemeData(
          primarySwatch: Color().primaryColor,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          )
      ),
      home: LoginScreen(),
    ),
    );
  }
}





