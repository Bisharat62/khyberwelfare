import 'package:flutter/material.dart';

import 'const_text.dart';

class ViewImageNetwork extends StatelessWidget {
  String imgUrl;
  String? text;
  ViewImageNetwork({super.key, required this.imgUrl, this.text});

  @override
  Widget build(BuildContext context) {
    return imgUrl == ''
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text != null
                    ? boldtext(Colors.black, 12, text.toString())
                    : const SizedBox.shrink(),
                Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ));
  }
}
