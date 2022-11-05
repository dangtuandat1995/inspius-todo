import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';
import 'package:todo_firestore/features/home/presentation/provider/home_provider.dart';

import '../../../../core/shared_preferences/shared_preference_manager.dart';
import '../bloc/home_bloc.dart';
import 'home_image.dart';

class HomeListImages extends StatefulWidget {
  const HomeListImages({super.key});

  @override
  State<HomeListImages> createState() => _HomeListImagesState();
}

class _HomeListImagesState extends State<HomeListImages> {
  bool loading = false;

  final localStorage = SharedPreferenceManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HomeProvider>().allImageInfos =
          await localStorage.getHomeImageInfos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        loading = state is HomeLoadingState;

        if (state is HomeErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          );
        }

        if (state is GetImageInfoState) {
          context.read<HomeProvider>().allImageInfos = [
            ...context.read<HomeProvider>().allImageInfos,
            ...state.imageInfos,
          ];
          localStorage.setHomeImageInfos(
            context.read<HomeProvider>().allImageInfos,
          );
        }
      },
      child: Stack(
        children: [
          Selector<HomeProvider, List<LoremImageInfo>>(
            selector: (_, provider) => provider.filteredImageInfos,
            builder: (_, filteredImageInfos, __) {
              return Positioned.fill(
                child: ListView.separated(
                  itemCount: filteredImageInfos.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (_, index) {
                    return HomeImage(
                      imageInfo: filteredImageInfos[index],
                    );
                  },
                ),
              );
            },
          ),
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
