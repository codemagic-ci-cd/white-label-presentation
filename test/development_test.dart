// // ignore_for_file: avoid_relative_lib_imports

// import 'dart:io';

// import 'package:flutter_test/flutter_test.dart';
// import '../lib/gettheme.dart';

// import 'package:whitelabel/main.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() {
//   //  await dotenv.load(fileName: "assets/client.env");
//   dotenv.testLoad(fileInput: File('assets/client.env').readAsStringSync());
//   var theme = getTheme();

//   final status = theme.kStatusBarHeader;

//   if (theme.kStatusBarHeader == 'Development') {
//     // ignore: avoid_print
//     print('Testing: $status');
//     testWidgets('Finds text on page', (WidgetTester tester) async {
//       // Build our app and trigger a frame.
//       await tester.pumpWidget(const Home());

//       expect(find.text('This is the Dev build'), findsOneWidget);

//       // Verify that our counter starts at 0.

//       // Tap the '+' icon and trigger a frame.
//       // await tester.tap(find.byIcon(Icons.add));
//       // await tester.pump();

//       // Verify that our counter has incremented.
//       // expect(find.text('0'), findsNothing);
//       // expect(find.text('1'), findsOneWidget);
//     });
//   }
// }
