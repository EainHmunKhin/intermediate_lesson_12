import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  late String? image;
  late String? name;
  late int? howlong;
  late double? distance;
  late double? rate;
  late String? kind;
  late String? deliveryfree;
  late String? deliverydiscount;
  late String? promo;
  FoodCard(this.image, this.name, this.howlong, this.distance, this.rate,
      this.kind, this.deliveryfree, this.deliverydiscount, this.promo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          children: [
            // Image.asset(
            //   image!,
            //   scale: 3,
            //
            // ),
            Image(
              image: AssetImage(image!),
              // width: 100,
              width: 80,
              height: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  promo == ""
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : Text(
                          promo!,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                  Text(
                    name!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${howlong.toString()} mins ·",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "${distance.toString()} km",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: Colors.orange,
                      ),
                      Text(
                        rate.toString(),
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    kind!,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      deliveryfree == ""
                          ? Container(
                              padding: const EdgeInsets.all(0),
                            )
                          : Container(
                              padding: const EdgeInsets.all(3),
                              color: Color.fromARGB(100, 216, 201, 177),
                              child: Text(
                                deliveryfree!,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              )),
                      const SizedBox(
                        width: 10,
                      ),
                      deliverydiscount == ""
                          ? Container(
                              padding: const EdgeInsets.all(0),
                            )
                          : Container(
                              padding: const EdgeInsets.all(3),
                              color: Color.fromARGB(100, 216, 201, 177),
                              child: Text(
                                deliverydiscount!,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 10),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
