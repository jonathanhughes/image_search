import 'package:flutter/widgets.dart';
import 'package:image_search/components/image_display_item.dart';

import '../models/image_result.dart';

class ImageResultScrollContainer extends StatelessWidget {
  final List<ImageResult> results;

  const ImageResultScrollContainer({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: results.map((ImageResult result) => ImageDisplayItem(imageResult: result)).toList(),
        ),
      ),
    );
  }
}