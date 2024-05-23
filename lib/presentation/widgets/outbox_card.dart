// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

import 'package:flutter_nikeapp/domain/entities/product.dart' as p;
import 'package:flutter_nikeapp/helper/directory_path.dart';
import 'package:flutter_nikeapp/helper/product_table.dart';
import 'package:flutter_nikeapp/helper/sqflite_helper.dart';

import '../../helper/rupiah_formatter.dart';
import '../misc/nike_font.dart';
import '../misc/spacing.dart';

class OutboxCard extends StatefulWidget {
  final ProductTable product;
  final Function? onDelete;
  const OutboxCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  State<OutboxCard> createState() => _OutboxCardState();
}

class _OutboxCardState extends State<OutboxCard> {
  List<p.Category> categories = [];
  p.Category? category;
  DirectoryPath dir = DirectoryPath();
  String? folderPath;
  List<String> images = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () async {
        categories = await SqfliteHelper().getCategories();
        category = categories.where((element) => element.id == widget.product.productCategoryId).firstOrNull;
        folderPath = await dir.getPath();
        var imageDecode = jsonDecode(widget.product.image);
        images = List<String>.from(imageDecode);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog.adaptive(
          title: Text(
            'Confirm Delete!',
            style: NikeFont.h3Medium(),
          ),
          content: Text(
            'Are you sure want to delete this product from local database?',
            style: NikeFont.h4Regular(),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                context.pop();
                final deleteCount = await SqfliteHelper().deleteProduct(widget.product.id!);
                if (deleteCount > 0) {
                  widget.onDelete!();
                }
              },
              child: Text(
                'Yes, Delete',
                style: NikeFont.h4Regular().copyWith(
                  color: Colors.black54,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: NikeFont.h4Regular().copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      splashColor: Colors.black87.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(7),
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (folderPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  File('$folderPath/${path.basename(images[0])}'),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 6,
                  width: double.infinity,
                ),
              ),
            verticalSpace(7),
            Text(
              widget.product.name,
              style: NikeFont.h4SemiBold(),
            ),
            Text(
              category?.name ?? '-',
              style: NikeFont.h5Regular(),
            ),
            Text(
              widget.product.description,
              style: NikeFont.h6Regular(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(7),
            Text(
              rupiahFormatter(
                widget.product.price.toString(),
              ),
              style: NikeFont.h4SemiBold().copyWith(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
