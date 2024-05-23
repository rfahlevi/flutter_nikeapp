// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../misc/nike_font.dart';
import '../../../../misc/spacing.dart';

class UploadImages extends StatefulWidget {
  final Function(List<String>? selectedProductImages)? onSelected;
  const UploadImages({
    super.key,
    this.onSelected,
  });

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Images',
              style: NikeFont.h4Regular(),
            ),
            verticalSpace(7),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    selectedImages = await ImagePicker().pickMultiImage(limit: 3);

                    if (selectedImages.isNotEmpty) {
                      widget.onSelected!(selectedImages.map((e) => File(e.path).path).toList());
                      setState(() {});
                    }
                  },
                  splashColor: Colors.black87.withOpacity(0.1),
                  radius: 100,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        verticalSpace(4),
                        if (selectedImages.isNotEmpty)
                          Text(
                            '${selectedImages.length} Selected',
                            style: NikeFont.h7Regular(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(14),
          ],
        ),
        horizontalSpaces(24),
        if (selectedImages.isNotEmpty)
          ...selectedImages.map(
            (e) => Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 18, right: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(e.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  width: 35,
                  child: IconButton(
                    onPressed: () {
                      selectedImages.removeWhere((element) => element.path == e.path);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
