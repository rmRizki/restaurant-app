import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/network/network_service.dart';

class RestaurantProvider {
  NetworkService _networkService;

  RestaurantProvider(this._networkService);

  Future<RestaurantList> getRestaurantList() async {
    try {
      final response = await _networkService.get(url: 'list');
      return RestaurantList.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<RestaurantList> getRestaurantSearch({String query = ''}) async {
    try {
      final response = await _networkService.get(url: 'search?q=$query');
      return RestaurantList.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<RestaurantDetail> getRestaurantDetail({String id}) async {
    try {
      final response = await _networkService.get(url: 'detail/$id');
      return RestaurantDetail.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  /// post restaurant review (/review) (body: id, name, review)
  Future<CustomerReviewsResponse> postRestaurantReview(
      {String id, String name, String review}) async {
    try {
      final response = await _networkService.post(url: 'review', data: {
        'id': id,
        'name': name,
        'review': review,
      });
      return CustomerReviewsResponse.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
