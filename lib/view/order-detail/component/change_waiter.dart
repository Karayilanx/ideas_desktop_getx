import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/login/model/terminal_user.dart';

class ChangeWaiter extends StatelessWidget {
  final List<TerminalUser> users;

  const ChangeWaiter(this.users, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        SizedBox(
          height: context.height * 70 / 100,
          width: context.width * 50 / 100,
          child: Column(
            children: [
              Container(
                  color: context.theme.primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Garson Değiştir',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    children: createUsers(context),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 8)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ))),
                        child: const Text(
                          'Vazgeç',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> createUsers(BuildContext context) {
    if (users.isNotEmpty) {
      return List.generate(users.length, (index) {
        TerminalUser user = users[index];
        return ElevatedButton(
            onPressed: () {
              Navigator.pop(context, user.terminalUserId);
            },
            child: Text(user.name!));
      });
    } else {
      return [];
    }
  }
}
