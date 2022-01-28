import 'dart:convert';

class CreateModel {
  final int? id;
  final String? titulo;
  final String? descricao;
  final String? imagem;

  CreateModel({
    this.id,
    this.titulo,
    this.descricao,
    this.imagem,
  });

  CreateModel copyWith({
    int? id,
    String? titulo,
    String? descricao,
    String? imagem,
  }) {
    return CreateModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  factory CreateModel.fromMap(Map<String, dynamic> map) {
    return CreateModel(
      id: map['id']?.toInt(),
      titulo: map['titulo'],
      descricao: map['descricao'],
      imagem: map['imagem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateModel.fromJson(String source) =>
      CreateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateModel &&
        other.id == id &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.imagem == imagem;
  }

  @override
  int get hashCode {
    return id.hashCode ^ titulo.hashCode ^ descricao.hashCode ^ imagem.hashCode;
  }
}
