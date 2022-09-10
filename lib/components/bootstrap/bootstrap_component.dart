import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:flutter/material.dart';

class BootstrapComponent extends StatelessWidget {
  const BootstrapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(
              bottom: kDefaultPadding,
            ),
            child: Text(
              "TikLoader",
              style: TextStyle(
                fontSize: kDefaultFontSize * 3,
              ),
            ),
          ),
          Text(
            "1 - Go to TikTok",
            style: TextStyle(
              fontSize: kDefaultFontSize * 1.3,
            ),
          ),
          Text(
            "2 - Click on the share button",
            style: TextStyle(
              fontSize: kDefaultFontSize * 1.3,
            ),
          ),
          Text(
            "3 - Copy the link",
            style: TextStyle(
              fontSize: kDefaultFontSize * 1.3,
            ),
          ),
          Text(
            "4 - Paste your the link here",
            style: TextStyle(
              fontSize: kDefaultFontSize * 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
