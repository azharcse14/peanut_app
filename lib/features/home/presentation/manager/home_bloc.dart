import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:peanut_app/core/error/failure.dart';
import 'package:peanut_app/features/home/domain/entities/open_trade_parent_entity.dart';
import 'package:peanut_app/features/home/domain/entities/open_trades_entity.dart';
import 'package:peanut_app/features/home/domain/use_cases/home_usecase.dart';

import 'package:collection/collection.dart';



part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final HomeUseCase homeUseCase;

  OpenTradeParentEntity? _openTradesEntity;
  OpenTradeParentEntity? get openTradesEntity => _openTradesEntity;

  HomeBloc( {
    required this.homeUseCase,
  }) : super(HomeInitial()) {

    on<GetOpenTradesList>((event, emit) async {
      emit(HomeLoading());
      Either<Failure, OpenTradeParentEntity> result = await homeUseCase();
      result.fold((l) => emit(HomeError(error: l.message)), (r) {
        _openTradesEntity = r;
        if(r.message==''){
          var total = 0.0;
          List<double> profit = [];
          for(OpenTradesEntity item in r.data!){
            profit.add(item.profit);
            total = profit.sum;
          }
          emit(HomeSuccess(openTradesEntity: r.data!, totalProfit: total));
        }else{
          emit(const HomeAccessDenied());
        }

      });
    });

  }
}
