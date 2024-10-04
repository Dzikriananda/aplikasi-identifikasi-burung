import 'package:dio/dio.dart';

class CancelTokenStore {
  // Static instance of the singleton
  static final CancelTokenStore _instance = CancelTokenStore._internal();

  // Private named constructor
  CancelTokenStore._internal(){
    print('CancelTokenStore instance created dengan uuid.');
  }

  // Factory constructor returns the same instance
  factory CancelTokenStore() {
    return _instance;
  }

  // Map to store CancelTokens
  final Map<String, CancelToken> _tokens = {};

  String createCancelToken() {
    final token = CancelToken();
    final id = token.hashCode.toString();

    print('Creating cancel token with ID: $id and map ID: ${_tokens.hashCode}'); // Debugging output
    _tokens[id] = token;
    print('Tokens after creation: $_tokens'); // Debugging output

    return id;
  }

  CancelToken? getCancelToken(String id) {
    print('Retrieving cancel token with ID: $id and map ID: ${_tokens.hashCode}'); // Debugging output
    print('Current tokens: $_tokens'); // Debugging output
    return _tokens[id];
  }

  void cancelRequest(String id) {
    CancelToken? cancelToken = _tokens[id];
    print('Canceling token with ID: $id'); // Debugging output
    if (cancelToken != null && !cancelToken.isCancelled) {
      print('Cancel token not canceled yet, canceling now.');
      cancelToken.cancel("Request canceled");
      print('Status after canceling: ${cancelToken.isCancelled}'); // Debugging output
    } else {
      print('Token with ID $id not found or already canceled.');
    }
  }

  void removeCancelToken(String id) {
    _tokens.remove(id);
    print('Removed token with ID: $id'); // Debugging output
  }
}

//
// class CancelTokenStore {
//   static final Map<String, CancelToken> _tokens = {};
//
//   static String createCancelToken() {
//     final token = CancelToken();
//     final id = token.hashCode.toString();
//     print('membuat cancel token dengan $id dan id _token ${_tokens.hashCode}');
//     _tokens[id] = token;
//     print(_tokens.toString());
//     return id;
//   }
//
//   static CancelToken? getCancelToken(String id) {
//     print('mengambil cancel token $id');
//     print('keadaan token saat get ${_tokens.toString()} dan id _token ${_tokens.hashCode}');
//     if(_tokens.containsKey(id)) {
//       print('ada cancel token $id');
//     }
//     return _tokens[id];
//   }
//
//   static void cancelRequest(String id) {
//     CancelToken? cancelToken = _tokens[id];
//     print('mencoba cancel token $id');
//     if(cancelToken!=null) {
//       if(!cancelToken!.isCancelled) {
//         print(' $id belom dicancel');
//         cancelToken.cancel("Request canceled");
//         print(' status $id : ${cancelToken!.isCancelled}');
//       }
//     }
//   }
//
//   static void removeCancelToken(String id) {
//     _tokens.remove(id);
//   }
// }