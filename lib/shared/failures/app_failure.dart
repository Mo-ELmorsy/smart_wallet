abstract class AppFailure {
  final String message;
  
  const AppFailure(this.message);
}

class ServerFailure extends AppFailure {
  const ServerFailure([super.message = 'A server error occurred.']);
}

class CacheFailure extends AppFailure {
  const CacheFailure([super.message = 'A cache error occurred.']);
}

class ValidationFailure extends AppFailure {
  const ValidationFailure([super.message = 'Invalid input provided.']);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure([super.message = 'An unknown error occurred.']);
}
