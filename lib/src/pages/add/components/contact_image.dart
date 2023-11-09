import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../add/add_contact_controller.dart';

class ContactImage extends StatefulWidget {
  const ContactImage({
    this.imagePath,
    super.key,
  });

  final String? imagePath;

  @override
  State<ContactImage> createState() => _ContactImageState();
}

class _ContactImageState extends State<ContactImage> {
  late AddContactController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<AddContactController>()
      ..setImagePath(widget.imagePath);
  }

  void needsRebuild() {
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    final double wigth;
    final double heigth = wigth = MediaQuery.of(context).size.width / 2;
    final double iconSize = MediaQuery.of(context).size.width * 0.15;
    final double radius = MediaQuery.of(context).size.width * 0.5;
    final double positioned = MediaQuery.of(context).size.width * 0.01;

    return Container(
      width: wigth,
      height: heigth,
      decoration: BoxDecoration(
        image: (controller.imagePath != null || controller.photo != null)
            ? DecorationImage(
                image: FileImage(
                    File(controller.photo?.path ?? controller.imagePath!)),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: (widget.imagePath != null || controller.photo != null)
          ? Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: positioned,
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
                Positioned(
                  right: positioned,
                  bottom: positioned,
                  child: IconButton(
                    onPressed: () async {
                      await controller.getImageFromGallery();
                      needsRebuild();
                    },
                    icon: Icon(
                      Icons.replay_outlined,
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
                      Icons.add_photo_alternate_rounded,
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
