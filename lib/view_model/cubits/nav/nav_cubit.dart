import 'package:final_project/view_model/cubits/product/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  static NavCubit get(context) => BlocProvider.of<NavCubit>(context);
  int currentIndex = 0;

  void selectTab(int index) {
    if (currentIndex == index) return;
    emit(index);
    currentIndex = index;
  }


}
