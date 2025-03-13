import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';

import '../../widgets/bottom_navigation_item.dart';
import '../home_page/HomePage.dart';
import '../movies_page/movies_page.dart';
import '../profile/user_profile_page.dart';
import '../user_account_page/user_account_page.dart';
import 'MainPageProvider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageCubit mainPageCubit;
  final List<Widget> _pagesList = [
    Homepage(),
    MoviesPage(),
    UserAccountPage(),
    UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    mainPageCubit = MainPageCubit();
  }

  void _updatePageIndex(int index) {
    mainPageCubit.changePageIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageCubit>(
      create: (context) => mainPageCubit,
      child: SafeArea(
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
                icon: Icons.movie_filter_sharp,
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
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MainPageCubit, GenericState>(
      builder: (context, state) {
        if (state is SuccessState<int>) {
          return _pagesList[mainPageCubit.pageIndex];
        }
        return _pagesList[0];
      },
    );
  }
}
