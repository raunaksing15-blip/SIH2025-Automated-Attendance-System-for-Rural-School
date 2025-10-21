
// Minimal local stubs to allow this generated file to compile without the real
// `firebase_data_connect` package; replace these with the real package and remove
// these stubs when you add the dependency in pubspec.yaml.

class ConnectorConfig {
  final String region;
  final String name;
  final String projectId;
  const ConnectorConfig(this.region, this.name, this.projectId);
}

enum CallerSDKType { generated }

class FirebaseDataConnect {
  FirebaseDataConnect();

  static FirebaseDataConnect instanceFor({required ConnectorConfig connectorConfig, required CallerSDKType sdkType}) {
    return FirebaseDataConnect();
  }

  static FirebaseDataConnect get instance => FirebaseDataConnect();
}

// Simple builder stubs so generated code compiles; replace with real implementations.

class CreateMovieVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  final String title;
  final String genre;
  final String imageUrl;
  CreateMovieVariablesBuilder(this.dataConnect, {required this.title, required this.genre, required this.imageUrl});
  Map<String, dynamic> toJson() => {'title': title, 'genre': genre, 'imageUrl': imageUrl};
}

class UpsertUserVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  final String username;
  UpsertUserVariablesBuilder(this.dataConnect, {required this.username});
  Map<String, dynamic> toJson() => {'username': username};
}

class AddReviewVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  final String movieId;
  final int rating;
  final String reviewText;
  AddReviewVariablesBuilder(this.dataConnect, {required this.movieId, required this.rating, required this.reviewText});
  Map<String, dynamic> toJson() => {'movieId': movieId, 'rating': rating, 'reviewText': reviewText};
}

class DeleteReviewVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  final String movieId;
  DeleteReviewVariablesBuilder(this.dataConnect, {required this.movieId});
  Map<String, dynamic> toJson() => {'movieId': movieId};
}

class ListMoviesVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  ListMoviesVariablesBuilder(this.dataConnect);
  Map<String, dynamic> toJson() => {};
}

class ListUsersVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  ListUsersVariablesBuilder(this.dataConnect);
  Map<String, dynamic> toJson() => {};
}

class ListUserReviewsVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  ListUserReviewsVariablesBuilder(this.dataConnect);
  Map<String, dynamic> toJson() => {};
}

class GetMovieByIdVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  final String id;
  GetMovieByIdVariablesBuilder(this.dataConnect, {required this.id});
  Map<String, dynamic> toJson() => {'id': id};
}

class SearchMovieVariablesBuilder {
  final FirebaseDataConnect dataConnect;
  SearchMovieVariablesBuilder(this.dataConnect);
  Map<String, dynamic> toJson() => {};
}


class ExampleConnector {
  
  CreateMovieVariablesBuilder createMovie ({required String title, required String genre, required String imageUrl, }) {
    return CreateMovieVariablesBuilder(dataConnect, title: title, genre: genre, imageUrl: imageUrl,);
  }
  
  UpsertUserVariablesBuilder upsertUser ({required String username, }) {
    return UpsertUserVariablesBuilder(dataConnect, username: username,);
  }
  
  AddReviewVariablesBuilder addReview ({required String movieId, required int rating, required String reviewText, }) {
    return AddReviewVariablesBuilder(dataConnect, movieId: movieId, rating: rating, reviewText: reviewText,);
  }
  
  DeleteReviewVariablesBuilder deleteReview ({required String movieId, }) {
    return DeleteReviewVariablesBuilder(dataConnect, movieId: movieId,);
  }
  
  ListMoviesVariablesBuilder listMovies () {
    return ListMoviesVariablesBuilder(dataConnect, );
  }
  
  ListUsersVariablesBuilder listUsers () {
    return ListUsersVariablesBuilder(dataConnect, );
  }
  
  ListUserReviewsVariablesBuilder listUserReviews () {
    return ListUserReviewsVariablesBuilder(dataConnect, );
  }
  
  GetMovieByIdVariablesBuilder getMovieById ({required String id, }) {
    return GetMovieByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  SearchMovieVariablesBuilder searchMovie () {
    return SearchMovieVariablesBuilder(dataConnect, );
  }
  

  static const ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'example',
    'sih2025-automated-attendance-system-for-rural-school',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}

