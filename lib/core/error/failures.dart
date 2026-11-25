// ServerFailure, CacheFailure — returned from repository methods via Either.
class Failure {
  final String message;

  const Failure([this.message = 'An unexpected error occurred.']);
}
