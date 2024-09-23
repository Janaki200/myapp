// Suggested code may be subject to a license. Learn more: ~LicenseLog:2655137097.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3452535555.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2386051279.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/constants/app_colors.dart';
import 'package:myapp/data/constants/logo.dart';
import 'package:myapp/loading_screen.dart';
import 'package:myapp/widgets/app_loader.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map userDetails = {};
  bool isloaded = true;
  @override
  void initState() {
    // TODO: implement initState

    loadUser();
    super.initState();
  }

  void loadUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .get();
    if (documentSnapshot.exists) {
      final userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        userDetails = userData;
        isloaded=false;
      });
    } else {
      print('No document found for user email');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(isloaded){
      return const AppLoader();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.surfaceColor),
        backgroundColor: AppColors.primaryColor,
        title: const TextLogo(
          text: "Profile",
          color: AppColors.surfaceColor,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primaryColor),
                child: Icon(
                  Icons.person,
                  color: AppColors.surfaceColor,
                  size: MediaQuery.of(context).size.height / 6,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(userDetails['username'] ?? ""),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(userDetails['email'] ?? ""),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(userDetails['contact'] ?? ""),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(userDetails['address'] ?? ""),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: AppColors.primaryColor,
                  onPressed: () async {
                    setState(() {
                      isloaded=true;
                    });
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoadingScreen();
                      },
                    ), (route) => false);
                  },
                  child: Text(
                    "Logout",
                    style: const TextStyle(
                        color: AppColors.surfaceColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
