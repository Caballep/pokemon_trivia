class RegionDto {
  final String name;

  RegionDto({
    required this.name,
  });

  factory RegionDto.fromJson(Map<String, dynamic> json) {
    return RegionDto(
      name: json['name'] as String,
    );
  }
}
