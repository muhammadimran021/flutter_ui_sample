import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/FirebaseRemoteConfigs.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';
import 'package:flutter_ui_sample/domain/repository_impl/MoviesRepository_Impl.dart';
import 'package:flutter_ui_sample/domain/use_cases/favorite_use_case.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/favorite_events.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/favorite_states.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/movie_detail_cubit.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';
import 'package:flutter_ui_sample/presentation/widgets/my_text.dart';

import '../../../constants/AppText.dart';
import '../../../constants/app_colors.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  final Result movie;

  const MovieDetailPage({
    super.key,
    required this.movieId,
    required this.movie,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailPageCubit movieDetailPageCubit;

  @override
  void initState() {
    super.initState();
    final MoviesRepository moviesRepository = MoviesRepositoryImpl();
    movieDetailPageCubit = MovieDetailPageCubit(
      FavoriteUseCase(moviesRepository),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailPageCubit>(
      create: (context) => movieDetailPageCubit,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildMovieCover()],
          ),
        ),
      ),
    );
  }

  Widget _buildFavorite() {
    return BlocBuilder<MovieDetailPageCubit, FavoriteState>(
      builder: (BuildContext context, state) {
        if (state is FavoriteLoadingState) {
          // return CircularProgressIndicator(color: Colors.black87);
        } else if (state is FavoriteSuccessState) {
          return _buildFavoriteIcon(true);
        } else if (state is FavoriteErrorState) {
          return Center(child: Text(state.message));
        }
        return _buildFavoriteIcon(false);
      },
    );
  }

  Widget _buildMovieCover() {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
              child: CachedImage(
                fit: BoxFit.fill,
                imageUrl:
                    '${FirebaseRemoteConfigs.instance.moviesImageBaseUrl}${widget.movie.posterPath!}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0, left: 60),
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.5),
                      // Shadow color
                      blurRadius: 10,
                      // Softness of the shadow
                      spreadRadius: 5,
                      // How much the shadow spreads
                      offset: Offset(0, 10), // Moves shadow downwards (x, y)
                    ),
                  ],
                ),
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        MyText(
                          "8.5/10",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border),
                        MyText(
                          "Rate This",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        movieDetailPageCubit.markFavorite(
                          FavoriteEvent(
                            endpoint:
                                FirebaseRemoteConfigs.instance.markFavorite!,
                            data: {
                              AppText.mediaType: "movie",
                              AppText.mediaId: widget.movieId,
                              AppText.favorite: true,
                            },
                          ),
                        );
                      },
                      child: _buildFavorite(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteIcon(bool isFavorite) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isFavorite
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border),
        MyText(
          "Favorite",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
