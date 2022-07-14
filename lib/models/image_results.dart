class ImageResult {
    final int id;
    final String photographer;
    final String description;
    final String previewUrl;
    final String fullUrl;

    const ImageResult({
        required this.id,
        required this.photographer,
        required this.description,
        required this.previewUrl,
        required this.fullUrl,
    });

    factory ImageResult.fromJson(Map<String, dynamic> json) {
        return ImageResult(
            id: json['id'],
            photographer: json['photographer'],
            description: json['alt'],
            previewUrl: json['src']?['medium'],
            fullUrl: json['src']?['original']
        );
    }
}