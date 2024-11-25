import 'package:flutter/material.dart';
import 'package:flutter_mediadesignerxpert_test/res/colors.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
      final Map<String, dynamic> args = Get.arguments ?? {};
    final String orderNo = args["orderNo"] ?? "No Order Number";
    final int totalQuantity = args["totalQuantity"] ?? 0;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColor.customColor,
                    size: 24,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/logo-400x400.png',
                      height: 123,
                      width: 123,

                    ),
                  ],
                ),
                const SizedBox(width: 40),
              ],
            ),
            const SizedBox(height: 50),
             Row(
              children: [
                const Text(
                  'Order #',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 130),
                Text(
                  orderNo,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.customColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Order name',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 99),
                Text(
                  'Joe’s catering',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.customColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'optional',
              style: TextStyle(fontSize: 9, color: AppColor.grey),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Delivery date',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 90),
                Text(
                  'May 4th 2024',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.customColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
             Row(
              children: [
                const Text(
                  'Total quantity',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 85),
                Text(
                  '$totalQuantity',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Estimated total',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 75),
                Text(
                  '\$1402.96',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 125),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deliver to:',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.grey,
                      ),
                    ),
                    Text(
                      '355 onderdonk st\nMarina Dubai, UAE',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Delivery instructions ...',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.customColor,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.customColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                ),
                child: const Text(
                  'submit',
                  style: TextStyle(fontSize: 16, color: AppColor.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Save as draft',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.customColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
