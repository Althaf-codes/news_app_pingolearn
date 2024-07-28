import 'package:flutter/material.dart';
import 'package:news_app/repository/auth/auth_repo.dart';
import 'package:news_app/repository/auth/auth_repo_impl.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/utils/exceptions/firebase_auth_exception.dart';
import 'package:news_app/utils/widgets/custom_textfeild.dart';
import 'package:news_app/utils/widgets/snackbar.dart';
import 'package:news_app/view_model/auth_view_model.dart';
import 'package:news_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  final Function toggleView;
  const SigninScreen({super.key, required this.toggleView});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController _emailController;

  late TextEditingController _passwordController;
  final formGlobalKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: AppConstant.greyColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "MyNews",
                        style: AppConstant.headlineBlack.copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  customTextFeild(
                      title: 'Email',
                      hintText: 'Enter your Email',
                      icondata: Icons.email_outlined,
                      textEditingController: _emailController,
                      validate: (email) {
                        if (email!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                            .hasMatch(email)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress),

                  customTextFeild(
                      title: 'Password',
                      hintText: 'Enter your password',
                      icondata: Icons.lock_outline,
                      textEditingController: _passwordController,
                      isPassword: true,
                      isObscure: isObscure,
                      obscureOntap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      validate: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return 'Password should have min 6 characters ';
                        }
                        return null;
                      },
                      textInputType: TextInputType.visiblePassword),

                  const SizedBox(
                    height: 20,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          if (_emailController.text.isEmpty) {
                            showSnackBar(context, "Please enter your email");
                          } else {
                            await Provider.of<AuthViewModel>(context,
                                    listen: false)
                                .resetPassword(
                                    email: _emailController.text.trim(),
                                    context: context);
                          }
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppConstant.descriptionMedium
                              .copyWith(color: AppConstant.blueColor),
                        )),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Consumer<AuthViewModel>(builder: (context, value, child) {
                    return Builder(builder: (context) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: AppConstant.blueColor),
                          onPressed: () async {
                            if (!value.isLoading) {
                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                print('Everything is okay');
                                AuthRepo firebaseAuthRepo = AuthRepoImpl();

                                await firebaseAuthRepo
                                    .signInWithEmailPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((authResult) async {
                                  if (authResult.status ==
                                      AuthStatus.successful) {
                                    await Provider.of<UserViewModel>(context,
                                            listen: false)
                                        .getUser(
                                            uid: authResult.user!.uid,
                                            context: context);
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      // if (context.mounted) {
                                      showSnackBar(
                                          context, 'Signin Successfull');
                                      // }
                                    });
                                  } else {
                                    final error = FirebaseAuthExceptionHandler
                                        .generateErrorMessage(
                                            authResult.status);

                                    showErrorSnackBar(context, error);
                                  }
                                });
                              }
                            }
                          },
                          child: value.isLoading
                              ? const CircularProgressIndicator.adaptive(
                                  backgroundColor: AppConstant.whiteColor,
                                )
                              : Text(
                                  "Login",
                                  style: AppConstant.descriptionMedium
                                      .copyWith(color: AppConstant.whiteColor),
                                ));
                    });
                  }),

                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New here?", style: AppConstant.descriptionMedium),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          widget.toggleView();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          "Signup",
                          style: AppConstant.descriptionBold
                              .copyWith(color: AppConstant.blueColor),
                        ),
                      )
                    ],
                  )

                  // TextField(
                  //   controller: passwordcontroller,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
