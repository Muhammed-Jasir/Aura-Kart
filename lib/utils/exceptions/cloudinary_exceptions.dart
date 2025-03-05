/// Exception class for handling various Cloudinary-related errors.
class ACloudinaryException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructs an [ACloudinaryException] with the provided error code.
  const ACloudinaryException(this.code);

  /// Returns a user-friendly error message based on the Cloudinary error code.
  String get message {
    switch (code) {
      case 'upload_failed':
        return 'Image upload failed. Please try again.';
      case 'resource_not_found':
        return 'The requested asset was not found. Please verify that the file exists.';
      case 'invalid_file_format':
        return 'The file format is not supported. Please upload a valid image or 3D model.';
      case 'file_size_exceeded':
        return 'The file size exceeds the allowed limit. Please choose a smaller file.';
      case 'unauthorized':
        return 'Unauthorized access. Please check your Cloudinary credentials.';
      case 'internal_error':
        return 'An internal error occurred at Cloudinary. Please try again later.';
      case 'timeout':
        return 'The request timed out. Please try again.';
      case 'invalid-api-key':
        return 'The API key provided is invalid. Please verify your credentials.';
      case 'resource_type_mismatch':
        return 'The asset type does not match the expected format. Please verify the resource type.';
      case 'transformation_error':
        return 'There was an error processing the requested transformation.';
      case 'rate_limit_exceeded':
        return 'API rate limit exceeded. Please try again later.';
      case 'invalid_signature':
        return 'Invalid signature provided. Please check your API secret.';
      case 'invalid_credentials':
        return 'Invalid credentials. Please check your Cloudinary configuration.';
      default:
        return 'An unexpected Cloudinary error occurred. Please try again later.';
    }
  }

  @override
  String toString() => 'ACloudinaryException($code): $message';
}
