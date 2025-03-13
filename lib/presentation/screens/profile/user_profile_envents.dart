abstract class UserProfileEvents {}

class UserProfileUploadEvents extends UserProfileEvents {
  final String endpoint; // API endpoint
  final Map<String, dynamic>? data; // Query parameters
  UserProfileUploadEvents({required this.endpoint, this.data});
}
