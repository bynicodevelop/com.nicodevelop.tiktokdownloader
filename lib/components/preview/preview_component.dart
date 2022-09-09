import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/services/videodownloader/videodownloader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewComponent extends StatelessWidget {
  final Map<String, dynamic> item;

  const PreviewComponent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(
              kDefaultPadding / 2,
            ),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.8),
                BlendMode.dstATop,
              ),
              image: NetworkImage(
                item["previewUrl"],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context
                .read<VideoDownloaderBloc>()
                .add(const OnVideoDownloaderEvent(
                  id: "",
                ));
          },
          icon: const Icon(
            Icons.download,
            color: Colors.white,
          ),
          highlightColor: Colors.white.withOpacity(
            .3,
          ),
        ),
      ],
    );
  }
}
