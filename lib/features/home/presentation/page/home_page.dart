import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firestore/features/home/presentation/bloc/home_bloc.dart';
import 'package:todo_firestore/features/home/presentation/provider/home_provider.dart';
import 'package:todo_firestore/features/home/presentation/widgets/home_list_images.dart';

// TODO: implement local cache

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Filter by author',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<HomeProvider>().query = value;
                    },
                  ),
                ),
                const Expanded(
                  child: HomeListImages(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          context.read<HomeBloc>().add(GetImageInfoEvent(page: currentPage));
          currentPage++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
