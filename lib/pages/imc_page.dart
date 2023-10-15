import 'package:calculadora_imc_flutter/repository/imc_repository.dart';
import 'package:flutter/material.dart';

import '../model/Imc_model.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPage();

}

class _ImcPage extends State<ImcPage> {
  ImcRepository imcRepository = ImcRepository();
  var _pessoas = const <ImcModel>[];

  final nomeController = TextEditingController(text: "");
  final alturaController = TextEditingController(text: "");
  final pesoController = TextEditingController(text: "");


  @override
  void initState() {
    super.initState();
    obterPessoa();

  }
  void obterPessoa() async {
    _pessoas = await imcRepository.obterDados();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      body: Center(
        // child: Text('Hello testeaaa'),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 30,
              alignment: Alignment.center,
              child: TextField(
                controller: nomeController,
                onChanged: (value) {
                  debugPrint(value);
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 17, 17, 17))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 248, 6, 6))),
                    hintText: "Nome",
                    hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 30,
              alignment: Alignment.center,
              child: TextField(
                controller: alturaController,
                onChanged: (value) {
                  debugPrint(value);
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 12, 12, 12))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 248, 6, 6))),
                    hintText: "Altura",
                    hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ), Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 30,
              alignment: Alignment.center,
              child: TextField(
                controller: pesoController,
                onChanged: (value) {
                  debugPrint(value);
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 17, 17, 17))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 248, 6, 6))),
                    hintText: "Peso",
                    hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    adicionarImc();
                  },
                  child: const Text("Adicionar"),
                ),
              ],
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Resultados'),
              ],
            ), Expanded(
                child: _pessoas.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12),
                  child: Text('Calcule seu IMC'),
                )
                    : ListView.builder(
                  itemCount: _pessoas.length,
                  itemBuilder: (BuildContext context, int index) {
                    ImcModel pessoa = _pessoas[index];
                    return ListTile(
                      dense: false,
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      title: Text(pessoa.nome, style: const TextStyle(color: Color.fromARGB(
                          255, 0, 0, 0)),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('IMC: ${pessoa.imc.toStringAsFixed(2)}, Classificação: ${pessoa.classificacao}',
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> adicionarImc() async {
      var nome = nomeController.text.toUpperCase()??"";
      var altura = double.tryParse(alturaController.text)??0;
      var peso = double.tryParse(pesoController.text)??0;
      if(peso != null && altura != null){
        var resultImc = peso/(altura*altura);
        ImcModel pessoa = new ImcModel(0, nome, peso, altura, resultImc, getClassificacao(resultImc));
        imcRepository.salvar(pessoa);
        _pessoas = await imcRepository.obterDados();
        print("AQUI: " + resultImc.toString());
      }else{
        print("Peso ou altura invalido!");
      }
      limparCamposNaTela();

      setState(() {});
    }
  
    void limparCamposNaTela() {
      nomeController.clear();
      alturaController.clear();
      pesoController.clear();
    }
  
    void carregarResultados() async {
      await _pessoas;
      setState(() {});
    }


  String getClassificacao(double valor){
    switch(valor){
      case < 16:
        return "Magreza Grave";
      case >= 16 && < 17:
        return "Magreza Moderada";
      case >= 17 && < 18.5:
        return "Magreza Leve";
      case >= 18.5 && < 25:
        return "Saudável";
      case >= 25 && < 30:
        return "Sobrepeso";
      case >= 30 && < 35:
        return "Obesidade Grau I";
      case >= 35 && < 40:
        return "Obesidade Grau II (severa)";
    }
    return "Obesidade Grau III (mórbita)";

  }

}



