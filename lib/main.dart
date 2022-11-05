import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/core/dependency_injections/dependency_injections.dart';
import 'package:todo_firestore/features/home/presentation/page/home_page.dart';
import 'package:todo_firestore/features/home/presentation/provider/home_provider.dart';

import 'features/home/presentation/bloc/home_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      builder: (context, child) {
        return const MaterialApp(
          title: 'Inspius Assignment',
          home: HomePage(),
        );
      },
    );
  }
}
