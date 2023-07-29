import 'package:flutter/material.dart';
import 'package:peanut_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:peanut_app/features/home/presentation/screens/landing_screen.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';
import 'package:peanut_app/core/di.dart';
import 'package:peanut_app/core/helpers/feedback_helper.dart';
import 'package:peanut_app/core/helpers/navigation_helper.dart';
import 'package:peanut_app/core/helpers/validator_logic.dart';
import 'package:peanut_app/core/presentation/widgets/forms/form_field_wrapper.dart';
import 'package:peanut_app/core/presentation/widgets/forms/k_password_text_field.dart';
import 'package:peanut_app/core/presentation/widgets/forms/k_text_field.dart';
import 'package:peanut_app/core/presentation/widgets/k_button_full_width.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peanut_app/core/shared_prefs/shared_prefs.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final authBloc = injector<AuthBloc>();

  @override
  void dispose() {
    super.dispose();
    userIdController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              FeedBackHelper.showSnackBar(
                context: context,
                title: state.error,
                type: FeedbackType.error,
              );
            } else {}
            if (state is LoginSuccess) {
              if (state.loginEntity.result == false) {
                FeedBackHelper.showSnackBar(
                  context: context,
                  title: 'Error',
                  type: FeedbackType.error,
                );
              } else {
                injector<SharedPreferencesUtils>()
                    .saveLogin(userIdController.text.toString());
                injector<SharedPreferencesUtils>()
                    .saveToken(state.loginEntity.token);

                FeedBackHelper.showSnackBar(
                  context: context,
                  title: 'Login Success!',
                  type: FeedbackType.success,
                );
                Nav.pushAndRemoveUntil(context, const LandingScreen());
              }
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/auth_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/logo.png'),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontFamily: AppConstants.fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                FormFieldWrapper(
                                  label: 'User Id',
                                  child: KTextField(
                                    controller: userIdController,
                                    hintText: 'User Id',
                                    inputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (text) =>
                                        ValidatorLogic.requiredField(text,
                                            fieldName: 'User Id'),
                                  ),
                                ),
                                const SizedBox(
                                    height: AppConstants.defaultVerticalGap),
                                FormFieldWrapper(
                                    label: 'Password',
                                    child: KPasswordTextField(
                                      controller: passwordController,
                                      hintText: 'Password',
                                      validator: (text) =>
                                          ValidatorLogic.requiredPassword(text),
                                    )),
                                const SizedBox(height: 20),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return KButtonFullWidth(
                                        title: 'Log In',
                                        isLoading: state is AuthLoading,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (state is AuthLoading) {
                                              return;
                                            } else {
                                              authBloc.add(Login(
                                                userId: int.parse(
                                                    userIdController.text),
                                                password:
                                                    passwordController.text,
                                              ));
                                            }
                                          }
                                        });
                                  },
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
