import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

import 'package:mywallet/locator.dart';
import 'package:mywallet/service/service.dart';
import 'package:mywallet/model/model.dart';

part 'bloc_home.dart';
part 'bloc_detailwallet.dart';
part 'bloc_inputwallet.dart';

abstract class Bloc {
  void init();
  void dispose();
}