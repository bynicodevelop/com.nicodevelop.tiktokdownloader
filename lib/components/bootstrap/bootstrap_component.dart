import 'package:com_nicodevelop_tiktokdownloader/config/constants.dart';
import 'package:com_nicodevelop_tiktokdownloader/utils/translate.dart';
import 'package:flutter/material.dart';

class BootstrapComponent extends StatelessWidget {
  const BootstrapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
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
            t(context)!.label1Wizard,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: kDefaultPadding * .5,
          ),
          Text(
            t(context)!.label2Wizard,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: kDefaultPadding * .5,
          ),
          Text(
            t(context)!.label3Wizard,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: kDefaultPadding * .5,
          ),
          Text(
            t(context)!.label4Wizard,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
