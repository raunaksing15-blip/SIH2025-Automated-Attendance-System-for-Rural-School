part of 'example.dart';

typedef Deserializer<T> = T Function(dynamic);
typedef Serializer<T> = String Function(T);

class OperationResult<T, V> {
  final T? data;
  final V? variables;
  OperationResult({this.data, this.variables});
}

class MutationRef<T, V> {
  final Future<OperationResult<T, V>> Function() _execute;
  MutationRef(this._execute);
  Future<OperationResult<T, V>> execute() => _execute();
}

class FirebaseDataConnect {
  MutationRef<T, V> mutation<T, V>(
    String name,
    Deserializer<T> deserializer,
    Serializer<V> serializer,
    V vars,
  ) {
    // Replace with real implementation that calls your backend and deserializes using deserializer.
    return MutationRef(() async {
      return OperationResult<T, V>(data: null, variables: vars);
    });
  }
}

// Simple helpers used by generated code; replace with your real converters if needed.
T nativeFromJson<T>(dynamic v) => v as T;
dynamic nativeToJson<T>(T v) => v;

class CreateMovieVariablesBuilder {
  String title;
  String genre;
  String imageUrl;

  final FirebaseDataConnect _dataConnect;
  CreateMovieVariablesBuilder(this._dataConnect,
      {required this.title, required this.genre, required this.imageUrl});
  Deserializer<CreateMovieData> dataDeserializer =
      (dynamic json) => CreateMovieData.fromJson(jsonDecode(json));
  Serializer<CreateMovieVariables> varsSerializer =
      (CreateMovieVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateMovieData, CreateMovieVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateMovieData, CreateMovieVariables> ref() {
    CreateMovieVariables vars =
        CreateMovieVariables(title: title, genre: genre, imageUrl: imageUrl);
    return _dataConnect.mutation("CreateMovie", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateMovieMovieInsert {
  final String id;
  CreateMovieMovieInsert.fromJson(dynamic json) : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMovieMovieInsert otherTyped = other as CreateMovieMovieInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateMovieMovieInsert({
    required this.id,
  });
}

@immutable
class CreateMovieData {
  final CreateMovieMovieInsert movieInsert;
  CreateMovieData.fromJson(dynamic json)
      : movieInsert = CreateMovieMovieInsert.fromJson(json['movie_insert']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMovieData otherTyped = other as CreateMovieData;
    return movieInsert == otherTyped.movieInsert;
  }

  @override
  int get hashCode => movieInsert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movie_insert'] = movieInsert.toJson();
    return json;
  }

  const CreateMovieData({
    required this.movieInsert,
  });
}

@immutable
class CreateMovieVariables {
  final String title;
  final String genre;
  final String imageUrl;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateMovieVariables.fromJson(Map<String, dynamic> json)
      : title = nativeFromJson<String>(json['title']),
        genre = nativeFromJson<String>(json['genre']),
        imageUrl = nativeFromJson<String>(json['imageUrl']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateMovieVariables otherTyped = other as CreateMovieVariables;
    return title == otherTyped.title &&
        genre == otherTyped.genre &&
        imageUrl == otherTyped.imageUrl;
  }

  @override
  int get hashCode => Object.hash(title.hashCode, genre.hashCode, imageUrl.hashCode);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['genre'] = nativeToJson<String>(genre);
    json['imageUrl'] = nativeToJson<String>(imageUrl);
    return json;
  }

  const CreateMovieVariables({
    required this.title,
    required this.genre,
    required this.imageUrl,
  });
}

