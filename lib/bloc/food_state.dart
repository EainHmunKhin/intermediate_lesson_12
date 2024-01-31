import 'package:equatable/equatable.dart';

import '../modal/food_model.dart';

abstract class FoodState extends Equatable {
  const FoodState();
  @override
  List<Object> get props => [];
}

//for initial State //foodlist initial      //foodlistRefreshevent  //foodlistloadmoreevent
class FoodListInitialState extends FoodState {}

class FoodEventLoading extends FoodState{}

//For food event success state
class FoodEventSuccessState extends FoodState {}

//for food search success
class FoodSearchEventSuccessState extends FoodState {
  FoodModal searchName;
  FoodSearchEventSuccessState( this.searchName);
}



//for food search fail
class FoodSearchEventFailureState extends FoodState {}

//for Food search error
class FoodSearchEventErrorState extends FoodState {
  String msgError;
  FoodSearchEventErrorState({required this.msgError});
}

//for food not found state
class FoodNotEventFoundState extends FoodState {}
class FoodLoadingState extends FoodState{

FoodLoadingState();
}
class FoodRefreshState extends FoodState{
  int maxCount;
  FoodRefreshState({required this.maxCount});
}


