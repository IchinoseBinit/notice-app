import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/components/auth_template.dart';
import '/components/password_field.dart';
import '/constants/storage_constants.dart';
import '/constants/urls.dart';
import '/utils/dio_client.dart';
import '/utils/error_handler.dart';
import '/utils/fetch_content.dart';
import '/utils/preferences_helper.dart';
import '/utils/request_type.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/custom_loading_indicator.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    if (kDebugMode) {
      usernameController.text = "merin@admin.com";
      passwordController.text = "admin";
    }
    return WillPopScope(
      onWillPop: () async {
        // return navigateAndRemoveAll(context, WelcomeScreen());
        return Future.value(true);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: SafeArea(
            child: BodyTemplate(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthTemplate(
                      title: "Sign In",
                      description: "Please enter your details",
                    ),
                    GeneralTextField(
                      labelText: "Username",
                      controller: usernameController,
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      validate: (val) =>
                          ValidationMixin().validate(val, title: "Username"),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    PasswordField(
                      controller: passwordController,
                    ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       // navigate(context, ForgetPasswordScreen());
                    //     },
                    //     child: Text(
                    //       "Forgot password?",
                    //       style: Theme.of(context).textTheme.bodyText1,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GeneralElevatedButton(
                      title: "Sign In",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            onLoading(context);
                            final resp = await DioClient().request(
                              requestType: RequestType.post,
                              url: ApiEndpoints.loginUrl,
                              body: {
                                "username": usernameController.text,
                                "password": passwordController.text,
                              },
                            );
                            DioClient.token = resp.data["token"];
                            PreferencesHelper.write(
                              key: StorageConstants.tokenKey,
                              value: resp.data["token"],
                            );
                            await FetchContent()
                                .fetchAllContent(context, isFromLogin: true);
                          } catch (ex) {
                            rethrow;
                            ErrorHandler().errorHandler(context, ex);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigate(context, const RegisterScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
