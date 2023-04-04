import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/settings/settings_view.dart';
import '../../../../image/image_constatns.dart';
import '../../../_utility/keyboard/button_type_enum.dart';
import '../../../_utility/keyboard/keyboard_custom_button.dart';
import '../../../_utility/keyboard/numeric_keyboard.dart';
import '../viewmodel/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(ImageConstants.instance.ideaslogo),
                    ),
                    const Spacer(),
                    const Spacer(),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => const SettingsPage(),
                          );
                          loginController.openSettingsPage();
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Ayarlar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(ImageConstants.instance.user),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            enabled: true,
                            autofocus: true,
                            onFieldSubmitted: (_) {
                              loginController.loginTerminal();
                            },
                            controller: loginController.pinFieldController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: 'Şifrenizi giriniz',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 400,
                            child: NumericKeyboard(
                              type: KeyboardType.INT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              actionColumn: buildActionColumn(loginController),
                              pinFieldController:
                                  loginController.pinFieldController,
                              buttonColor: Colors.white,
                              callback: () {
                                loginController.loginTerminal();
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUsernameField(
      bool showEmail, BuildContext context, LoginController loginController) {
    return showEmail
        ? SizedBox(
            width: context.width * 30 / 100,
            child: TextFormField(
              controller: loginController.emailController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Email",
                border: const OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.email,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          )
        : Container();
  }

  Widget buildLogo(bool isSaved) {
    return Center(child: Image.asset(ImageConstants.instance.user));
  }

  Widget buildActionColumn(LoginController loginController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: KeyboardCustomButton(
            buttonColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: const Icon(
              Icons.check,
              size: 50,
            ),
            onPressed: () {
              loginController.loginTerminal();
            },
          ),
        ),
      ],
    );
  }
}
