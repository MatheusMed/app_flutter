import 'package:app/app/models/create_model.dart';
import 'package:app/app/sqflite/sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class CrudController extends ChangeNotifier {
  late Database? database;
  final key = GlobalKey<FormState>();

  var isEditing = ValueNotifier(false);

  var listCreate = ValueNotifier<List<CreateModel>>([]);
  var file = ValueNotifier<XFile?>(null);

  final tituloC = TextEditingController();
  final descricaoC = TextEditingController();
  int? id;

  final ImagePicker _picker = ImagePicker();

  Future<List<CreateModel?>?> getAll() async {
    database = await SqfliteHelper.instace.database;

    var result = await database!.query("crud");

    listCreate.value = result.isNotEmpty
        ? result.map((e) => CreateModel.fromMap(e)).toList()
        : [];
    print(listCreate.value.toString());
    ChangeNotifier();
  }

  Future<int?> insert(CreateModel create) async {
    database = await SqfliteHelper.instace.database;

    await database!.insert("crud", create.toMap());

    ChangeNotifier();
  }

  Future<int?> delete(int id) async {
    database = await SqfliteHelper.instace.database;
    await database!.delete(
      "crud",
      where: "id = ?",
      whereArgs: [id],
    );
    getAll();
    ChangeNotifier();
  }

  Future<int?> update(CreateModel create) async {
    database = await SqfliteHelper.instace.database;
    print(create.titulo);
    print(create.id);

    await database!.update(
      "crud",
      create.toMap(),
      where: "id = ?",
      whereArgs: [create.id],
    );

    ChangeNotifier();
  }

  void pickerImage() async {
    file.value = await _picker.pickImage(source: ImageSource.gallery);
    ChangeNotifier();
  }

  void validadeAndCreate() async {
    var formValide = key.currentState!.validate();
    if (formValide && file.value != null) {
      insert(
        CreateModel(
          titulo: tituloC.text,
          descricao: descricaoC.text,
          imagem: file.value!.path,
        ),
      );
      tituloC.clear();
      descricaoC.clear();
      file.value = null;

      await getAll();
    } else {
      Get.rawSnackbar(
        title: "Imagem nao foi inserida",
      );
    }
  }

  void validadeAndUpdate() async {
    update(
      CreateModel(
        id: id,
        titulo: tituloC.text,
        descricao: descricaoC.text,
        imagem: file.value!.path,
      ),
    );
    await getAll();
    tituloC.clear();
    descricaoC.clear();
    file.value = null;
  }
}
