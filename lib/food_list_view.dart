// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:intermediate_lesson_12/FoodCard.dart';
// import 'package:intermediate_lesson_12/foodSearch_Screen.dart';
// import 'package:intermediate_lesson_12/modal/food_model.dart';
// import 'package:intermediate_lesson_12/modal/food_view_model.dart';

// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class FoodListView extends StatefulWidget {
//   const FoodListView({super.key});

//   @override
//   State<FoodListView> createState() => _FoodListViewState();
// }

// class _FoodListViewState extends State<FoodListView> {
//   @override
//   Widget build(BuildContext context) {
//     FoodViewModel viewModel = context.watch<FoodViewModel>();
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (BuildContext context) {
//                   return FoodListScreen();
//                 }));
//               },
//               icon: Icon(Icons.search))
//         ],
//       ),
//       body: SmartRefresher(
//         enablePullUp: true,
//         enablePullDown: true,
//         controller: viewModel.controller,
//         onLoading: () {
//           viewModel.onLoading();
//         },
//         onRefresh: () {
//           viewModel.onRefresh(context);
//         },
//         footer: CustomFooter(
//           builder: (BuildContext context, LoadStatus? mode) {
//             Widget body = Container();
//             if (mode == LoadStatus.loading) {
//               body = const CupertinoActivityIndicator();
//             } else if (mode == LoadStatus.noMore) {
//               body = Text("No More Data");
//             }
//             return Container(
//               child: Center(child: body),
//             );
//           },
//         ),
//         // child: _FoodListWidget(viewModel.FOODLIST, viewModel),
//         child: ListView.builder(
//             itemCount: viewModel.FOODLIST.length,
//             itemBuilder: (BuildContext context, int i) {
//               return FoodCard(
//                   viewModel.FOODLIST[i].imageUrl,
//                   viewModel.FOODLIST[i].name,
//                   viewModel.FOODLIST[i].howlong,
//                   viewModel.FOODLIST[i].distance,
//                   viewModel.FOODLIST[i].rate,
//                   viewModel.FOODLIST[i].kind,
//                   viewModel.FOODLIST[i].deliveryFeed,
//                   viewModel.FOODLIST[i].delivery,
//                   viewModel.FOODLIST[i].isPromo);
//             }),
//       ),
//     );
//   }

//   // Widget _FoodListWidget(
//   //   List<FoodModal>? FoodList,
//   //   FoodViewModel viewModel,
//   // ) {
//   //   return ListView.builder(
//   //       itemCount: FoodList?.length,
//   //       itemBuilder: (_, int index) {
//   //         return FoodCard(
//   //             FoodList?[index].imageUrl,
//   //             FoodList?[index].name,
//   //             FoodList?[index].howlong,
//   //             FoodList?[index].distance,
//   //             FoodList?[index].rate,
//   //             FoodList?[index].kind,
//   //             FoodList?[index].deliveryFeed,
//   //             FoodList?[index].delivery,
//   //             FoodList?[index].isPromo);
//   //       });
//   // }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intermediate_lesson_12/FoodCard.dart';
import 'package:intermediate_lesson_12/bloc/food_bloc.dart';
import 'package:intermediate_lesson_12/bloc/food_event.dart';
import 'package:intermediate_lesson_12/bloc/food_state.dart';
import 'package:intermediate_lesson_12/const.dart';
import 'package:intermediate_lesson_12/foodSearch_Screen.dart';
import 'package:intermediate_lesson_12/modal/food_model.dart';
import 'package:intermediate_lesson_12/modal/food_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  FoodBloc foodBloc = FoodBloc();

  RefreshController refreshController = RefreshController(initialRefresh: true);
  List<FoodModal> FOODLIST = [];
  int maxCount = 15;
  void initLoad() {
    for (int i = 0; i < maxCount; i++) {
      FOODLIST.add(foodList[i]);
    }
    // setState(() {});
  }

  void clearList() {
    FOODLIST.clear();
  }

  void onRefreshList() {
    clearList();
    initLoad();
    setState(() {});
  }

  Future<void> onRefresh(BuildContext context) async {
    onRefreshList();
    refreshController.refreshCompleted();
  }

  void getList(int nextCount) {
    int rest = foodList.length - maxCount;
    if (rest <= 15) {
      for (int i = maxCount; i < foodList.length; i++) {
        FOODLIST.add(foodList[i]);
        maxCount = foodList.length;
        setState(() {});
        print(rest);
      }
    } else if (rest > 15) {
      for (int i = maxCount; i < nextCount; i++) {
        FOODLIST.add(foodList[i]);
        maxCount = nextCount;
        setState(() {});
        print(rest);
      }
    }
  }

  Future<void> onLoading() async {
    if (maxCount == foodList.length) {
      refreshController.loadNoData();
    } else {
      Future.delayed(Duration(milliseconds: 1000), () {
        getList(maxCount + 15);
      });
      refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext contextt) {
                return FoodListScreen();
              }));
            },
            icon: Icon(Icons.search))
      ]),
      body: BlocProvider(
        create: (context) => foodBloc,
        child: BlocListener<FoodBloc, FoodState>(
          listener: (context, state) {
            if (state is FoodRefreshState) {
              onRefresh(context);
              setState(() {});
              print("Food Refreshing and Refreshing");
            } else if (state is FoodLoadingState) {
              onLoading();
              print("Food Loading and Loading");
              setState(() {});
            }
          },
          child: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
            return Scaffold(
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () {
                  foodBloc.add(FoodListLoadingEvent(maxCount: maxCount));
                  // onLoading();
                },
                onRefresh: () {
                  foodBloc.add(FoodListRefreshEvent(maxCount: maxCount));
 
                },
                footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                  Widget? body;
                  if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.noMore) {
                    body = const Text("No Data");
                  }
                  return Container(
                    child: Center(child: body),
                  );
                }),
                controller: refreshController,
                child: ListView.builder(
                    itemCount: FOODLIST.length,
                    itemBuilder: (_, int i) {
                      return FoodCard(
                          FOODLIST[i].imageUrl,
                          FOODLIST[i].name,
                          FOODLIST[i].howlong,
                          FOODLIST[i].distance,
                          FOODLIST[i].rate,
                          FOODLIST[i].kind,
                          FOODLIST[i].deliveryFeed,
                          FOODLIST[i].delivery,
                          FOODLIST[i].isPromo);
                    }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
