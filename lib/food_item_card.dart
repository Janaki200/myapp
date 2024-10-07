import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class FoodItemCard extends StatefulWidget {
  final String name, description, recipe, category, image;
  final double price;
  final List<dynamic> customValues;
  final List<Map> cartList;
  final bool isCustomisable;
  final void Function({required Map data, required double price}) addItemCart;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1553142816.
  const FoodItemCard(
      {super.key,
      required this.name,
      required this.description,
      required this.recipe,
      required this.price,
      required this.category,
      required this.image,
      required this.customValues,
      required this.isCustomisable,
      required this.cartList,
      required this.addItemCart});

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  double price = 0;
  bool isExpanded = false;
  List<Map> itemCustomization = [];
  @override
  void initState() {
    // TODO: implement initState
    for (var element in widget.customValues) {
      final data = {
        "name": element['name'],
        "price": element['price'],
        "qty": 0,
      };
      itemCustomization.add(data);
    }
    setState(() {
      price = widget.price;
    });
    super.initState();
  }

  void init() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 130,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.cover),
                    color: Colors.white),
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(widget.category),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.description,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "$price₹",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isCustomisable && !isExpanded)
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                      color: AppColors.primaryColor,
                      child: const Text("Customize",style:TextStyle(color:AppColors.surfaceColor)),
                    ),
                  if (!isExpanded)
                    MaterialButton(
                      onPressed: () {
                         List<Map> customItems = [];
                            setState(() {
                              for (var element in itemCustomization) {
                                if (element['qty'] != 0) {
                                  final map = {
                                    "name": element['name'],
                                    "qty": element['qty'],
                                    "price": element['price']*
                                        element['qty']
                                  };
                                  customItems.add(map);
                                }
                              }
                          final data = {
                                "custom": customItems,
                                "price": price,
                                "itemName": widget.name
                              };
                              print(customItems);
                              widget.addItemCart(data: data, price: price);
                            });
                      },
                      color: AppColors.primaryColor,
                      child: const Text("Add to cart",style:TextStyle(color:AppColors.surfaceColor)),
                    ),
                ],
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var element in itemCustomization)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                element['name'] +"(50g)",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text("${element['price']}₹",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.blueAccent)),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (element["qty"] > 0) {
                                          element["qty"]--;
                                          price -= element["price"];
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.exposure_minus_1)),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(element["qty"].toString())),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        element["qty"]++;
                                        price += element["price"];
                                      });
                                    },
                                    icon: const Icon(Icons.plus_one)),
                              ],
                            )
                          ],
                        ),
                      if (isExpanded)
                        MaterialButton(
                          onPressed: () async {
                            List<Map> customItems = [];
                            setState(() {
                              for (var element in itemCustomization) {
                                if (element['qty'] != 0) {
                                  final map = {
                                    "name": element['name'],
                                    "qty": element['qty'],
                                    "price": element['price']*
                                        element['qty']
                                  };
                                  customItems.add(map);
                                }
                              }
                              final data = {
                                "custom": customItems,
                                "price": price,
                                "itemName": widget.name
                              };
                              print(customItems);
                              widget.addItemCart(data: data, price: price);
                            });
                          },
                          color: AppColors.primaryColor,
                          child: const Text("Add to cart"),
                        ),
                      if (isExpanded)
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = false;
                              });
                            },
                            icon: const Icon(Icons.arrow_upward_rounded))
                    ],
                  ),
                )
            ]),
          )),
    );
  }
}
