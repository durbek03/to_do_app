import 'package:bloc/bloc.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit() : super(DetailPageState(slideOpen: false));

  openSlide() {
    emit(state.copyWith(slideOpen: true));
  }
  closeSlide() {
    emit(state.copyWith(slideOpen: false));
  }
}
