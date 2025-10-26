import 'package:meta/meta.dart';

typedef Deserializer<T> = T Function(dynamic);
typedef Serializer<T> = String Function(T);

class QueryResult<TData, TVars> {
  final TData? data;
  final TVars? vars;
  QueryResult({this.data, this.vars});
}

class QueryRef<TData, TVars> {
  final Future<QueryResult<TData, TVars>> Function() _execute;
  QueryRef(this._execute);
  Future<QueryResult<TData, TVars>> execute() => _execute();
}

class OperationResult<TData, TVars> {
  final TData? data;
  final TVars? vars;
  OperationResult({this.data, this.vars});
}

class MutationRef<TData, TVars> {
  final Future<OperationResult<TData, TVars>> Function() _execute;
  MutationRef(this._execute);
  Future<OperationResult<TData, TVars>> execute() => _execute();
}

class FirebaseDataConnect {
  MutationRef<TData, TVars> mutation<TData, TVars>(
    String name,
    Deserializer<TData> dataDeserializer,
    Serializer<TVars> varsSerializer,
    TVars vars,
  ) {
    // Placeholder implementation; replace with real network/mutation logic.
    return MutationRef<TData, TVars>(() async {
      return OperationResult<TData, TVars>(data: null, vars: vars);
    });
  }

  QueryRef<TData, TVars> query<TData, TVars>(
    String name,
    Deserializer<TData> dataDeserializer,
    Serializer<TVars> varsSerializer,
    TVars vars,
  ) {
    // Placeholder implementation; replace with real network/query logic.
    return QueryRef<TData, TVars>(() async {
      return QueryResult<TData, TVars>(data: null, vars: vars);
    });
  }
}

T nativeFromJson<T>(dynamic value) => value as T;
dynamic nativeToJson<T>(T value) => value;
String emptySerializer(dynamic v) => '';

class ListMoviesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMoviesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMoviesData> dataDeserializer = (dynamic json)  => ListMoviesData.fromJson(json);
  
  Future<QueryResult<ListMoviesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMoviesData, void> ref() {
    
    return _dataConnect.query("ListMovies", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMoviesMovies {
  final String id;
  final String title;
  final String imageUrl;
  final String? genre;
  ListMoviesMovies.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  imageUrl = nativeFromJson<String>(json['imageUrl']),
  genre = json['genre'] == null ? null : nativeFromJson<String>(json['genre']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMoviesMovies otherTyped = other as ListMoviesMovies;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    imageUrl == otherTyped.imageUrl && 
    genre == otherTyped.genre;
    
  }
  @override
  int get hashCode => Object.hash(id.hashCode, title.hashCode, imageUrl.hashCode, genre.hashCode);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    if (genre != null) {
      json['genre'] = nativeToJson<String?>(genre);
    }
    return json;
  }

  const ListMoviesMovies({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.genre,
  });
}

@immutable
class ListMoviesData {
  final List<ListMoviesMovies> movies;
  ListMoviesData.fromJson(dynamic json):
  
  movies = (json['movies'] as List<dynamic>)
        .map((e) => ListMoviesMovies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMoviesData otherTyped = other as ListMoviesData;
    return movies == otherTyped.movies;
    
  }
  @override
  int get hashCode => movies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movies'] = movies.map((e) => e.toJson()).toList();
    return json;
  }

  const ListMoviesData({
    required this.movies,
  });
}
