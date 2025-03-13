import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/constants/AppText.dart';
import 'package:flutter_ui_sample/domain/models/GenresModel.dart';
import 'package:flutter_ui_sample/domain/repository_impl/MoviesRepository_Impl.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';
import 'package:flutter_ui_sample/presentation/screens/movies_page/movies_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_fonts.dart';
import '../../../domain/models/FirebaseRemoteConfigs.dart';
import '../../../domain/models/TopRatedMoviesRootModel.dart';
import '../../blocs/api_event.dart';
import '../../blocs/bloc_helper.dart';
import '../../routes/app_routes.dart';
import '../../shimmers/DynamicShimmer.dart';
import '../../widgets/movies_card_large.dart';
import '../../widgets/my_text.dart';
import '../../widgets/rounded_corner_item.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    moviesBloc = MoviesBloc(MoviesRepositoryImpl());
    moviesBloc.add(
      FetchDataEvent<TopRatedMoviesRootModel>(
        endpoint: FirebaseRemoteConfigs.instance.topRatedMoviesPath!,
        params: {
          FirebaseRemoteConfigs.instance.language!: "en",
          FirebaseRemoteConfigs.instance.page!: "1",
        },
      ),
    );
    moviesBloc.add(
      FetchDataEvent<GenresModel>(
        endpoint: FirebaseRemoteConfigs.instance.genreMovieListPath!,
        params: {FirebaseRemoteConfigs.instance.language!: "en"},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => moviesBloc,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: MyText(
                  AppText.topTrendingMovies,
                  style: TextStyle(
                    fontSize: FontSizes.maxHeadingLargeFont,
                    fontWeight: FontWeights.boldFontWeight,
                  ),
                ),
              ),
              SizedBox(height: 40, child: _genresList()),
              SizedBox(height: 20),
              _moviesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genresList() {
    return BlocBuilder<MoviesBloc, GenericState>(
      buildWhen: (previous, current) {
        return shouldBuildWhen<GenresModel>(current);
      },
      builder: (context, state) {
        if (state is LoadingState<GenresModel>) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: const DynamicShimmer(
              width: 80,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          );
        } else if (state is SuccessState<GenresModel>) {
          final genresModel = state.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return RoundedCornerItem(
                filterListItem: genresModel.genres![index].name!,
                index: index,
                onTap: () {},
                isLoading: true,
              );
            },
            itemCount: genresModel.genres!.length,
          );
        } else if (state is ErrorState) {
          final errorMessage = state.message;
          print('IMRAN:: $errorMessage');
        }
        return Container();
      },
    );
  }

  Widget _moviesList() {
    return BlocBuilder<MoviesBloc, GenericState>(
      buildWhen: (previous, current) {
        return shouldBuildWhen<TopRatedMoviesRootModel>(current);
      },
      builder: (context, state) {
        if (state is LoadingState<TopRatedMoviesRootModel>) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 20.0, bottom: 30),
            child: DynamicShimmer(
              width: 250,
              height: 350,
              spacing: 20,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          );
        } else if (state is SuccessState<TopRatedMoviesRootModel>) {
          final data = state.data;
          return SizedBox(
            height: 500,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return MoviesCardLarge(
                  movie: data.results![index],
                  onTap: (id) {
                    context.push(
                      '${AppRoutes.movieDetailPage}$id',
                      extra: data.results![index].toJson(),
                    );
                  },
                );
              },
              itemCount: data.results!.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        } else if (state is ErrorState<TopRatedMoviesRootModel>) {
          final errorMessage = state.message;
          print('IMRAN:: $errorMessage');
        }
        return Container();
      },
    );
  }
}
