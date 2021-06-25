import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'providers/plafond.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<Plafond>(
      create: (context) => Plafond(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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





