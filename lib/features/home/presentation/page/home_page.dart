import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firestore/core/shared_preferences/shared_preference_manager.dart';
import 'package:todo_firestore/features/home/presentation/bloc/home_bloc.dart';
import 'package:todo_firestore/features/home/presentation/provider/home_provider.dart';
import 'package:todo_firestore/features/home/presentation/widgets/home_list_images.dart';
import 'package:todo_firestore/features/todo/presentation/page/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  final localStorage = SharedPreferenceManager();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getInitCurrentPage();
  }

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
          dismissKeyboard(context);
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'navigate to do page',
            onPressed: () {
              dismissKeyboard(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TodoPage(),
              ));
            },
            child: const Icon(Icons.toc_outlined),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              dismissKeyboard(context);

              context
                  .read<HomeBloc>()
                  .add(GetImageInfoEvent(page: currentPage));
              currentPage++;
              localStorage.setHomeRequestPage(currentPage);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future<void> getInitCurrentPage() async {
    currentPage = await localStorage.getHomeRequestPage();
  }

  void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
