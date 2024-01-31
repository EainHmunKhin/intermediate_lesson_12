import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FoodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// For foodlist Initial Event             //foodlist initial      //foodlistRefreshevent  //foodlistloadmoreevent
class FoodListEvent extends FoodEvent {
  int maxCount;
  FoodListEvent({required this.maxCount});
}
class FoodListInitialEvent extends FoodEvent{
  
}
class FoodListRefreshEvent extends FoodEvent {
  int maxCount;
  FoodListRefreshEvent({required this.maxCount});
}

class FoodListLoadingEvent extends FoodEvent {
 int maxCount;
  FoodListLoadingEvent({required this.maxCount});
}

class SearchFoodEvent extends FoodEvent {
  String foodName;
  SearchFoodEvent({required this.foodName});
}

