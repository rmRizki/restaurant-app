import './blocs/detail_bloc_test.dart' as detail_bloc;
import './blocs/favorite_bloc_test.dart' as favorite_bloc;
import './blocs/main_bloc_test.dart' as main_bloc;
import './blocs/search_bloc_test.dart' as search_bloc;
import './models/restaurant_detail_test.dart' as restaurant_detail;
import './models/restaurant_list_test.dart' as restaurant_list;
import './providers/api/restaurant_provider_test.dart' as restaurant_provider;
import './repositories/restaurant_repository_test.dart'
    as restaurant_repository;

main() {
  detail_bloc.main();
  favorite_bloc.main();
  main_bloc.main();
  search_bloc.main();
  restaurant_detail.main();
  restaurant_list.main();
  restaurant_provider.main();
  restaurant_repository.main();
}
