import 'package:flutter/material.dart';
import 'package:news_app/model/user_model.dart';
import 'package:news_app/repository/auth/auth_repo.dart';
import 'package:news_app/repository/auth/auth_repo_impl.dart';
import 'package:news_app/utils/constants/app_constant.dart';
import 'package:news_app/utils/exceptions/firebase_auth_exception.dart';
import 'package:news_app/utils/widgets/custom_textfeild.dart';
import 'package:news_app/utils/widgets/snackbar.dart';
import 'package:news_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;
  const SignUpScreen({super.key, required this.toggleView});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late TextEditingController _usernamecontroller;
  bool isObscure = true;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernamecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor:
            AppConstant.greyColor, // const Color.fromARGB(255, 232, 240, 236),
        //backgroundColor: Colors.grey[300],
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
                    title: 'Username',
                    hintText: 'Enter your name',
                    icondata: Icons.person_outline,
                    textEditingController: _usernamecontroller,
                    validate: (name) {
                      if (name!.isEmpty || name.length < 5) {
                        return "Name should have atleast 5 Characters";
                      }
                      return null;
                    },
                    textInputType: TextInputType.name,
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
                    height: 200,
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: AppConstant.blueColor),
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();

                            AuthRepo firebaseAuthRepo = AuthRepoImpl();

                            await firebaseAuthRepo
                                .signUpUser(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((authresult) async {
                              if (authresult.status == AuthStatus.successful) {
                                print("its a success");

                                UserModel userModel = UserModel(
                                  name: _usernamecontroller.text,
                                  preference: [],
                                  country: 'in',
                                  email: _emailController.text,
                                  bookmarks: [],
                                );

                                await Provider.of<UserViewModel>(context,
                                        listen: false)
                                    .createUser(
                                  context: context,
                                  usermodel: userModel,
                                  uid: authresult.user!.uid,
                                );

                                if (context.mounted) {
                                  showSnackBar(context, 'Signup Successfull');
                                }
                              } else {
                                final error = FirebaseAuthExceptionHandler
                                    .generateErrorMessage(authresult.status);

                                showSnackBar(context, error);
                              }
                            });
                          }
                        },
                        child: Text(
                          "Signup",
                          style: AppConstant.descriptionMedium
                              .copyWith(color: AppConstant.whiteColor),
                        ));
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: AppConstant.descriptionMedium),
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
                          "Login",
                          style: AppConstant.descriptionBold
                              .copyWith(color: AppConstant.blueColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
