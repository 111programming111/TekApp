import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tek_app/constance.dart';
import 'package:tek_app/core/view_model/cart_viewmodel.dart';
import 'package:tek_app/core/view_model/checkout_viewmodel.dart';
import 'package:tek_app/view/widgets/custom_text.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CartViewModel>(
        builder: (controller) => Column(
          children: [
            CustomText(
              text: 'Summary',
              fontSize: 15,
              alignment: Alignment.center,
              color: kMainColor,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  child: Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 180,
                          child: Image.network(
                            controller.cartProductModel[index].image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              text: controller.cartProductModel[index].name),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          alignment: Alignment.bottomLeft,
                          color: Colors.red,
                          text:
                              '\X ${controller.cartProductModel[index].quantity.toString()}',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          alignment: Alignment.bottomLeft,
                          color: kMainColor,
                          text:
                              '\$ ${controller.cartProductModel[index].price.toString()}',
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: controller.cartProductModel.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 15,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: 'Shopping Address',
                fontSize: 24,
              ),
            ),
            GetBuilder<CheckOutViewModel>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  color: Colors.grey,
                  fontSize: 24,
                  text:
                      '${controller.street1 + ' , ' + controller.street2 + ' , ' + controller.state + ' , ' + controller.city + ' , ' + controller.country}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
