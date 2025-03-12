import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FirebaseRemoteConfigs.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/movie_provider.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';
import 'package:flutter_ui_sample/presentation/widgets/my_text.dart';
import 'package:provider/provider.dart';

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
  late MovieDetailPageProvider movieDetailPageProvider;

  @override
  void initState() {
    super.initState();
    movieDetailPageProvider = Provider.of<MovieDetailPageProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieCover(),
            /*MyText(
              widget.movie.title!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildFavorite() {
    return Consumer<MovieDetailPageProvider>(
      builder: (context, provider, child) {
        final favoriteResponseModel = provider.favoriteResponseModel;
        if (favoriteResponseModel.apiState == ApiState.Loading) {
          // return CircularProgressIndicator(color: Colors.black87);
        } else if (favoriteResponseModel.apiState == ApiState.Success) {
          return _buildFavoriteIcon(true);
        } else if (favoriteResponseModel.apiState == ApiState.Error) {
          return Center(child: Text(favoriteResponseModel.error.toString()));
        }
        return _buildFavoriteIcon(false);
      },
    );
  }

  @override
  void dispose() {
    movieDetailPageProvider.favoriteResponseModel =
        ApiResponseRootModel.initial();
    super.dispose();
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
                        movieDetailPageProvider.markFavorite(
                          FirebaseRemoteConfigs.instance.markFavorite!,
                          data: {
                            AppText.mediaType: "movie",
                            AppText.mediaId: widget.movieId,
                            AppText.favorite: true,
                          },
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
