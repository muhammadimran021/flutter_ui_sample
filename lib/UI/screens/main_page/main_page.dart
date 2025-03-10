import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/UI/screens/home_page/HomePage.dart';
import 'package:flutter_ui_sample/UI/screens/main_page/MainPageProvider.dart';
import 'package:flutter_ui_sample/UI/screens/profile/user_profile_page.dart';
import 'package:flutter_ui_sample/UI/screens/user_account_page/user_account_page.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottom_navigation_item.dart';
import '../search_page/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageProvider provider;
  final List<Widget> _pagesList = [
    Homepage(),
    SearchPage(),
    UserAccountPage(),
    UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MainPageProvider>(context, listen: false);
  }

  void _updatePageIndex(int index) {
    provider.changePageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavigationItem(
              icon: Icons.home_filled,
              onTap: () => _updatePageIndex(0),
            ),
            BottomNavigationItem(
              icon: Icons.search,
              onTap: () => _updatePageIndex(1),
            ),
            BottomNavigationItem(
              icon: Icons.card_travel,
              onTap: () => _updatePageIndex(2),
            ),
            BottomNavigationItem(
              icon: Icons.person,
              onTap: () => _updatePageIndex(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<MainPageProvider>(
      builder: (
        BuildContext context,
        MainPageProvider provider,
        Widget? child,
      ) {
        return _pagesList[provider.pageIndex];
      },
    );
  }
}
