import 'package:flutter_bloc/flutter_bloc.dart';

class Themecubit  extends Cubit<bool>{
  Themecubit():super(false);
  void toggle(){
    emit(!state);
  }
}