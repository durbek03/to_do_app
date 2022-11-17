import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class HomePageCubit extends Cubit<List<String>> {
  final List<String> list;
  HomePageCubit(this.list) : super(list);

  deleteItemAt(String index) {
    emit(List.from(list..removeWhere((element) => element == index)));
  }
}
