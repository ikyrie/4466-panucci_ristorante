import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => CarrinhoStore());
}
