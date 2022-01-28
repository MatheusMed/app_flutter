import 'dart:io';

import 'package:app/app/controllers/crud_controller.dart';
import 'package:app/app/models/create_model.dart';
import 'package:app/app/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final controller = Get.find<CrudController>();

  var item = Get.arguments;

  @override
  void initState() {
    if (controller.isEditing.value == true && item != null) {
      controller.tituloC.text = item!.titulo!;
      controller.descricaoC.text = item!.descricao;
      controller.file.value != null
          ? item!.imagem.toString()
          : controller.file.value = null;
      controller.id = item!.id;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isEditing.value == true ? "Editar" : 'Criar'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            controller.tituloC.clear();
            controller.descricaoC.clear();
            controller.file.value = null;
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: controller.key,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    height: 150,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          controller.pickerImage();
                        },
                        icon: Icon(Icons.camera),
                        label: Text("Selecione Imagem")),
                  ),
                ),
                TextFormWidget(
                  hintText: "Titulo",
                  controller: controller.tituloC,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Preencha o compo";
                    }
                  },
                ),
                TextFormWidget(
                  hintText: "Descrição",
                  controller: controller.descricaoC,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Preencha o compo";
                    }
                  },
                ),
                ValueListenableBuilder<XFile?>(
                    valueListenable: controller.file,
                    builder: (context, value, child) {
                      return controller.file.value != null
                          ? Image.file(
                              File(value!.path),
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Container();
                    }),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          if (controller.key.currentState!.validate()) {
                            controller.isEditing.value == true
                                ? controller.validadeAndUpdate()
                                : controller.validadeAndCreate();
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        label: Text('Salvar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      controller.isEditing.value == true
                          ? TextButton.icon(
                              onPressed: () {
                                controller.delete(item.id);
                                controller.file.value = null;
                                controller.tituloC.clear();
                                controller.descricaoC.clear();
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green),
                              label: Text('Deletar registro',
                                  style: TextStyle(color: Colors.white)),
                            )
                          : Container(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.tituloC.clear();
                          controller.descricaoC.clear();
                          controller.file.value = null;
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        label: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
