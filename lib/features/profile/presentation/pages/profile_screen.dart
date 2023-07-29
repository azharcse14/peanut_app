import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peanut_app/core/di.dart';
import 'package:peanut_app/core/helpers/widget_helper.dart';

import '../../../../core/helpers/feedback_helper.dart';
import '../../../../core/helpers/navigation_helper.dart';
import '../../../../core/presentation/screens/base_screen.dart';
import '../../../../core/presentation/widgets/nothing_found.dart';
import '../../../../core/presentation/widgets/profile_item.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../manager/account_information/account_information_bloc.dart';
import '../manager/phone_number/phone_number_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getAccountInformationBloc = injector<AccountInformationBloc>();
    final getPhoneNumberBloc = injector<PhoneNumberBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getAccountInformationBloc
            ..add(
              const GetAccountInformation(),
            ),
        ),
        BlocProvider.value(
            value: getPhoneNumberBloc..add(const GetPhoneNumber())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: customText( text: 'Profile', fontSize: 18, fontWeight: FontWeight.normal,),
          actions: [
            InkWell(
              onTap: (){
                showAlertDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: SvgPicture.asset(
                  'assets/icons/logout.svg',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BaseScreen(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Card(
                  child: BlocBuilder<AccountInformationBloc,
                      AccountInformationState>(
                    builder: (context, state) {
                      if (state is AccountInformationLoading) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: double.maxFinite,
                            child: const Center(child: CircularProgressIndicator()));
                      } else if (state is AccountInformationAccessDenied) {
                        injector<SharedPreferencesUtils>().removeToken();
                        injector<SharedPreferencesUtils>().removeLogin();
                        FeedBackHelper.showSnackBar(
                          context: context,
                          title: 'Your Access Denied!',
                          type: FeedbackType.error,
                        );
                        return Nav.pushAndRemoveUntilWithRootNavigator(
                          context,
                          const SignInScreen(),
                        );
                      } else if (state is AccountInformationError) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Center(
                            child: Text(state.error),
                          ),
                        );
                      } else if (state is AccountInformationSuccess) {
                        return state.accountInformationEntity == null
                            ? const NothingFound()
                            : profileItemColumn(state, context);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column profileItemColumn(
      AccountInformationSuccess state, BuildContext context) {
    return Column(
      children: [
        columnItem('Name', state.accountInformationEntity.name),
        columnItem('Address', state.accountInformationEntity.address),
        columnItem('City', state.accountInformationEntity.city),
        columnItem('Country', state.accountInformationEntity.country),
        columnItem('Zip Code', state.accountInformationEntity.zipCode),
        columnItem('Phone', state.accountInformationEntity.phone),
        columnItem(
            'Currency', state.accountInformationEntity.currency.toString()),
        columnItem(
            'Balance', state.accountInformationEntity.balance.toString()),
        columnItem('Current Trades Count',
            state.accountInformationEntity.currentTradesCount.toString()),
        columnItem('Current Trades Volume',
            state.accountInformationEntity.currentTradesVolume.toString()),
        columnItem('Equity', state.accountInformationEntity.equity.toString()),
        columnItem('Free Margin',
            state.accountInformationEntity.freeMargin.toString()),
        columnItem(
            'Leverage', state.accountInformationEntity.leverage.toString()),
        columnItem('Verification Level',
            state.accountInformationEntity.verificationLevel.toString()),
        columnItem('Type', state.accountInformationEntity.type.toString()),
        columnItem('Total Trades Count',
            state.accountInformationEntity.totalTradesCount.toString()),
        columnItem('Total Trades Volume',
            state.accountInformationEntity.totalTradesVolume.toString()),
        BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
          builder: (context, state) {
            if (state is PhoneNumberLoading) {
              return const SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is PhoneNumberError) {
              return SizedBox(
                child: Center(
                  child: Text(state.error),
                ),
              );
            } else if (state is PhoneNumberSuccess) {
              return state.lastFourNumber.isEmpty
                  ? const NothingFound()
                  : columnItem('Last Four Number', state.lastFourNumber);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        addH(20),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: customText( text: 'Yes', fontSize: 20, fontWeight: FontWeight.bold,),
      onPressed:  () {
        injector<SharedPreferencesUtils>().removeToken();
        injector<SharedPreferencesUtils>().removeLogin();
        FeedBackHelper.showSnackBar(
          context: context,
          title: 'Your Access Denied!',
          type: FeedbackType.error,
        );
        Nav.pushAndRemoveUntilWithRootNavigator(
          context,
          const SignInScreen(),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: customText( text: 'Logout...', fontSize: 20, fontWeight: FontWeight.bold,),
      content: customText( text: 'Are you sure, do you want to logout?', fontSize: 14, fontWeight: FontWeight.bold,),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
