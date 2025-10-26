/// Minimal shims to satisfy the generated code expectations.
/// If your project already provides these types, remove or adapt these shims.

import 'dart:convert';
import 'package:meta/meta.dart';

typedef Deserializer<T> = T Function(dynamic json);
typedef Serializer<V> = String Function(V);

/// Minimal helpers used by generated code. Replace with your real implementations if you have them.
T nativeFromJson<T>(dynamic json) => json as T;
dynamic nativeToJson<T>(T? value) => value;

/// Minimal FirebaseDataConnect stub so this file can compile standalone; remove if your project defines it.
class FirebaseDataConnect {}

enum OptionalState { unset, set }

class Optional<T> {
  T? _value;
  bool _isSet = false;
  final dynamic _fromJson;
  final dynamic _toJson;
  Optional._(this._fromJson, this._toJson);
  static Optional<T> optional<T>(dynamic fromJson, dynamic toJson) => Optional._(fromJson, toJson);
  set value(T? v) {
    _isSet = true;
    _value = v;
  }
  T? get value => _value;
  OptionalState get state => _isSet ? OptionalState.set : OptionalState.unset;
  dynamic toJson() => _toJson != null ? _toJson(_value) : _value;
  @override
  bool operator ==(Object other) => other is Optional<T> && other._isSet == _isSet && other._value == _value;
  @override
  int get hashCode => Object.hash(_isSet, _value);
}

class QueryResult<T, V> {
  final bool success;
  final T? data;
  final Object? error;
  QueryResult({required this.success, this.data, this.error});
}

class QueryRef<T, V> {
  final String name;
  final Deserializer<T> deserializer;
  final Serializer<V> serializer;
  final V variables;
  QueryRef(this.name, this.deserializer, this.serializer, this.variables);
  Future<QueryResult<T, V>> execute() async {
    // Placeholder implementation; replace with real backend call if available.
    return QueryResult<T, V>(success: true, data: null);
  }
}

// Add query extension so generated code can call `.query(...)` on FirebaseDataConnect.
// If your project already exposes such a method, the extension will be ignored.
extension FirebaseDataConnectQueryExt on FirebaseDataConnect {
  QueryRef<T, V> query<T, V>(String name, Deserializer<T> deserializer, Serializer<V> serializer, V vars) {
    return QueryRef<T, V>(name, deserializer, serializer, vars);
  }
}

class SearchMovieVariablesBuilder {
  final Optional<String> _titleInput = Optional.optional(nativeFromJson, nativeToJson);
  final Optional<String> _genre = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  SearchMovieVariablesBuilder titleInput(String? t) {
   _titleInput.value = t;
   return this;
  }
  SearchMovieVariablesBuilder genre(String? t) {
   _genre.value = t;
   return this;
  }

  SearchMovieVariablesBuilder(this._dataConnect, );
  Deserializer<SearchMovieData> dataDeserializer = (dynamic json)  => SearchMovieData.fromJson(jsonDecode(json));
  Serializer<SearchMovieVariables> varsSerializer = (SearchMovieVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<SearchMovieData, SearchMovieVariables>> execute() {
    return ref().execute();
  }

  QueryRef<SearchMovieData, SearchMovieVariables> ref() {
    SearchMovieVariables vars= SearchMovieVariables(titleInput: _titleInput,genre: _genre,);
    return _dataConnect.query("SearchMovie", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class SearchMovieMovies {
  final String id;
  final String title;
  final String? genre;
  final String imageUrl;
  SearchMovieMovies.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']),
  genre = json['genre'] == null ? null : nativeFromJson<String>(json['genre']),
  imageUrl = nativeFromJson<String>(json['imageUrl']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SearchMovieMovies otherTyped = other as SearchMovieMovies;
    return id == otherTyped.id && 
    title == otherTyped.title && 
    genre == otherTyped.genre && 
    imageUrl == otherTyped.imageUrl;
    
  }
@override
int get hashCode => Object.hash(id.hashCode, title.hashCode, genre.hashCode, imageUrl.hashCode);

Map<String, dynamic> toJson() {
  Map<String, dynamic> json = {};
  json['id'] = nativeToJson<String>(id);
  json['title'] = nativeToJson<String>(title);
  if (genre != null) {
    json['genre'] = nativeToJson<String>(genre!);
  }
  json['imageUrl'] = nativeToJson<String>(imageUrl);
  return json;
}

const SearchMovieMovies({
    required this.id,
    required this.title,
    this.genre,
    required this.imageUrl,
  });
}

@immutable
class SearchMovieData {
  final List<SearchMovieMovies> movies;
  SearchMovieData.fromJson(dynamic json):
  
  movies = (json['movies'] as List<dynamic>)
        .map((e) => SearchMovieMovies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SearchMovieData otherTyped = other as SearchMovieData;
    return movies == otherTyped.movies;
    
  }
  @override
  int get hashCode => movies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movies'] = movies.map((e) => e.toJson()).toList();
    return json;
  }

  const SearchMovieData({
    required this.movies,
  });
}

@immutable
class SearchMovieVariables {
  late final Optional<String> titleInput;
  late final Optional<String> genre;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  SearchMovieVariables.fromJson(Map<String, dynamic> json) {
  
  
    titleInput = Optional.optional(nativeFromJson, nativeToJson);
    titleInput.value = json['titleInput'] == null ? null : nativeFromJson<String>(json['titleInput']);
  
  
    genre = Optional.optional(nativeFromJson, nativeToJson);
    genre.value = json['genre'] == null ? null : nativeFromJson<String>(json['genre']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SearchMovieVariables otherTyped = other as SearchMovieVariables;
    return titleInput == otherTyped.titleInput && 
    genre == otherTyped.genre;
    
  }
  @override
  int get hashCode => Object.hash(titleInput.hashCode, genre.hashCode);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(titleInput.state == OptionalState.set) {
      json['titleInput'] = titleInput.toJson();
    }
    if(genre.state == OptionalState.set) {
      json['genre'] = genre.toJson();
    }
    return json;
  }

  SearchMovieVariables({
    required this.titleInput,
    required this.genre,
  });
}

