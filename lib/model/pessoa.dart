class Pessoa{
  String _nome = "";
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;


  Pessoa(this._nome, this._peso, this._altura, this._imc){}

  String get nome => _nome;

  double get peso => _peso;

  double get altura => _altura;

  double get imc => _imc;

  set peso(double peso){
    _peso = peso;
  }

  set altura(double altura){
    _altura = altura;
  }

  set nome(String nome){
    _nome = nome;
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

