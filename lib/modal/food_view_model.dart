
import 'package:flutter/cupertino.dart';
import 'package:intermediate_lesson_12/const.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'food_model.dart';

class FoodViewModel extends ChangeNotifier {
  RefreshController controller = RefreshController();
  int max_count = 15;
  late BuildContext context;
  //foodList
  List<FoodModal> FOODLIST = [];

  FoodViewModel() {
    initLoad();
  }
  void initLoad() {
    for (int i = 0; i < max_count; i++) {
      FOODLIST.add(foodList[i]);
    }
 notifyListeners();
  }

  Future<void> onLoading() async {
    if (max_count == foodList.length) {
      controller.loadNoData();
    } else {
     Future.delayed(Duration(milliseconds: 1000),(){
       getList(max_count + 15);
     });
      controller.loadComplete();
    }

  }

  Future<void> onRefresh(BuildContext context) async {
    onRefreshList();
    controller.refreshCompleted();
  }

  void getList(int nextCount) {
    int rest = foodList.length - max_count;
    if (rest <= 15) {
      for (int i = max_count; i < foodList.length; i++) {
        FOODLIST.add(foodList[i]);
        max_count = foodList.length;
        notifyListeners();
        print(rest);
      }
    } else if (rest > 15) {
      for (int i = max_count; i < nextCount; i++) {
        FOODLIST.add(foodList[i]);
        max_count = nextCount;
        notifyListeners();
        print(rest);
      }
    }
  }

  void onRefreshList() {
    clearList();
    initLoad();
    notifyListeners();
  }

  void clearList() {
    FOODLIST.clear();
  }
}
