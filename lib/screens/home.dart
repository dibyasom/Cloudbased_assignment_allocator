import 'package:assignment_custom_randomiser/widgets/home_layout.dart';
import 'package:assignment_custom_randomiser/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.signedInUser}) : super(key: key);
  final SignedInUser signedInUser;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignedInUser>(
      create: (context) => widget.signedInUser,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1080) {
              return Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: UserProfileCard(
                              signedInUser: widget.signedInUser),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Center(child: HomeExplorer()),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("Support rolling out soon <3 !"),
              );
            }
          },
        ),
      ),
    );
  }
}
