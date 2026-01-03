import 'package:equatable/equatable.dart';
import 'package:news/features/sources/data/models/sources_response/source.dart';

sealed class SourcesStates extends Equatable {
  const SourcesStates();
  @override
  List<Object?> get props => [];
}

class SourcesInitial extends SourcesStates {
  @override
  List<Object?> get props => [];
}

class SourcesLoading extends SourcesStates {
  @override
  List<Object?> get props => [];
}

class SourcesSuccess extends SourcesStates {
  final List<Source> sources;
  const SourcesSuccess(this.sources);
  @override
  List<Object?> get props => [sources];
}

class SourcesError extends SourcesStates {
  final String message;
  const SourcesError(this.message);
  @override
  List<Object?> get props => [message];
}
