import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contact_screen_controller.dart';

class ContactImageIcons extends StatelessWidget {
  const ContactImageIcons({
    super.key,
    this.readOnly = false,
    required this.needsRebuild,
  });

  final bool readOnly;
  final Function needsRebuild;

  @override
  Widget build(BuildContext context) {
    final double positioned = MediaQuery.of(context).size.width * 0.01;
    final double iconSize = MediaQuery.of(context).size.width * 0.1;
    final controller = context.read<ContactScreenController>();

    return Visibility(
      visible: !readOnly,
      child: (controller.imagePath != null || controller.photo != null)
          ? Stack(
              children: [
                Positioned(
                  right: positioned,
                  bottom: positioned,
                  child: IconButton(
                    onPressed: () {
                      controller
                        ..setPhoto(null)
                        ..setImagePath(null);
                      needsRebuild();
                    },
                    icon: Icon(
                      Icons.delete_outlined,
                      color: Colors.black,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Positioned(
                  right: positioned,
                  bottom: positioned,
                  child: IconButton(
                    onPressed: () async {
                      await controller.getImageFromGallery();
                      needsRebuild();
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.black,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
