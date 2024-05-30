
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/detail_model/detail_model.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:get/get.dart';

import '../core/classes/enum.dart';

class HistoryScreenViewModel extends GetxController {
  BirdRepository repository = locator<BirdRepository>();
  Status status = Status.loading;
  List<DetailModel>? data;

  @override
  void onInit() {
    super.onInit();
    configureList();
  }

  void deleteHistory() {
    repository.deleteAll();
  }

  void configureList() async {
    status = Status.loading;
    print('status = $status');
    update();
    data = await repository.getHistory();
    print('data $data');
    if(data?.length!=0 && data != null) {
      status = Status.success;
    } else {
      status = Status.empty;
    }
    print('status = $status');
    update();
  }

}