import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowController extends GetxController {
  // List of rows with their editable state and controllers
  var rows = <Map<String, dynamic>>[].obs;

  // Reactive variable to track if action buttons are enabled
  var isActionButtonsEnabled = false.obs;

  // Reactive variable for total sum of quantities
  var totalQuantity = 0.obs;

  // Controller for the order number field
  var orderNoController = TextEditingController(text: '112096');

  // List to store API data
  var suggestionsList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeRows();
    _fetchSuggestions(); // Fetch data once during initialization
  }

  // Initialize rows
  void _initializeRows() {
    for (int i = 0; i < 5000; i++) {
      rows.add({
        "quantityController": TextEditingController(),
        "itemController": TextEditingController(),
        "isQuantityEditable": i == 0, // First row is editable initially
        "isItemEditable": false, // Item is not editable until quantity is filled
        "notes": "", // Notes for the row
        "hasImage": false, // Whether the row has an image
      });
    }
  }

  // Fetch suggestions from API (only once during initialization)
  Future<void> _fetchSuggestions() async {
    try {
      final response =
          await http.get(Uri.parse('https://app.giotheapp.com/api-sample/'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Extract values from the map (the actual item names)
        suggestionsList.value = jsonResponse.values.cast<String>().toList();
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  // Provide filtered suggestions from the stored list
  List<String> getFilteredSuggestions(String query) {
    if (query.isEmpty) {
      return [];
    }
    return suggestionsList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Reset method to clear all data
  void resetData() {
    for (var row in rows) {
      row["quantityController"].clear();
      row["itemController"].clear();

      row["isQuantityEditable"] = false;
      row["isItemEditable"] = false;
      row["notes"] = "";
      row["hasImage"] = false;
    }

    rows[0]["isQuantityEditable"] = true;
    updateButtonState();
    totalQuantity.value = 0;
    rows.refresh();
  }

  void updateEditability(int index) {
    if (rows[index]["quantityController"].text.isNotEmpty) {
      rows[index]["isItemEditable"] = true;
    } else {
      rows[index]["isItemEditable"] = false;
    }

    if (rows[index]["quantityController"].text.isNotEmpty &&
        rows[index]["itemController"].text.isNotEmpty &&
        index + 1 < rows.length) {
      rows[index + 1]["isQuantityEditable"] = true;
    } else if (index + 1 < rows.length) {
      rows[index + 1]["isQuantityEditable"] = false;
    }

    calculateTotalQuantity();
    updateButtonState();
    rows.refresh();
  }

  void calculateTotalQuantity() {
    int sum = 0;
    for (var row in rows) {
      final int quantity = int.tryParse(row["quantityController"].text) ?? 0;
      sum += quantity;
    }
    totalQuantity.value = sum;
  }

  void addNotes(int index, String notes) {
    rows[index]["notes"] = notes;
    updateButtonState();
    rows.refresh();
  }

  void addImage(int index) {
    rows[index]["hasImage"] = true;
    updateButtonState();
    rows.refresh();
  }

  void updateButtonState() {
    isActionButtonsEnabled.value = rows.any((row) =>
        row["quantityController"].text.isNotEmpty ||
        row["itemController"].text.isNotEmpty ||
        (row["notes"] ?? "").isNotEmpty ||
        (row["hasImage"] ?? false));
  }

  @override
  void onClose() {
    for (var row in rows) {
      row["quantityController"].dispose();
      row["itemController"].dispose();
    }
    super.onClose();
  }
}
