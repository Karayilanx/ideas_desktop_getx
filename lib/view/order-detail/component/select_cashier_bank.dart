import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/theme/theme.dart';
import '../../../model/check_account_model.dart';

class SelectCashierBank extends StatelessWidget {
  final List<CheckAccountListItem> checkAccounts;

  const SelectCashierBank(this.checkAccounts, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  color: ideasTheme.primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Seçiniz',
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
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    children: createCheckAccounts(context),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Spacer(flex: 2),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 16)),
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

  List<Widget> createCheckAccounts(BuildContext context) {
    if (checkAccounts.isNotEmpty) {
      return List.generate(checkAccounts.length, (index) {
        CheckAccountListItem checkAccount = checkAccounts[index];
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ideasTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, checkAccount.checkAccountId);
            },
            child: Text(
              checkAccount.name!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ));
      });
    } else {
      return [];
    }
  }
}
