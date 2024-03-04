class NasaImageApi {
  final String href;

  NasaImageApi({required this.href});

  factory NasaImageApi.fromJson(Map<String, dynamic> json) {
    return NasaImageApi(
      href: json['href'],
    );
  }
}
