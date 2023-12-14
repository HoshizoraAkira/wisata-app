import 'package:flutter/material.dart';
import 'package:wisata_app/common/constants.dart';
import 'package:wisata_app/helper/keyboard.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/screens/main_layout/dashboard_screen.dart';
import 'package:wisata_app/common/size_config.dart';
import 'package:wisata_app/services/auth_services.dart';
import 'package:wisata_app/widgets/custom_snackbar.dart';
import 'package:wisata_app/widgets/custom_suffix_icon.dart';
import 'package:wisata_app/widgets/default_button.dart';
import 'package:wisata_app/widgets/form_error.dart';
import 'package:wisata_app/widgets/social_media_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Future<void> checkIsLogin(BuildContext context) async {
  await SessionManager().isLogin(context);
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;
  String _error = '';
  final List<String?> errors = [];
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void initState() {
    super.initState();
    checkIsLogin(context);
  }

  Future<void> _login() async {
    try {
      final user = await AuthService().login(username!, password!);
      if (user.values.first) {
        setState(() {
          _error = '';
        });

        // Simpan data pengguna ke SharedPreferences
        final prefs = await SessionManager.getInstance();
        await prefs.saveUserData(username!);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const DashboardScreen();
        }));
      } else {
        setState(() {
          _error = 'Wrong Username or Password';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _error = 'Login Failed';
      });
    }

    if (_error.isNotEmpty) {
      CustomSnackbar.show(
        scaffoldMessengerKey.currentState!,
        _error,
        SnackbarType.error,
      );
      setState(() {
        _error = '';
      });
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Sign In"),
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Sign in with your username and password  \nor continue with social media",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildUsernameField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildPasswordFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Row(
                              children: [
                                Checkbox(
                                  value: remember,
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      remember = value;
                                    });
                                  },
                                ),
                                const Text("Remember me"),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            FormError(errors: errors),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            DefaultButton(
                              text: "Login",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  _login();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return const DashboardScreen();
                                  //   }),
                                  // );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaCard(
                            icon: "assets/icons/google-icon.svg",
                            press: () {},
                          ),
                          SocialMediaCard(
                            icon: "assets/icons/facebook-2.svg",
                            press: () {},
                          ),
                          SocialMediaCard(
                            icon: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account? ",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => username = newValue,
      decoration: const InputDecoration(
        labelText: "Username",
        hintText: "Enter your username  ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
