import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:go_router/go_router.dart';

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
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back),
          ),
          title: MyText("Theme Detail Page", style: TextStyle(fontSize: FontSizes.headingLargeFont)),
        ),
        body: Center(child: MyText("Theme Detail Page \n API URL: $env")),
      ),
    );
  }
}
