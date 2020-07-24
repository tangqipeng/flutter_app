
abstract class RequestCallback {

  void requestSuccessful(String json);

  void requestFailed(String errorMessage);
}