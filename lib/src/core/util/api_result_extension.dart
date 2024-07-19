


import '../../data/model/base_response.dart';

extension APIResultExt<T extends BaseResponse> on T? {
  /// Ensure status code is 200-299.
  /// Will throw error.
  T validateStatus() {
    final error = 'Invalid data. (api_result)';
    if (this == null) throw error;

    final code = this!.statusCode ?? 0;

    if (code >= 200 && code <= 299) return this!;

    throw this!.message ?? 'Terjadi kesalahan ($code)';
  }
}