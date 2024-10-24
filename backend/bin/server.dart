import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'package:shelf_router/shelf_router.dart';

import '../lib/repository/user_repository.dart';

void main() async {
  final router = Router();

  // Definindo rotas
  router.get('/users', (Request req) async {
    final users = await UserRepository().getAllUsers();
    return Response.ok(users);
  });

  // Inicializa o servidor
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);
  final server = await serve(handler, InternetAddress.anyIPv4, 8080);

  print('Server started on port ${server.port}');
}
