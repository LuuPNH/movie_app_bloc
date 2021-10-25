import 'package:movie_app_bloc/model/person/person.dart';
import 'package:movie_app_bloc/person/person_event.dart';
import 'package:movie_app_bloc/person/person_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PersonBloc extends BaseBloc<PersonState> {
  PersonBloc() : super(PersonState(isLoading: true));

  MovieRepository movieRepository = MovieRepository();

  @override
  Stream<PersonState> mapEventToState(BaseEvent event) async* {
    if (event is PersonEvent) {
      var list = await movieRepository.getPersons(state.page);
      yield state.copyWith(list: list, page: state.page + 1);
    }
    if (event is PersonMoreEvent) {
      List<Person>? li;
      if (state.list?.isNotEmpty == true) {
        List<Person>? _list = await movieRepository.getPersons(state.page);
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li, page: state.page + 1);
      }
    }
  }
}
