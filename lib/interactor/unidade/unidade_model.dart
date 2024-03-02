class UnidadeModel {
  int id;
  String sigla;
  String unidade;
  bool active;
  UnidadeModel({
    required this.id,
    required this.sigla,
    required this.unidade,
    required this.active,
  });

  UnidadeModel.newUnidade()
    : id = 0,
      unidade = '',
      sigla = '',
      active = true;

  factory UnidadeModel.fromJson(Map<String, dynamic> json) {
    return UnidadeModel(
      id: json['id'],
      sigla: json['sigla'],
      unidade: json['unidade'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sigla': sigla,
      'unidade': unidade,
      'active': active,
    };
  }
}