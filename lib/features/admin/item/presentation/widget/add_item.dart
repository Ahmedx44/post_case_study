import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

class AddItemModal extends StatefulWidget {
  const AddItemModal({super.key});

  @override
  _AddItemModalState createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  final _formKey = GlobalKey<FormState>();

  String _itemName = '';
  String _category = '';
  double _price = 0.0;
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        // Center the modal
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7, // Adjust width
          constraints: const BoxConstraints(maxWidth: 400), // Limit max width
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Item",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Item Name', Icons.shopping_bag, (value) {
                      _itemName = value;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField('Category', Icons.category, (value) {
                      _category = value;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField('Price', Icons.attach_money, (value) {
                      _price = double.tryParse(value) ?? 0.0;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField('Image URL', Icons.link, (value) {
                      _imageUrl = value;
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newItem = Item(
                          name: _itemName,
                          price: _price,
                          imageUrl: _imageUrl,
                          category: _category,
                        );

                        // Add the item to the Hive box
                        final Box<Item> itemBox = Hive.box<Item>('items');
                        itemBox.add(newItem);

                        // Close the dialog
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Add Item',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      style: const TextStyle(color: Colors.black87),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
