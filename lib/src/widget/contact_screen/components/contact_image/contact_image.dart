import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contact_screen_controller.dart';
import 'contact_image_icons.dart';

class ContactImage extends StatefulWidget {
  const ContactImage({
    this.imagePath,
    super.key,
    this.readOnly = false,
  });

  final String? imagePath;
  final bool readOnly;

  @override
  State<ContactImage> createState() => _ContactImageState();
}

class _ContactImageState extends State<ContactImage> {
  late ContactScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ContactScreenController>()
      ..setImagePath(widget.imagePath);
  }

  void needsRebuild() {
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.25;

    return CircleAvatar(
      radius: radius,
      backgroundImage:
          (controller.imagePath != null || controller.photo != null)
              ? FileImage(File(controller.photo?.path ?? controller.imagePath!))
              : null,
      child: ContactImageIcons(
        readOnly: widget.readOnly,
        needsRebuild: needsRebuild,
      ),
    );
  }
}
