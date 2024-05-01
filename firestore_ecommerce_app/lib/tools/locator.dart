import 'package:get_it/get_it.dart';

import '../repository/database_repository.dart';
import '../service/firestore/firestore_service.dart';

final GetIt locator = GetIt.instance;

setupLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => FirestoreService());

}