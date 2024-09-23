import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/home.dart';
import 'package:myapp/widgets/app_loader.dart';

class CartViewPage extends StatefulWidget {
  final List<Map> cartItems;
  const CartViewPage({super.key, required this.cartItems});

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  bool isLoading = true;
  double totalPrice = 0;
  List<Map> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      cartItems = widget.cartItems;
    });
    for (var element in cartItems) {
      setState(() {
        totalPrice += element['price'];
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoader();
    }
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const TextLogo(
          text: 'Your cart',
          color: AppColors.surfaceColor,
          fontSize: 20,
        ),
      ),
      body: Column(
        mainAxisAlignment: cartItems.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (cartItems.isEmpty)
            const Center(
              child: Column(
                children: [
                  Text(
                    "Cart is empty",
                    style: TextStyle(fontSize: 25),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          if (cartItems.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  List customItems = cartItems[index]['custom'];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all()),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                cartItems[index]['itemName'],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    totalPrice -= cartItems[index]['price'];
                                    cartItems.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.primaryColor,
                                ))
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(customItems.isNotEmpty ? "Custom items" : "",
                                style: const TextStyle(fontSize: 18)),
                            if (customItems.isNotEmpty)
                              for (var e in customItems)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e['name']),
                                    Text(
                                      "${e['price']} ₹ (${e['qty']}) ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                            if (customItems.isNotEmpty)
                              const SizedBox(
                                height: 20,
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                cartItems[index]['price'].toString() +
                                    " ₹".toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  color: AppColors.primaryColor),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            color: AppColors.surfaceColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        totalPrice.toString() + " ₹",
                        style: const TextStyle(
                            color: AppColors.surfaceColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: AppColors.surfaceColor,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return PaymentBottomSheet(cartItems:cartItems,);
                          },
                        );
                      },
                      child: Text(
                        "Place Order",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PaymentBottomSheet extends StatefulWidget {
final   List<Map> cartItems;
  const PaymentBottomSheet({super.key, required this.cartItems,});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  bool _cardSelected = false;
  bool _gpaySelected = false;
  bool _cashOnDeliverySelected = false;
  bool isLoading = false;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvcController = TextEditingController();
    final TextEditingController _gpayController = TextEditingController(); 
  void _toggleSelection(int index) {
    setState(() {
      _cardSelected = index == 0;
      _gpaySelected = index == 1;
      _cashOnDeliverySelected = index == 2;
    });
  }
 void placeOrder() async {
String paymentMethode='';
String payementDetails = "";
  if(_cardSelected){
    setState(() {
      paymentMethode= "Card Payment";
      payementDetails=_cardNumberController.text;
    });
  }else if(_gpaySelected){
     setState(() {
      paymentMethode= "Upi Payment";
      payementDetails=_gpayController.text;
    });
  }else{
     setState(() {
      paymentMethode= "Cash on delivery";
      payementDetails ="Cash on delivery";
    });
  }



    setState(() {
      isLoading = true;
    });
    final user = FirebaseAuth.instance.currentUser!;
    final dateTime = DateTime.now();

    // Convert DateTime to Timestamp for Firestore
    final timestamp = Timestamp.fromDate(dateTime);
    try {
      // final data = {
      //   "userEmail": user.email,
      //   "isActive": true,
      //   "status": "Pending",
      //   "placed_at":timestamp,
      //   "total_amount":totalPrice
      // };
      // final order =
      //     await FirebaseFirestore.instance.collection("orders").add(data);
      // final orderId = order.id;
      List<String> customItem = [];
      for (var element in widget.cartItems) {
        List customItems = element['custom'];
        if (customItems.isNotEmpty) {
          for (var e in customItems) {
            String data = e['name'] + "-" + e['qty'].toString();
            customItem.add(data);
          }
        }
        final orderData = {
          "payment_methode":paymentMethode,
          "payment_details":payementDetails,
          "userEmail": user.email,
          'orderName': element['itemName'],
          'price': element['price'],
          "isActive": true,
          "status": "Pending",
          "placed_at": timestamp,
          "custom": customItems.isNotEmpty ? customItem : []
        };

        await FirebaseFirestore.instance.collection("orders").add(orderData);
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Order placed Successfully"),
              actions: [
                MaterialButton(
                  color: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const MyHomePage();
                      },
                    ), (route) => false);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: AppColors.surfaceColor),
                  ),
                )
              ],
            );
          },
        );
      }
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const AppLoader();
    }
    return Container(
      width: MediaQuery.of(context).size.width,
     
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Payment Options',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          ToggleButtons(
            borderRadius: BorderRadius.circular(16),
            selectedColor: AppColors.surfaceColor,
          fillColor: AppColors.primaryColor,
            isSelected: [_cardSelected, _gpaySelected, _cashOnDeliverySelected],
            onPressed: _toggleSelection,
            children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                  width: MediaQuery.of(context).size.width/4,
                  child: Text('Card',style: TextStyle(fontSize: 20),)),
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width/4,
                    child: Image.asset(
                        'assets/items/gpay.png')),
              ), // Replace with your GPay logo path
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                   width: MediaQuery.of(context).size.width/4,
                  child: const Text('Cash on Delivery',style: TextStyle(fontSize: 20),)),
              ),
            ],
          ),
          const SizedBox(height: 16.0),


          if(_gpaySelected)
          TextField(
            controller: _gpayController,
                 decoration: const InputDecoration(
                    labelText: 'Upi ID',
                  ),
          ),
          if (_cardSelected)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                  ),
                ),
                TextField(
                  controller: _cardExpiryController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                  ),
                ),
                TextField(
                  controller: _cardCvcController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16.0),
           SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: AppColors.primaryColor,
                      onPressed: () {
                   if(_cardSelected||_gpaySelected||_cashOnDeliverySelected){
                      placeOrder();
                  
                   }else{
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: const Text("Choose a payment option"),
                        actions: [
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text("Ok"))
                        ],
                      );
                    },);
                   }
                      },
                      child: const Text(
                        "Confirm order",
                        style: TextStyle(
                            color: AppColors.surfaceColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
        ],
      ),
    );
  }
}
