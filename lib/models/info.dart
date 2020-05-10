class InfoResponse {
  final String info;
  final String error;
  InfoResponse({this.info, this.error});

  InfoResponse.fromJson(String json) : info = json, error = '';
  InfoResponse.withError(String error): info = '', error = error;

}