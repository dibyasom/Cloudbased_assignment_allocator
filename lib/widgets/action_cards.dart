import 'package:assignment_custom_randomiser/models/user.dart';
import 'package:assignment_custom_randomiser/screens/create_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({Key? key, required this.cardTopic}) : super(key: key);
  final String cardTopic;

  @override
  Widget build(BuildContext context) {
    BuildContext _myContext = context;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      print(constraints.maxWidth);
      return SizedBox(
        height: constraints.maxHeight / 2,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / 10,
              vertical: constraints.maxHeight / 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFF1D0045),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    " ${this.cardTopic}",
                    style: GoogleFonts.notoSans(
                        fontSize: constraints.maxWidth * 25 / 512,
                        color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => (this.cardTopic == "Contacts")
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateContact(
                                signedInUser:
                                    Provider.of<SignedInUser>(_myContext),
                              ),
                            ),
                          )
                        : null,
                    child: Icon(
                      Icons.add_circle_rounded,
                      size: constraints.maxWidth / 8,
                      color: Color(0xFF00BCD4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
