import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final SignedInUser signedInUser;

  UserProfileCard({required this.signedInUser});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      print(this.signedInUser.user);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  focusColor: Colors.grey,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(signedInUser.user!.photoURL!),
                  ),
                  title: Text(
                    signedInUser.user!.displayName!,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  subtitle: Text(
                    '${signedInUser.user!.email}',
                    style: TextStyle(fontSize: 15.0, color: Colors.lightBlueAccent),
                    textAlign: TextAlign.start,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.lock_clock),
                  title: Text(
                    signedInUser.user!.metadata.lastSignInTime.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  subtitle: Text(
                    "Last checked in@",
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
                  ),
                )
                // TextButton(
                //   onPressed: () => userProfile.signOut(context),
                //   child: UserProfile.logOutIcon,
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
