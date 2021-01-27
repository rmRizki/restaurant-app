import './blocs/restaurant_bloc_test.dart' as restaurant_bloc;
import './models/restaurant_detail_test.dart' as restaurant_detail;
import './models/restaurant_list_test.dart' as restaurant_list;
import './providers/api/restaurant_provider_test.dart' as restaurant_provider;
import './repositories/restaurant_repository_test.dart'
    as restaurant_repository;

main() {
  restaurant_bloc.main();
  restaurant_detail.main();
  restaurant_list.main();
  restaurant_provider.main();
  restaurant_repository.main();
}
