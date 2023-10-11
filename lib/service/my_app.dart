import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calculadora_imc_flutter/pages/imc_page.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
      home: ImcPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}