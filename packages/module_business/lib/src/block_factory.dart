import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:module_business/src/block_factory.config.dart';
import 'package:module_data/module_data.dart';

@InjectableInit()
void initializeBlocs() {
  final getIt = GetIt.instance;
  initializeServices();
  getIt.init();
}
