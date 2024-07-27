import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSwitchCubit extends Cubit<bool> {
  FavoriteSwitchCubit(super.initialState);

  void toggleFavorite() => emit(!state);

}
