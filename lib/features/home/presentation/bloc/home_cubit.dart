import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeData _getHomeData;

  HomeCubit({
    required GetHomeData getHomeData,
  })  : _getHomeData = getHomeData,
        super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());

    final res = await _getHomeData(const NoParams());

    res.fold(
      (failure) => emit(HomeError(failure.message)),
      (homeData) => emit(
        HomeLoaded(
          banners: homeData.banners,
          categories: homeData.categories,
          popularProducts: homeData.popularProducts,
          specialProducts: homeData.specialProducts,
          newProducts: homeData.newProducts,
          popularCategory: homeData.popularCategory,
          specialCategory: homeData.specialCategory,
          newArrivalCategory: homeData.newArrivalCategory,
        ),
      ),
    );
  }
}
