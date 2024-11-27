import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  final _storage = const FlutterSecureStorage();

  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadPaymentInfo();
  }

  Future<void> _loadPaymentInfo() async {
    _nameController.text = await _storage.read(key: 'name') ?? '';
    _cardNumberController.text = await _storage.read(key: 'card_number') ?? '';
    _expiryDateController.text = await _storage.read(key: 'expiry_date') ?? '';
    setState(() {});
  }

  Future<void> _savePaymentInfo() async {
    await _storage.write(key: 'name', value: _nameController.text);
    await _storage.write(key: 'card_number', value: _cardNumberController.text);
    await _storage.write(key: 'expiry_date', value: _expiryDateController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment information saved')),
    );
    setState(() {
      _isEditing = false;
    });
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      style: const TextStyle(color: Colors.black), 
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue), 
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isEditing ? Colors.grey : Colors.blue,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, 
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, 
            width: 2.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Payment Information"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField("Name and Surname", _nameController),
            const SizedBox(height: 16),
            _buildField("Card Number", _cardNumberController),
            const SizedBox(height: 16),
            _buildField("Expiry Date (MM/YY)", _expiryDateController),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_isEditing) {
                    _savePaymentInfo();
                  } else {
                    setState(() {
                      _isEditing = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text(_isEditing ? "Save" : "Edit",  
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
