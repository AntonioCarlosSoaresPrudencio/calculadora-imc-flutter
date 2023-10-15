import 'package:flutter/material.dart';

class ImcModel{
  String _nome = "";
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;
  int _id = 0;
  String _classificacao = "";


  ImcModel(this._id, this._nome, this._peso, this._altura, this._imc, this._classificacao){}

  String get nome => _nome;

  String get classificacao => _classificacao;

  double get peso => _peso;

  double get altura => _altura;

  double get imc => _imc;

  int get id => _id;

  set peso(double peso){
    _peso = peso;
  }

  set id(int id){
    _id = id;
  }

  set altura(double altura){
    _altura = altura;
  }

  set nome(String nome){
    _nome = nome;
  }
  set classificacao(String classificacao){
    _classificacao = classificacao;
  }

  set imc(double imc){
    _imc = imc;
  }

  @override
  String toString() {
    return {
      "Nome": _nome,
      "Peso": _peso,
      "Altura": _altura,
    }.toString();
  }
}

