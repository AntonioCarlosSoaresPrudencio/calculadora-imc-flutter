import 'dart:core';
import 'package:calculadora_imc_flutter/repositories/database/sqlite_database.dart';
import '../model/pessoa_model.dart';

class PessoaRepository {

  Future<List<PessoaModel>> obterDados() async{
    List<PessoaModel> pessoas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('select id, nome, peso, altura, imc, classificacao from pessoa');
    for (var element in result){
      pessoas.add(
        PessoaModel(
          int.parse(element["id"].toString()),
          element["nome"].toString(),
          double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString()),
          double.parse(element["imc"].toString()),
          element["imc"].toString()
        ));
    };
    return pessoas;
  }

  Future<void> salvar(PessoaModel pessoa) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('INSERT INTO pessoa (nome, peso, altura, imc, classificacao) values(?,?,?,?)',
        [pessoa.nome, pessoa.peso, pessoa.altura, pessoa.imc]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM pessoa WHERE id = ?', [id]);
  }
}