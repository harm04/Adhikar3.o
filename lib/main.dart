import 'package:adhikar3_o/common/widgets/bottom_nav_bar.dart';
import 'package:adhikar3_o/common/widgets/error_text.dart';
import 'package:adhikar3_o/common/widgets/loader.dart';
import 'package:adhikar3_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar3_o/features/auth/views/login_view.dart';
import 'package:adhikar3_o/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adhikar3.o',
      theme: AppTheme.theme,
     
      home: ref.watch(currentUserAccountProvider).when(data: (user) {
        if (user != null) {
          return BottomNavBar();
        }
       
        return LoginScreen();
      }, error: (err, st) {
        return ErrorText(error: err.toString());
      }, loading: () {
        return Loader();
      }),
    );
  }
}
