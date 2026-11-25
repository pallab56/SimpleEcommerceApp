import 'package:flutter_bloc/flutter_bloc.dart';

/// Tracks the selected bottom-navigation tab index.
/// Used in [MainBottomNavPage] to avoid setState.
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void setTab(int index) => emit(index);
}
