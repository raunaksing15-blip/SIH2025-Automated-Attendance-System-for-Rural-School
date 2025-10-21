part of 'example.dart';

import 'package:meta/meta.dart';

typedef Deserializer<T> = T Function(dynamic);
typedef Serializer<T> = String Function(T);

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

T nativeFromJson<T>(dynamic value) => value as T;
dynamic nativeToJson<T>(T value) => value;

class AddReviewVariablesBuilder {
  String movieId;
  int rating;
  String reviewText;

  final FirebaseDataConnect _dataConnect;
  AddReviewVariablesBuilder(this._dataConnect, {required  this.movieId,required  this.rating,required  this.reviewText,});
  Deserializer<AddReviewData> dataDeserializer = (dynamic json)  => AddReviewData.fromJson(json);
  Serializer<AddReviewVariables> varsSerializer = (AddReviewVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddReviewData, AddReviewVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AddReviewData, AddReviewVariables> ref() {
    AddReviewVariables vars= AddReviewVariables(movieId: movieId,rating: rating,reviewText: reviewText,);
    return _dataConnect.mutation("AddReview", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AddReviewReviewUpsert {
  final String userId;
  final String movieId;

  AddReviewReviewUpsert.fromJson(dynamic json)
    : userId = nativeFromJson<String>(json['userId']),
      movieId = nativeFromJson<String>(json['movieId']);

  Map<String, dynamic> toJson() {
    return {
      'userId': nativeToJson<String>(userId),
      'movieId': nativeToJson<String>(movieId),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final AddReviewReviewUpsert otherTyped = other as AddReviewReviewUpsert;
    return userId == otherTyped.userId && movieId == otherTyped.movieId;
  }

  @override
  int get hashCode => Object.hash(userId.hashCode, movieId.hashCode);

  const AddReviewReviewUpsert({
    required this.userId,
    required this.movieId,
  });
}

@immutable
class AddReviewData {
  final AddReviewReviewUpsert reviewUpsert;

  AddReviewData.fromJson(dynamic json)
    : reviewUpsert = AddReviewReviewUpsert.fromJson(json['review_upsert']);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final AddReviewData otherTyped = other as AddReviewData;
    return reviewUpsert == otherTyped.reviewUpsert;
  }

  @override
  int get hashCode => reviewUpsert.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'review_upsert': reviewUpsert.toJson(),
    };
  }

  const AddReviewData({
    required this.reviewUpsert,
  });
}

@immutable
class AddReviewVariables {
  final String movieId;
  final int rating;
  final String reviewText;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AddReviewVariables.fromJson(Map<String, dynamic> json):
  
  movieId = nativeFromJson<String>(json['movieId']),
  rating = nativeFromJson<int>(json['rating']),
  reviewText = nativeFromJson<String>(json['reviewText']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AddReviewVariables otherTyped = other as AddReviewVariables;
    return movieId == otherTyped.movieId && 
    rating == otherTyped.rating && 
    reviewText == otherTyped.reviewText;
    
  }
  @override
  int get hashCode => Object.hash(movieId.hashCode, rating.hashCode, reviewText.hashCode);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['movieId'] = nativeToJson<String>(movieId);
    json['rating'] = nativeToJson<int>(rating);
    json['reviewText'] = nativeToJson<String>(reviewText);
    return json;
  }

  const AddReviewVariables({
    required this.movieId,
    required this.rating,
    required this.reviewText,
  });
}

