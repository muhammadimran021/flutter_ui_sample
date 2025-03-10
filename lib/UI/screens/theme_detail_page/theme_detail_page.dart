import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import '../../widgets/my_text.dart';

class ThemeDetailPage extends StatelessWidget {
  const ThemeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String env = dotenv.env['API_URL']!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => _goBack(context),
            child: Icon(Icons.arrow_back),
          ),
          title: MyText(
            "Theme Detail Page",
            style: TextStyle(fontSize: FontSizes.headingLargeFont),
          ),
        ),
        body: Center(child: MyText("Theme Detail Page \n API URL: $env")),
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.mainPage); // Fallback to the main page
    }
  }
}
