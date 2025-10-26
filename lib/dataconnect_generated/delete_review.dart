import 'package:meta/meta.dart';

/// Minimal helpers and stand-ins to satisfy generated code references.
/// If your real project provides these types, remove or replace these
/// stand-ins so the real implementations are used instead.

typedef Deserializer<T> = T Function(dynamic);
typedef Serializer<T> = String Function(T);

class OperationResult<D, V> {
  final D data;
  final V variables;
  OperationResult(this.data, this.variables);
}

class MutationRef<D, V> {
  final String name;
  final Deserializer<D> deserializer;
  final Serializer<V> serializer;
  final V vars;
  MutationRef(this.name, this.deserializer, this.serializer, this.vars);

  Future<OperationResult<D, V>> execute() async {
    // Call deserializer with an empty map so generated fromJson methods that
    // expect a Map won't fail at runtime; adjust if your real deserializer
    // semantics differ.
    final dynamic decoded = deserializer(<String, dynamic>{});
    return OperationResult<D, V>(decoded as D, vars);
  }
}

class FirebaseDataConnect {
  MutationRef<D, V> mutation<D, V>(
      String name, Deserializer<D> d, Serializer<V> s, V vars) {
    return MutationRef<D, V>(name, d, s, vars);
  }
}

// Basic json helpers used by generated code -- replace with dart:convert's
// jsonDecode/jsonEncode in the library file if desired.
dynamic jsonDecode(dynamic json) => json;
String jsonEncode(dynamic obj) => obj is String ? obj : obj.toString();

// Native conversions used by the generator.
T nativeFromJson<T>(dynamic v) => v as T;
dynamic nativeToJson<T>(T v) => v;

class DeleteReviewVariablesBuilder {
  String movieId;

  final FirebaseDataConnect _dataConnect;
  DeleteReviewVariablesBuilder(this._dataConnect, {required this.movieId});
  Deserializer<DeleteReviewData> dataDeserializer =
      (dynamic json) => DeleteReviewData.fromJson(jsonDecode(json));
  Serializer<DeleteReviewVariables> varsSerializer =
      (DeleteReviewVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteReviewData, DeleteReviewVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteReviewData, DeleteReviewVariables> ref() {
    DeleteReviewVariables vars = DeleteReviewVariables(movieId: movieId);
    return _dataConnect.mutation("DeleteReview", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteReviewReviewDelete {
  final String userId;
  final String movieId;
  DeleteReviewReviewDelete.fromJson(dynamic json) :
    userId = nativeFromJson<String>(json['userId']),
    movieId = nativeFromJson<String>(json['movieId']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteReviewReviewDelete otherTyped = other as DeleteReviewReviewDelete;
    return userId == otherTyped.userId &&
      movieId == otherTyped.movieId;
  }
  @override
  int get hashCode => Object.hash(userId.hashCode, movieId.hashCode);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['movieId'] = nativeToJson<String>(movieId);
    return json;
  }

  const DeleteReviewReviewDelete({
    required this.userId,
    required this.movieId,
  });
}

@immutable
class DeleteReviewData {
  final DeleteReviewReviewDelete? reviewDelete;
  DeleteReviewData.fromJson(dynamic json) :
    reviewDelete = json['review_delete'] == null ? null : DeleteReviewReviewDelete.fromJson(json['review_delete']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteReviewData otherTyped = other as DeleteReviewData;
    return reviewDelete == otherTyped.reviewDelete;
  }
  @override
  int get hashCode => reviewDelete.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (reviewDelete != null) {
      json['review_delete'] = reviewDelete!.toJson();
    }
    return json;
  }

  const DeleteReviewData({
    this.reviewDelete,
  });
}

@immutable
class DeleteReviewVariables {
  final String movieId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteReviewVariables.fromJson(Map<String, dynamic> json) :
    movieId = nativeFromJson<String>(json['movieId']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteReviewVariables otherTyped = other as DeleteReviewVariables;
    return movieId == otherTyped.movieId;
  }
  @override
  int get hashCode => movieId.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movieId'] = nativeToJson<String>(movieId);
    return json;
  }

  const DeleteReviewVariables({
    required this.movieId,
  });
}
