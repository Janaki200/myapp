import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/widgets/app_loader.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;
  List allOrders = [];
  @override
  void initState() {
    // TODO: implement initState
    loadOrders();
    super.initState();
  }

  void loadOrders() async {
    setState(() {
      isLoading = true;
    });
    List<String> orderId = [];
    final user = FirebaseAuth.instance.currentUser!;
    final order = await FirebaseFirestore.instance.collection("orders").get();
    for (var element in order.docs) {
      final orderDoc = element.data();
      if (orderDoc["userEmail"] == user.email) {
        allOrders.add(orderDoc);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppLoader();
    }
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.surfaceColor),
        backgroundColor: AppColors.primaryColor,
        title: const TextLogo(
          text: 'Orders',
          color: AppColors.surfaceColor,
          fontSize: 20,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: allOrders.length,
          itemBuilder: (context, index) {
            Timestamp timestamp = allOrders[index]['placed_at'];
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                timestamp.millisecondsSinceEpoch);

// Format the DateTime object into HH/MM/DD/MM/YY format
            String formattedTime =
                DateFormat('HH:mm DD/MM/yy').format(dateTime);
            bool isDelivered =
                allOrders[index]['status'].toString().toLowerCase() ==
                        "delivered"
                    ? true
                    : false;

            List customItems = allOrders[index]['custom'];
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        color: isDelivered
                            ? Colors.green.withOpacity(0.3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isDelivered
                                ? Colors.green
                                : AppColors.primaryColor)),
                    child: ListTile(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allOrders[index]['orderName'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Text(
                            "Ordered at : $formattedTime",
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (customItems.isNotEmpty)
                            for (var i in customItems) Text(i.toString()),
                          Text(
                            allOrders[index]['status'],
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    isDelivered ? Colors.green : Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${allOrders[index]['price']}₹",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent),
                              ),
                              Text(allOrders[index]['payment_methode'])
                            ],
                          )
                        ]))));
          },
        ),
      ),
    );
  }
}
