import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';

class MySquare extends StatefulWidget {
  final String name, description, recipe, price, category, image;

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1553142816.
  MySquare(
      {super.key,
      required this.name,
      required this.description,
      required this.recipe,
      required this.price,
      required this.category,
      required this.image});

  @override
  State<MySquare> createState() => _MySquareState();
}

class _MySquareState extends State<MySquare> {
  String price = "";
  bool isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void init() {
    price = widget.price;
  }

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
          child: SizedBox(
            width: 250,
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
                widget.price + "₹",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    child: const Text("Customize"),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: AppColors.primaryColor,
                    child: const Text("Add to cart"),
                  ),
                ],
              ),
              if (isExpanded)
                Column(
                  children: [],
                )
            ]),
          )),
    );
  }
}
