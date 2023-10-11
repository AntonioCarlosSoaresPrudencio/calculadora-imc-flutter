import 'package:flutter/material.dart';
import '../model/pessoa.dart';

class ImcPage extends StatefulWidget {
  @override
  _ImcPage createState() => _ImcPage();
}

class _ImcPage extends State<ImcPage> {
  final nomeController = TextEditingController(text: "");
  final alturaController = TextEditingController(text: "");
  final pesoController = TextEditingController(text: "");
  late List<Pessoa> resultado = [];
  @override
  void initState() {
    super.initState();
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
                child: resultado.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12),
                  child: Text('Nenhum resultado para exibir, informe os dados e toque em Adicionar.'),
                )
                    : ListView.builder(
                  itemCount: resultado.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pessoa pessoa = resultado[index];
                    return ListTile(
                      dense: false,
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      title: Text(pessoa.nome, style: const TextStyle(color: Color.fromARGB(
                          255, 0, 0, 0)),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('IMC: ${pessoa.imc.toStringAsFixed(2)}, Altura: ${pessoa.altura.toStringAsFixed(2)}, Peso: ${pessoa.peso.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 12)),
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

  void adicionarImc() {
      var nome = nomeController.text.toUpperCase()??"";
      var altura = double.tryParse(alturaController.text)??0;
      var peso = double.tryParse(pesoController.text)??0;
      if(peso != null && altura != null){
        var resultImc = peso/(altura*altura);
        Pessoa pessoa = new Pessoa(nome, peso, altura, resultImc);
        resultado.add(pessoa);
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
      await resultado;
      setState(() {});
    }

  }

