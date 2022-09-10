import 'package:com_nicodevelop_tiktokdownloader/components/preview/preview_component.dart';
import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:flutter/material.dart';

class VideoListComponent extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const VideoListComponent({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes vidéos"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: 130.0,
        ),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 9 / 16,
        ),
        itemBuilder: (context, index) {
          return PreviewComponent(
            item: items[index],
          );
        },
      ),
    );
  }
}
