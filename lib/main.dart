// import 'package:best_movei/viewModel/themeprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:best_movei/view/home_screen.dart';


// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
//       home: const HomeScreen(),
//     );
//   }
// }
import 'package:best_movei/viewModel/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:best_movei/view/home_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
