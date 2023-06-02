import 'package:crud_firebase/pages/crear_editar_usuarios.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Color bgcolor = dotenv.env['COLOR'] as Color;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
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
          backgroundColor: bgcolor,
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
      ),
    );
  }
}
