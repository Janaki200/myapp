import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/widgets/app_loader.dart';

class Order extends StatefulWidget {
  Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final delivererController = TextEditingController();

  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.primaryColor,
              ))
        ],
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        backgroundColor: AppColors.surfaceColor,
        title: const TextLogo(
          text: 'Pending orders',
          color: AppColors.primaryColor,
          fontSize: 20,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "Pending")
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
                                                DataCell(Text(
                                                    itemData["portion"] +
                                                        "(g)")),
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
                                        Text(docs?[index]['payment_methode']),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: MaterialButton(
                                          color: AppColors.primaryColor,
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Accept Order"),
                                                  content: SizedBox(
                                                    height: 200,
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              delivererController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Deliverer Name"),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              timeController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Deliverey time (in minutes)"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    MaterialButton(
                                                      color: AppColors
                                                          .primaryColor,
                                                      child: const Text(
                                                        "Confirm Odrer",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .surfaceColor),
                                                      ),
                                                      onPressed: () async {
                                                        Map<String, dynamic>
                                                            req =
                                                            docs?[index].data()
                                                                as Map<String,
                                                                    dynamic>;
                                                        setState(() {
                                                          req['status'] =
                                                              "Out for delivary";
                                                          req['deliverer'] =
                                                              delivererController
                                                                  .text
                                                                  .trim();
                                                          req['deliveryTime'] =
                                                              timeController
                                                                  .text
                                                                  .trim();
                                                        });
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "orders")
                                                            .doc(
                                                                docs?[index].id)
                                                            .update(req);
                                                            Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            "Accept Order",
                                            style: TextStyle(
                                                color: AppColors.surfaceColor),
                                          )),
                                    )
                                  ]))));
                    }));
          } else {
            return AppLoader();
          }
        },
      ),
    );
  }
}
