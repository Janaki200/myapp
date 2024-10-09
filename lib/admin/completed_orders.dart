import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/widgets/app_loader.dart';

class CompletedOrders extends StatelessWidget {
const CompletedOrders({ super.key });

  @override
  Widget build(BuildContext context){
   return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async{
             await FirebaseAuth.instance.signOut();
            }, icon:const Icon(Icons.logout,color: AppColors.primaryColor,))
          ],
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          backgroundColor: AppColors.surfaceColor,
          title: const TextLogo(
            text: 'Completed',
            color: AppColors.primaryColor,
            fontSize: 20,
          ),
        ),
           body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "Completed")
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
                                              color: Colors.green),
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
                    }));
          } else {
            return AppLoader();
          }
        },
      ),
    );
  }
}