import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tek_app/constance.dart';
import 'package:tek_app/view/widgets/custom_button.dart';
import 'package:tek_app/view/widgets/custom_text.dart';

class CartView extends StatelessWidget {
  List<String> names = <String>[
    'Coat',
    'Coat',
    'Coat',
    'Coat',
    'Coat',
  ];
  List<String> images = <String>[
    'assets/images/coat2.jpg',
    'assets/images/coat3.jpg',
    'assets/images/coat.jpg',
    'assets/images/coatw2.jpg',
    'assets/images/skrit.webp',
  ];
  List<int> prices = <int>[100, 200, 300, 400, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                      height: 140,
                      child: Row(
                        children: [
                          Container(
                            width: 140,
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: names[index],
                                  fontSize: 24,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  color: kMainColor,
                                  text: '\$ ${prices[index].toString()}',
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 140,
                                  color: Colors.grey.shade200,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CustomText(
                                        alignment: Alignment.center,
                                        text: '1',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: Icon(
                                          Icons.minimize,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                },
                itemCount: names.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: 'TOTAL',
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: '\$ 2000',
                      color: kMainColor,
                      fontSize: 18,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 100,
                  width: 180,
                  child: CustomButton(
                    onPressed: () {},
                    text: 'CHECKOUT',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
