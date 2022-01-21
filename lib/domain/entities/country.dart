import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
