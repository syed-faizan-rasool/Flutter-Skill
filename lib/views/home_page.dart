import 'package:flutter/material.dart';
import 'package:flutter_mediadesignerxpert_test/res/colors.dart';
import 'package:flutter_mediadesignerxpert_test/views/order_detail_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/row_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final rowController = Get.put(RowController());
    Future<void> showItemDialog(BuildContext context, int index) async {
      final TextEditingController notesController = TextEditingController(
        text: rowController.rows[index]["notes"],
      );
      final ImagePicker picker = ImagePicker();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Item Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: notesController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Add Notes',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      rowController.addImage(index);
                      Get.back();
                    }
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Select Picture'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  rowController.addNotes(index, notesController.text);
                  Get.back();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: AppColor.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: AppColor.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.menu_sharp,
                    color: AppColor.customColor,
                    size: 30,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/logo-400x400.png',
                        height: 100,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Container(
              color: AppColor.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        Icons.close,
                        color: rowController.isActionButtonsEnabled.value
                            ? AppColor.customColor
                            : AppColor.grey,
                        size: 30,
                      ),
                      onPressed: rowController.isActionButtonsEnabled.value
                          ? () {
                              rowController.resetData();
                              print("All data has been cleared");
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 245,
                  ),
                  Obx(
                    () => IconButton(
  icon: Icon(
    Icons.arrow_forward,
    color: rowController.isActionButtonsEnabled.value ? AppColor.customColor : AppColor.grey,
    size: 30,
  ),
  onPressed: rowController.isActionButtonsEnabled.value
      ? () {
          Get.to(() => const OrderDetailsPage(), arguments: {
            "orderNo": rowController.orderNoController.text,
            "totalQuantity": rowController.totalQuantity.value,
          });
        }
      : null,
),


                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: AppColor.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  const Text(
                    'Order # ',
                    style: TextStyle(
                      color: AppColor.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: rowController.orderNoController,
                     
                      style: const TextStyle(
                        color: AppColor.customColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 5.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: rowController.rows.length,
                  itemBuilder: (context, index) {
                    final row = rowController.rows[index];
                    return Container(
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        border: Border(
                          bottom:
                              BorderSide(color: AppColor.customColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: row["isQuantityEditable"]
                                    ? AppColor.white
                                    : AppColor.white,
                                border: const Border(
                                  right: BorderSide(
                                      color: AppColor.customColor, width: 1),
                                ),
                              ),
                              child: TextField(
                                enabled: row["isQuantityEditable"],
                                controller: row["quantityController"],
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.end,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 12.0,
                                  ),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14),
                                ),
                                onChanged: (value) {
                                  rowController.updateEditability(index);
                                  rowController.updateButtonState();
                                },
                              ),
                            ),
                          ),
                         Expanded(
  flex: 4,
  child: GestureDetector(
    onDoubleTap: () {
      if (row["isItemEditable"] == true) {
        showItemDialog(context, index);
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: row["isItemEditable"] ? AppColor.white : AppColor.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Autocomplete<String>(
  optionsBuilder: (TextEditingValue textEditingValue) {
    return rowController.getFilteredSuggestions(textEditingValue.text);
  },
  onSelected: (String selection) {
    row["itemController"].text = selection;
    rowController.updateEditability(index);
  },
  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: row["isItemEditable"],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        row["itemController"].text = value;
        rowController.updateEditability(index);
      },
    );
  },
  optionsViewBuilder: (context, onSelected, options) {
    return Material(
      elevation: 4.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: options.map((String option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              onSelected(option);
            },
          );
        }).toList(),
      ),
    );
  },
),

          ),
          // Display both icons if applicable
          if ((row["notes"] ?? "").isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.info, color: AppColor.customColor, size: 30),
            ),
          if ((row["hasImage"] ?? false) == true)
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.camera_alt, color: AppColor.customColor, size: 30),
            ),
        ],
      ),
    ),
  ),
),

                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
