import 'package:ecommerce_app/commn/routes.dart';
import 'package:ecommerce_app/screens/home/homeCubit.dart';
import 'package:ecommerce_app/screens/home/homeScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardItemWidget extends StatelessWidget {
  int index;
  CardItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.04),
      margin: EdgeInsets.all(
          MediaQuery.of(context).size.width *
              0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(
                0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
              context, Routes.routeSingleProduct,
              arguments: ProductArg(
                  id: HomeCubit.get(context)
                      .Products[index]["id"],
                  index: index));
        },
        child: Column(
          children: [
            // Image.asset(HomeCubit.get(context).Products[index]["image"]),
            Image.network(
                HomeCubit.get(context)
                    .Products[index]["image"],
                height: 80,
                width: 80),

            Text(
                HomeCubit.get(context)
                    .Products[index]["title"],
                overflow: TextOverflow.ellipsis),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.attach_money_outlined,
                    size: 20),
                Text(HomeCubit.get(context)
                    .Products[index]["price"]
                    .toString()),
                const Spacer(),
                Text(HomeCubit.get(context)
                    .Products[index]["rating"]
                ["rate"]
                    .toString()),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
