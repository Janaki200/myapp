import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/widgets/app_loader.dart';

class OutforDelivery extends StatefulWidget {
  const OutforDelivery({super.key});

  @override
  State<OutforDelivery> createState() => _OutforDeliveryState();
}

class _OutforDeliveryState extends State<OutforDelivery> {
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
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        backgroundColor: AppColors.surfaceColor,
        title: const TextLogo(
          text: 'Out for delivery',
          color: AppColors.primaryColor,
          fontSize: 20,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "Out for delivary")
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
                                        Text(
                                          docs?[index]['status'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.deepOrangeAccent),
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
                                                  title:
                                                      Text("Conifrm delivery"),
                                                  actions: [
                                                    MaterialButton(
                                                      color: AppColors
                                                          .primaryColor,
                                                      child: const Text(
                                                        "Confirm delivery",
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
                                                              "Completed";
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
                                            "Conifrm delivery",
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
