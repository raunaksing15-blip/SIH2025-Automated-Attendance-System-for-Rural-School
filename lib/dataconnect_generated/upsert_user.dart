import 'dart:convert' as jsonlib;

/// Minimal helper typedefs and placeholder implementations to satisfy generated code.
/// Replace these with real implementations from your project if available.
typedef Deserializer<T> = T Function(dynamic);
typedef Serializer<T> = String Function(T);

T nativeFromJson<T>(dynamic value) => value as T;
dynamic nativeToJson<T>(T value) => value;

dynamic jsonDecode(dynamic input) {
  if (input is String) return jsonlib.jsonDecode(input);
  return input;
}
String jsonEncode(Object? value) => jsonlib.jsonEncode(value);

class OperationResult<TData, TVars> {
  final TData? data;
  final dynamic error;
  OperationResult({this.data, this.error});
}

class MutationRef<TData, TVars> {
  final Future<OperationResult<TData, TVars>> Function() _execute;
  MutationRef(this._execute);
  Future<OperationResult<TData, TVars>> execute() => _execute();
}

class FirebaseDataConnect {
  /// Placeholder mutation implementation; swap for your real data connector.
  MutationRef<TData, TVars> mutation<TData, TVars>(
      String name,
      Deserializer<TData> dataDeserializer,
      Serializer<TVars> varsSerializer,
      TVars vars) {
    return MutationRef(() async {
      // Real implementation should perform network call and return parsed data.
      return OperationResult<TData, TVars>(data: null);
    });
  }
}

class UpsertUserVariablesBuilder {
  String username;

  final FirebaseDataConnect _dataConnect;
  UpsertUserVariablesBuilder(this._dataConnect, {required this.username});
  Deserializer<UpsertUserData> dataDeserializer = (dynamic json) => UpsertUserData.fromJson(jsonDecode(json));
  Serializer<UpsertUserVariables> varsSerializer = (UpsertUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpsertUserData, UpsertUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpsertUserData, UpsertUserVariables> ref() {
    UpsertUserVariables vars = UpsertUserVariables(username: username);
    return _dataConnect.mutation("UpsertUser", dataDeserializer, varsSerializer, vars);
  }
}

class UpsertUserUserUpsert {
  final String id;
  UpsertUserUserUpsert.fromJson(dynamic json):
    id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertUserUserUpsert otherTyped = other as UpsertUserUserUpsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpsertUserUserUpsert({
    required this.id,
  });
}

class UpsertUserData {
  final UpsertUserUserUpsert userUpsert;
  UpsertUserData.fromJson(dynamic json):
    userUpsert = UpsertUserUserUpsert.fromJson(json['user_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertUserData otherTyped = other as UpsertUserData;
    return userUpsert == otherTyped.userUpsert;
    
  }
  @override
  int get hashCode => userUpsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_upsert'] = userUpsert.toJson();
    return json;
  }

  const UpsertUserData({
    required this.userUpsert,
  });
}

class UpsertUserVariables {
  final String username;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpsertUserVariables.fromJson(Map<String, dynamic> json):
    username = nativeFromJson<String>(json['username']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpsertUserVariables otherTyped = other as UpsertUserVariables;
    return username == otherTyped.username;
    
  }
  @override
  int get hashCode => username.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['username'] = nativeToJson<String>(username);
    return json;
  }

  const UpsertUserVariables({
    required this.username,
  });
}

