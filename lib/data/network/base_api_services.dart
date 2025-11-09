abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url, dynamic data);
  Future<dynamic> putApi(String url,
      {Map<String, String>? headers, dynamic body});
  Future<dynamic> deleteApi(String url, {Map<String, String>? headers});
}