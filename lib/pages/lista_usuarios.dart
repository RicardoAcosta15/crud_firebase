import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/pages/crear_editar_usuarios.dart';
import 'package:crud_firebase/services/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ListaUsuariosScreen extends StatelessWidget {
  ListaUsuariosScreen({super.key});

  List listaDeUsuarios = [];

  Stream? usuariosStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaUsuariosStream(),
    );
  }

  Widget usuariosTile(
      {required String nombre,
      required String apellido,
      required String cedula,
      required String sexo,
      required String id,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.2)),
        child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            leading: CircleAvatar(
                radius: 30,
                backgroundColor: color,
                child: Text(
                    "${nombre.substring(0, 1).toUpperCase()}${apellido.substring(0, 1).toUpperCase()}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600))),
            title: Text('$nombre $apellido',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Cedula: $cedula'),
            trailing: Wrap(children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => CrearEditarUsuariosScreen(
                        tituloAppBar: 'Editar Usuario',
                        nombre: nombre,
                        apellido: apellido,
                        sexo: sexo,
                        cedula: cedula,
                        id: id,
                      ));
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  FirestoreService(null).eliminarUsuario(id, nombre);
                },
              ),
            ])),
      ),
    );
  }

  // getUsuarios() async {

  listaUsuariosStream() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("usuarios").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return hoHayUsuarios();
          return ListView(children: listaUsuarios(snapshot));
        });
  }

  listaUsuarios(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => usuariosTile(
              id: doc["Id"],
              apellido: doc["apellido"],
              sexo: doc["sexo"],
              nombre: doc["nombre"],
              cedula: doc["cedula"],
              color: Colors.green,
            ))
        .toList();
  }

  hoHayUsuarios() {
    return const Center(
        child: Text('No hay usuarios registrados en el Sistema'));
  }
}
