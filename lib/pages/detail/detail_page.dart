// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:multi_page_app/models/item.dart';
import 'package:multi_page_app/utils/app_colors.dart';
import 'package:multi_page_app/utils/app_styles.dart';
import 'package:multi_page_app/widgets/custom_button.dart';

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(item.name, style: AppStyles.headline2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'itemImage-${item.id}', // Unique tag for Hero animation
              child: Image.network(
                item.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: AppColors.backgroundColor,
                    child: Icon(Icons.broken_image, size: 100, color: AppColors.textColor.withOpacity(0.6)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppStyles.headline1.copyWith(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: AppStyles.headline2.copyWith(color: AppColors.accentColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: AppStyles.subtitle1.copyWith(color: AppColors.textColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: AppStyles.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Add to Cart',
                    onPressed: () {
                      // TODO: Implement add to cart logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} added to cart!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    backgroundColor: AppColors.accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}