import 'package:flutter/material.dart';
import 'screen/screen-welcome.dart';
import 'package:provider/provider.dart';
import 'provider/favorite_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FavoriteStore())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Altera a cor GERAL do app
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 34, 246, 207),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),

      home: WelcomeScreen(), // Chama tela introdutoria
    );
  }
}
