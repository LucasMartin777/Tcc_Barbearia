import 'package:barbearia_tcc/src/core/restClient/rest_clent.dart';
import 'package:barbearia_tcc/src/repositories/user/user_repository.dart';
import 'package:barbearia_tcc/src/repositories/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();
@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));
