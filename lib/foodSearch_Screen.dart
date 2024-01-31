import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intermediate_lesson_12/bloc/food_event.dart';
import 'package:intermediate_lesson_12/modal/food_model.dart';

import 'bloc/food_bloc.dart';
import 'bloc/food_state.dart';
import 'food_list_view.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  // FoodBloc foodBloc = FoodBloc();
  FoodBloc FOODBLOC = FoodBloc();
  late FoodModal foodName;
  late FoodModal foodModel;
  bool isShow = false;
  bool noData = false;
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isShow ? Colors.grey : Colors.white,
      body: BlocProvider(
        create: (BuildContext context) => FOODBLOC,
        child: BlocListener<FoodBloc, FoodState>(listener: (context, state) {
          if (state is FoodSearchEventSuccessState) {
            setState(() {
              foodName = state.searchName;
              isShow = true;
              noData = false;
            });
          } else if (state is FoodSearchEventFailureState ||
              state is FoodSearchEventErrorState) {
            FocusScope.of(context).unfocus();
            setState(() {
              isShow = false;
              noData = true;
            });
          }
        }, child: SingleChildScrollView(
          child: BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodEventLoading) {
                return const CircularProgressIndicator();
              } else {
                return SafeArea(
                  child: Stack(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return FoodListView();
                                }));
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                              ),
                              color: Colors.blue,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: TextFormField(
                                cursorColor: Colors.white,
                                controller: searchEditingController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: TextStyle(color: Colors.white),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        // // foodBloc.add(SearchFoodEvent(
                                        // //     foodName: searchEditingController
                                        // //         .text
                                        // //         .toString()));
                                        // // FOODBLOC.add(SearchFoodEvent(
                                        // //     foodName: searchEditingController
                                        // //         .text
                                        // //         .toString()));
                                        // FOODBLOC.add(SearchFoodEvent(
                                        //     foodName: searchEditingController
                                        //         .text
                                        //         .toString()));
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FOODBLOC.add(SearchFoodEvent(
                                foodName:
                                    searchEditingController.text.toString()));
                          },
                          child: Text("Search"),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              isShow
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  foodName.imageUrl!))),
                                    )
                                  : Container(),
                              isShow
                                  ? Column(
                                      children: [
                                        Text(foodName.name!),
                                      ],
                                    )
                                  : Container(),
                              noData
                                  ? Container(
                                      child: const Center(
                                          child: Text("No Data was found")),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                );
              }
            },
          ),
        )),
      ),
    );
  }
}
