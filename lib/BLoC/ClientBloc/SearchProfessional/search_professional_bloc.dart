import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class SearchProfessionalBloc extends Bloc<SearchProfessionalEvent, SearchProfessionalState> {
  @override
  SearchProfessionalState get initialState => InitialSearchProfessionalState();

  @override
  Stream<SearchProfessionalState> mapEventToState(
    SearchProfessionalEvent event,
  ) async* {




    // TODO: Add Logic
  }
}
