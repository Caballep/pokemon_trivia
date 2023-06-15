class GenerationDto {
  final String name;
  final String url;

  GenerationDto({
    required this.name,
    required this.url,
  });

  factory GenerationDto.fromJson(Map<String, dynamic> json) {
    return GenerationDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
