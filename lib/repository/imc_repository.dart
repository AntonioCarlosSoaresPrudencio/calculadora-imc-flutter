import 'dart:core';
import 'package:calculadora_imc_flutter/repositories/database/sqlite_database.dart';
import '../model/Imc_model.dart';

class ImcRepository {

  Future<List<ImcModel>> obterDados() async{
    List<ImcModel> pessoas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('select id, nome, peso, altura, imc, classificacao from tb_imc');
    for (var element in result){
      pessoas.add(
          ImcModel(
          int.parse(element["id"].toString()),
          element["nome"].toString(),
          double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString()),
          double.parse(element["imc"].toString()),
          element["classificacao"].toString()
        ));
    };
    return pessoas;
  }

  Future<void> salvar(ImcModel imc) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('INSERT INTO tb_imc (nome, peso, altura, imc, classificacao) values(?,?,?,?,?)',
        [imc.nome, imc.peso, imc.altura, imc.imc, imc.classificacao]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM tb_imc WHERE id = ?', [id]);
  }
}