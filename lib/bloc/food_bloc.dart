import 'package:flutter/material.dart';
import 'package:intermediate_lesson_12/const.dart';
import 'package:intermediate_lesson_12/modal/food_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'food_event.dart';
import 'food_state.dart';

late BuildContext context;
List<FoodModal> Foodlist = [];
void clearList() {
  Foodlist.clear;
}

void initialload(int maxCount) {
  for (int i = 0; i < maxCount; i++) {
    foodList.add(Foodlist[i]);
  }
}

void onRefreshList(int maxCount) {
  clearList();
  initialload(maxCount);
}

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  FoodBloc() : super(FoodListInitialState());
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FoodListRefreshEvent) {
      yield* _mapGetRefreshEvent(event);
    } else if (event is FoodListLoadingEvent) {
      yield* _mapLoadingFoodList(event);
    } else if (event is SearchFoodEvent) {
      yield* _mapSearchFoodEvent(event);
    }
    else if(event is FoodListInitialEvent){
      yield* _mapFoodListInitial(event);
    }
  }

  Stream<FoodState> _mapGetRefreshEvent(FoodListRefreshEvent event) async* {
    yield FoodRefreshState(maxCount: event.maxCount);
    print("Linking Food Refreshing");
  }

  Stream<FoodState> _mapLoadingFoodList(FoodListLoadingEvent event) async* {
    yield FoodLoadingState();
    print("Linking Food Loading");
  }
 Stream<FoodState> _mapFoodListInitial(FoodListInitialEvent event) async*{
  yield FoodListInitialState();
 }
  Stream<FoodState> _mapSearchFoodEvent(SearchFoodEvent event) async* {
    late FoodModal searchFood;
    yield FoodEventLoading();
    try {
      for (FoodModal food in foodList) {
        if (food.name?.toLowerCase() == event.foodName.toLowerCase()) {
          searchFood = food;
        }
      }
      if (searchFood.name != null) {
        yield FoodSearchEventSuccessState(searchFood);
      } else {
        yield FoodSearchEventFailureState();
      }
    } catch (error) {
      yield FoodSearchEventErrorState(msgError: error.toString());
    }
  }
}
