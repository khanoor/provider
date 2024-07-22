import 'package:provider_mvvm/data/network/base_api_services.dart';
import 'package:provider_mvvm/data/network/network_api_services.dart';
import 'package:provider_mvvm/model/movie_model.dart';
import 'package:provider_mvvm/resources/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> getMovie() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.movieApi);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
