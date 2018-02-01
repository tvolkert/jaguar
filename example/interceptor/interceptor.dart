library example.routes;

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:jaguar/jaguar.dart';

part 'interceptor.g.dart';

final Random rand = new Random.secure();

class GenRandom extends FullInterceptor<int, dynamic, dynamic> {
  int output;

  before(Context ctx) {
    print("Executes before request handler!");
    output = rand.nextInt(1000);
    ctx.addInterceptor(GenRandom, id, this);
  }

  after(Context ctx, Response incoming) {
    print("Executes after request handler!");
  }
}

class UsesRandom extends Interceptor {
  dynamic output;

  /// [HttpRequest] object of the current request is automatically provided when
  /// first argument of interceptor method is [HttpRequest]
  before(Context ctx) {
    print("Executes before request handler on path: ${ctx.req.uri}!");
  }

  /// [HttpRequest] object of the current request is automatically provided when
  /// first argument of interceptor method is [HttpRequest]
  after(Context ctx, Response incoming) {
    print("Executes after request handler on path: ${ctx.req.uri}!");
  }
}

@Api(path: '/api/book')
class BooksApi extends _$JaguarBooksApi {
  static GenRandom genRandom(Context ctx) => new GenRandom();

  static UsesRandom usesRandom(Context ctx) => new UsesRandom();

  /// TODO add documentation
  @Get()
  @Wrap(const [genRandom, usesRandom])
  Response<String> getJaguarInfo(Context ctx) => Response.json({
        'Name': 'Jaguar',
        'Features': ['Speed', 'Simplicity', 'Extensiblity'],
      });
}

Future<Null> main(List<String> args) async {
  Jaguar jaguar = new Jaguar();
  jaguar.addApi(new BooksApi());

  await jaguar.serve();
}
