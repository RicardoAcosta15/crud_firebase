import 'package:crud_firebase/pages/crear_editar_usuarios.dart';
import 'package:crud_firebase/pages/lista_usuarios.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crud Usuarios',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Crud Usuarios'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() =>
                      CrearEditarUsuariosScreen(tituloAppBar: 'Crear Usuario'));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListaUsuariosScreen(),
      ),
    );
  }
}
