// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_page_cubit.dart';

class DetailPageState {
  final bool slideOpen;

  DetailPageState({required this.slideOpen});

  DetailPageState copyWith({
    bool? slideOpen,
  }) {
    return DetailPageState(
      slideOpen: slideOpen ?? this.slideOpen,
    );
  }
}
