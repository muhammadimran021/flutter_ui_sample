import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/domain/repository_impl/SplashRepositoryImpl.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import 'SplashProvider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit splashCubit;

  @override
  void initState() {
    super.initState();
    splashCubit = SplashCubit(SplashRepositoryImpl());
    _navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.movie_filter_sharp, size: 100),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.black87),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigate(BuildContext context) async {
    await splashCubit.fetchAndActivate();
    if (!context.mounted) return;
    context.go(AppRoutes.mainPage);
  }
}
