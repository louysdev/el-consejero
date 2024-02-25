import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no/config/theme/app_theme.dart';
import 'package:yes_no/presentation/providers/chat_provider.dart';
import 'package:yes_no/presentation/screens/chat/chat_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Manejador de providers de la aplicacion
    return MultiProvider(
      // Listado de los distintos providers que tendra acceso la app
      // El _ es para indicar que no hara falta usar el context
      providers: [ChangeNotifierProvider(create: (_) => ChatProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          // Tema personalizado para la aplicacion
          theme: AppTheme(selectedColor: 2).theme(),
          home: ChatScreen()),
    );
  }
}
