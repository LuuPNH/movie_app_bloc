import 'package:movie_app_bloc/model/person/person.dart';

class PersonResponse {
  final List<Person> persons;

  PersonResponse(this.persons);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons = (json["results"] as List)
            .map((i) => new Person.fromJson(i))
            .toList();
}
