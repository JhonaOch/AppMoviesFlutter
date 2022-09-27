import 'package:flutter/material.dart';
import 'package:pelicula_application_3/src/pages/home_page.dart';
import 'package:pelicula_application_3/src/pages/pelicula_detalle.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
