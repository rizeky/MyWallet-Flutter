import 'package:get_it/get_it.dart';
import 'bloc/bloc.dart';
// import 'model/model.dart';
import 'service/service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => LocalService());
   
  locator.registerFactory(() => HomeBloc());
  locator.registerFactory(() => InputWalletBloc());
  
  // locator.registerSingleton<Ticket>(Ticket.initial(), instanceName: 'Ticket');
}

Future<void> awaitSetupLocator() async {
  
  await locator.allReady();

  // Setup service
  // await locator.get<CoreService>(instanceName: 'Core Service').init();

  // Setup first bloc
  // await locator.get<HomeBloc>().init();

  // print("setup locator success");
}