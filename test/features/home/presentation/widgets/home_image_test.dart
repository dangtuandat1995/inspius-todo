import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';
import 'package:todo_firestore/features/home/presentation/widgets/home_image.dart';

void main() {
  testWidgets('home image should have a Text widget', (tester) async {
    const wrappedWidget = MaterialApp(
      home: Scaffold(
        body: HomeImage(
          imageInfo: LoremImageInfo(
            id: 'id',
            author: 'author',
            width: 0,
            height: 0,
            url: 'url',
            downloadUrl: 'downloadUrl',
          ),
        ),
      ),
    );

    await tester.pumpWidget(wrappedWidget);

    expect(find.byType(Text), findsOneWidget);
  });
}
