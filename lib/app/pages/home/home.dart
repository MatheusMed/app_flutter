import 'dart:io';

import 'package:app/app/controllers/crud_controller.dart';
import 'package:app/app/models/create_model.dart';
import 'package:app/app/pages/create/create.dart';
import 'package:app/app/sqflite/sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.find<CrudController>();

  @override
  void initState() {
    controller.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => Create());
        },
        label: Text('Adicionar'),
      ),
      body: ValueListenableBuilder<List<CreateModel>>(
        valueListenable: controller.listCreate,
        builder: (context, value, child) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: controller.listCreate.value.length,
            itemBuilder: (ctx, idx) {
              var item = controller.listCreate.value[idx];
              return ListTile(
                title: Text(
                  item.titulo!,
                ),
                leading: Image.file(File("${item.imagem}")),
                subtitle: Text(item.descricao!),
                onTap: () {
                  Get.to(() => Create(), arguments: item);
                  controller.isEditing.value = true;
                },
                trailing: IconButton(
                  onPressed: () {
                    controller.delete(item.id!);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
