class AppwriteConstants {
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectID = '67a70bf4001b0db686d0';
  static const String databaseId = '67a7c39b00067f75992a';
  static const String usersCollectionId = '67bae649003b91b5833a';
  static const String postCollectionId = '67bb0b61003756fb7b7e';
  static const String lawyersCollectionId = '67d3294a001a19d049a1';
  static const String meetingsCollectionId = '67d47386001c0953f383';

static const String postStorageBucketID = '67bb42e500309e4cd55f';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$postStorageBucketID/files/$imageId/view?project=$projectID&mode=admin';

     static const String razorpayKey = 'rzp_test_rLY2CNgq2Qdge0';
}
