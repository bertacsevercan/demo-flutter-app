// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/components/files_table.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Upload area is working', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that text is correct.
    expect(find.text("Upload a file"), findsOneWidget);

    expect(find.byIcon(Icons.upload), findsOneWidget);

    // Tap the 'upload' icon button and trigger a frame.
    await tester.tap(find.byIcon(Icons.upload));
    await tester.pump();

    // Verify that file picker is opened.
    expect(find.text("Upload a file"), findsNothing);
    expect(find.byType(FilePickerResult), findsOneWidget);
  });

  testWidgets('Uploaded files table is working', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that text is correct.
    expect(find.text("Uploaded Files"), findsOneWidget);

    // Verify that files table exists.
    expect(find.byType(FilesTable), findsOneWidget);
  });
}
