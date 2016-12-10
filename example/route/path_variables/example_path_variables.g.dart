// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.routes;

// **************************************************************************
// Generator: ApiGenerator
// Target: class BooksApi
// **************************************************************************

abstract class _$JaguarBooksApi implements RequestHandler {
  static const List<RouteBase> routes = const <RouteBase>[
    const Get(path: '/book/:id'),
    const Post(path: '/book/:book/:author')
  ];

  String getBookById(String id);

  void createBook(String book, String author);

  Future<bool> handleRequest(HttpRequest request, {String prefix: ''}) async {
    prefix += '/api';
    PathParams pathParams = new PathParams();
    bool match = false;

//Handler for getBookById
    match =
        routes[0].match(request.uri.path, request.method, prefix, pathParams);
    if (match) {
      Response rRouteResponse = new Response(null);
      rRouteResponse.statusCode = 200;
      rRouteResponse.value = getBookById(
        (pathParams.getField('id')),
      );
      await rRouteResponse.writeResponse(request.response);
      return true;
    }

//Handler for createBook
    match =
        routes[1].match(request.uri.path, request.method, prefix, pathParams);
    if (match) {
      Response rRouteResponse = new Response(null);
      createBook(
        (pathParams.getField('book')),
        (pathParams.getField('author')),
      );
      await rRouteResponse.writeResponse(request.response);
      return true;
    }

    return false;
  }
}
