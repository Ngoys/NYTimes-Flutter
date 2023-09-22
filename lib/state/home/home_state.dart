import 'package:equatable/equatable.dart';
import 'package:nytimes/modal/home_menu_section.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => <Object?>[];
}

class UnknownHomeState extends HomeState {
  const UnknownHomeState();
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState(this.sections);

  final List<HomeMenuSection> sections;

  @override
  List<Object> get props => <Object>[sections];
}

class HomeIsLoadingState extends HomeState {
  const HomeIsLoadingState();
}
