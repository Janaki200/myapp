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
  // List allOrders = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   loadOrders();
  //   super.initState();
  // }

  // void loadOrders() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   List<String> orderId = [];
  //   final user = FirebaseAuth.instance.currentUser!;
  //   final order = await FirebaseFirestore.instance.collection("orders").get();
  //   for (var element in order.docs) {
  //     final orderDoc = element.data();
  //     if (orderDoc["userEmail"] == user.email) {
  //       allOrders.add(orderDoc);
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final feedBackController = TextEditingController();
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
        body: StreamBuilder(
          stream: _firestore
              .collection('orders')
              .where('userEmail', isEqualTo: _auth.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppLoader();
            }
            if (snapshot.hasData) {
              final docs = snapshot.data?.docs;
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: docs?.length,
                  itemBuilder: (context, index) {
                    Timestamp timestamp = docs?[index]['placed_at'];
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                        timestamp.millisecondsSinceEpoch);

// Format the DateTime object into HH/MM/DD/MM/YY format
                    String formattedTime =
                        DateFormat('HH:mm DD/MM/yy').format(dateTime);

                    List customItems = docs?[index]['custom'];
                    if (docs?[index]['status'].toString().toLowerCase() ==
                        "delivered") {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black)),
                              child: ListTile(
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          docs?[index]['orderName'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Ordered at : $formattedTime",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    if (customItems.isNotEmpty)
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DataTable(
                                          columnSpacing: 5,
                                          columns: const [
                                            DataColumn(
                                              label: Text("Item"),
                                            ),
                                            DataColumn(
                                              label: Text("Portion"),
                                            ),
                                            DataColumn(
                                              label: Text("Qty"),
                                            ),
                                            DataColumn(
                                              label: Text("Amount"),
                                            ),
                                          ],
                                          rows: customItems.map((itemData) {
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                    Text(itemData['item'])),
                                                DataCell(
                                                    Text(itemData["portion"])),
                                                DataCell(Text(itemData[
                                                        'quantity']
                                                    .toString())), // Ensure correct data type
                                                DataCell(Text(itemData['price']
                                                    .toString())),
                                                // Ensure correct data type
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      docs?[index]['status'],
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                      const SizedBox(height:10,),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivered by :"+docs?[index]['deliverer']),
                                            Text("Delivering In :"+docs?[index]['deliveryTime'],style: TextStyle(color: AppColors.primaryColor),),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height:10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${docs?[index]['price']}₹",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent),
                                        ),
                                        Text(docs?[index]['payment_methode'])
                                      ],
                                    ),

                                    if (docs?[index]['feedBack'] == "")
                                      Column(
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(
                                                hintText: "Write a feedback"),
                                            controller: feedBackController,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          AppColors
                                                              .primaryColor)),
                                              onPressed: () async {
                                                setState(() {
                                                  isLoading=true;
                                                });
                                                if (feedBackController
                                                    .text.isNotEmpty) {
                                                  try {
                                                    Map<String, dynamic> data =
                                                        {};
                                                    setState(() {
                                                      data = docs![index].data()
                                                          as Map<String,
                                                              dynamic>;
                                                      data['feedBack'] =
                                                          feedBackController
                                                              .text
                                                              .trim();
                                                    });
                                                    await _firestore
                                                        .collection("orders")
                                                        .doc(docs?[index].id)
                                                        .update(data);
                                                        setState(() {
                                                  isLoading=false;
                                                });
                                                  }  catch (e) {
                                                      setState(() {
                                                  isLoading=false;
                                                });
                                                     ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:  Text(
                                                              e.toString())));
                                                  }
                                                } else {
                                                    setState(() {
                                                  isLoading=false;
                                                });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: const Text(
                                                              "Fill the fieds")));
                                                }
                                              },
                                              child: const Text(
                                                "Give Feedback",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                      ),
                                    if (docs?[index]['feedBack'] != "")
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("FeedBack"),
                                            Text(docs?[index]['feedBack']),
                                          ],
                                        ),
                                      )
                                  ]))));
                    }

                    if (docs?[index]['status'].toString().toLowerCase() ==
                        "pending") {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: ListTile(
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          docs?[index]['orderName'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Ordered at : $formattedTime",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    if (customItems.isNotEmpty)
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DataTable(
                                          columnSpacing: 5,
                                          columns: const [
                                            DataColumn(
                                              label: Text("Item"),
                                            ),
                                            DataColumn(
                                              label: Text("Portion"),
                                            ),
                                            DataColumn(
                                              label: Text("Qty"),
                                            ),
                                            DataColumn(
                                              label: Text("Amount"),
                                            ),
                                          ],
                                          rows: customItems.map((itemData) {
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                    Text(itemData['item'])),
                                                DataCell(
                                                    Text(itemData["portion"])),
                                                DataCell(Text(itemData[
                                                        'quantity']
                                                    .toString())), // Ensure correct data type
                                                DataCell(Text(itemData['price']
                                                    .toString())),
                                                // Ensure correct data type
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    Text(
                                      docs?[index]['status'],
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${docs?[index]['price']}₹",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent),
                                        ),
                                        Text(docs?[index]['payment_methode'])
                                      ],
                                    )
                                  ]))));
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black)),
                              child: ListTile(
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          docs?[index]['orderName'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Ordered at : $formattedTime",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    if (customItems.isNotEmpty)
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DataTable(
                                          columnSpacing: 5,
                                          columns: const [
                                            DataColumn(
                                              label: Text("Item"),
                                            ),
                                            DataColumn(
                                              label: Text("Portion"),
                                            ),
                                            DataColumn(
                                              label: Text("Qty"),
                                            ),
                                            DataColumn(
                                              label: Text("Amount"),
                                            ),
                                          ],
                                          rows: customItems.map((itemData) {
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                    Text(itemData['item'])),
                                                DataCell(
                                                    Text(itemData["portion"])),
                                                DataCell(Text(itemData[
                                                        'quantity']
                                                    .toString())), // Ensure correct data type
                                                DataCell(Text(itemData['price']
                                                    .toString())),
                                                // Ensure correct data type
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    Text(
                                      docs?[index]['status'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height:10,),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivered by :"+docs?[index]['deliverer']),
                                            Text("Delivering In :"+docs?[index]['deliveryTime'],style: TextStyle(color: AppColors.primaryColor),),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height:10,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${docs?[index]['price']}₹",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent),
                                        ),
                                        Text(docs?[index]['payment_methode'])
                                      ],
                                    ),
                                  
                                  ]))));
                    }
                  },
                ),
              );
            } else {
              return AppLoader();
            }
          },
        ));
  }
}
