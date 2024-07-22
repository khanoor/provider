import 'package:flutter/foundation.dart';
import 'package:provider_mvvm/data/response/api_response.dart';
import 'package:provider_mvvm/model/movie_model.dart';
import 'package:provider_mvvm/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  ApiResponse<MovieListModel> movieList = ApiResponse.loading();

  setMovieList(ApiResponse<MovieListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMovie() async {
    setMovieList(ApiResponse.loading());
    _myrepo.getMovie().then((value) {
      setMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));
    });
  }
}
