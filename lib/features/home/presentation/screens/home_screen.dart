import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peanut_app/core/di.dart';
import 'package:peanut_app/core/presentation/screens/base_screen.dart';
import 'package:peanut_app/core/presentation/widgets/nothing_found.dart';
import 'package:peanut_app/features/home/presentation/widgets/job_skeleton.dart';

import '../../../../core/helpers/feedback_helper.dart';
import '../../../../core/helpers/navigation_helper.dart';
import '../../../../core/helpers/widget_helper.dart';
import '../../../../core/presentation/widgets/profile_item.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

import '../manager/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final getHomeBloc = injector<HomeBloc>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getHomeBloc..add(const GetOpenTradesList()),
      child: Scaffold(
        appBar: AppBar(
            title: customText(
                text: 'Home', fontSize: 20, fontWeight: FontWeight.normal),
            actions: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Center(
                        child: Text(state.error),
                      ),
                    );
                  } else if (state is HomeAccessDenied) {
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
                  } else if (state is HomeSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText(
                          text: 'Total Profit: ',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        customText(
                          text: state.totalProfit != null
                              ? state.totalProfit.toStringAsFixed(2) + ' '
                              : '0.0',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ]),
        body: BaseScreen(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const JobSkeleton();
              } else if (state is HomeError) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              } else if (state is HomeAccessDenied) {
                injector<SharedPreferencesUtils>().removeToken();
                injector<SharedPreferencesUtils>().removeLogin();
                return Nav.pushAndRemoveUntilWithRootNavigator(
                  context,
                  const SignInScreen(),
                );
              } else if (state is HomeSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    getHomeBloc.add(const GetOpenTradesList());
                  },
                  child: ListView.builder(
                      itemCount: state.openTradesEntity.isEmpty
                          ? 1
                          : state.openTradesEntity.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 50),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return state.openTradesEntity.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: const NothingFound())
                            : openTradeChild(state, index);
                      }),
                );
              } else {
                return const JobSkeleton();
              }
            },
          ),
        ),

        // bottomSheet: BlocBuilder<HomeBloc, HomeState>(
        //   builder: (context, state) {
        //     if (state is HomeLoading) {
        //       return const JobSkeleton();
        //     } else if (state is HomeError) {
        //       return SizedBox(
        //         height: MediaQuery.of(context).size.height * 0.25,
        //         child: Center(
        //           child: Text(state.error),
        //         ),
        //       );
        //     } else if(state is HomeAccessDenied){
        //       // injector<SharedPreferencesUtils>().removeToken();
        //       return Nav.pushAndRemoveUntilWithRootNavigator(
        //         context,
        //         const SignInScreen(),
        //       );
        //     }
        //
        //     else if (state is HomeSuccess) {
        //       return Container(
        //         decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(5.0),
        //             topLeft: Radius.circular(5.0),),
        //         ),
        //         padding: const EdgeInsets.all(20.0),
        //         height: 70,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             customText(text: 'Total Profit:', fontSize: 20, fontWeight: FontWeight.normal,),
        //             customText(text: state.totalProfit !=null? state.totalProfit.toStringAsFixed(3):'0.0', fontSize: 20, fontWeight: FontWeight.bold,),
        //           ],
        //         ),
        //       );
        //     } else {
        //       return const SizedBox();
        //     }
        //   },
        // ),
      ),
    );
  }

  Padding openTradeChild(HomeSuccess state, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            columnItem(
                'Ticket', state.openTradesEntity[index].ticket.toString()),
            columnItem(
                'Volume', state.openTradesEntity[index].volume.toString()),
            columnItem(
                'Symbol', state.openTradesEntity[index].symbol.toString()),
            columnItem('Current Price',
                state.openTradesEntity[index].currentPrice.toString()),
            columnItem('Open Price',
                state.openTradesEntity[index].openPrice.toString()),
            columnItem(
                'Profit', state.openTradesEntity[index].profit.toString()),
          ],
        ),
      ),
    );
  }
}
