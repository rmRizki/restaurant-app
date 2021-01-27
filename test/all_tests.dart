import './blocs/restaurant_bloc_test.dart' as restaurant_bloc;
import './models/restaurant_detail_test.dart' as restaurant_detail;
import './models/restaurant_list_test.dart' as restaurant_list;
import './repositories/restaurant_repository_test.dart'
    as restaurant_repository;

main() {
  restaurant_bloc.main();
  restaurant_detail.main();
  restaurant_list.main();
  restaurant_repository.main();
}
