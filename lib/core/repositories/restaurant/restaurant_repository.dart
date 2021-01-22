import 'package:restaurant_app/core/models/models.dart';
import 'package:restaurant_app/core/network/network_service.dart';
import 'package:restaurant_app/core/providers/providers.dart';

class RestaurantRepository {
  RestaurantProvider _restaurantProvider;

  RestaurantRepository() {
    this._restaurantProvider = RestaurantProvider(NetworkService());
  }

  Future<RestaurantList> getRestaurantList() {
    return _restaurantProvider.getRestaurantList();
  }

  Future<RestaurantList> getRestaurantSearch({String query}) {
    return _restaurantProvider.getRestaurantSearch(query: query);
  }

  Future<RestaurantDetail> getRestaurantDetail({String id}) {
    return _restaurantProvider.getRestaurantDetail(id: id);
  }

  Future<CustomerReviewsResponse> postRestaurantReview(
      {String id, String name, String review}) {
    return _restaurantProvider.postRestaurantReview(
      id: id,
      name: name,
      review: review,
    );
  }
}
