import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';
import '../../../core/theme/app_colors.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDeliveryAddressSection(),
                const SizedBox(height: 16),
                _buildPaymentMethodSection(),
                const SizedBox(height: 16),
                _buildDeliveryInstructionsSection(),
                const SizedBox(height: 16),
                _buildOrderSummary(),
              ],
            ),
          ),
          _buildPlaceOrderButton(),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() => Text(
                  controller.deliveryAddress.value,
                  style: const TextStyle(fontSize: 16),
                )),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _showAddressDialog(),
              child: const Text('Change Address'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.payment, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() => Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Cash on Delivery'),
                      value: 'Cash on Delivery',
                      groupValue: controller.paymentMethod.value,
                      onChanged: (value) =>
                          controller.updatePaymentMethod(value!),
                    ),
                    RadioListTile<String>(
                      title: const Text('Credit/Debit Card'),
                      value: 'Card',
                      groupValue: controller.paymentMethod.value,
                      onChanged: (value) =>
                          controller.updatePaymentMethod(value!),
                    ),
                    RadioListTile<String>(
                      title: const Text('PayPal'),
                      value: 'PayPal',
                      groupValue: controller.paymentMethod.value,
                      onChanged: (value) =>
                          controller.updatePaymentMethod(value!),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInstructionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.note, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Delivery Instructions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Add any special delivery instructions...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) =>
                  controller.updateDeliveryInstructions(value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(() => Column(
                  children: controller.cartController.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.quantity}x ${item.foodItem.name}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            '€${item.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Obx(() => Text(
                      '€${controller.cartController.subtotal.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Fee'),
                Obx(() => Text(
                      '€${controller.cartController.deliveryFee.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(() => Text(
                      '€${controller.cartController.total.value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Obx(() => SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.isProcessing.value
                    ? null
                    : () => controller.placeOrder(),
                child: controller.isProcessing.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            )),
      ),
    );
  }

  void _showAddressDialog() {
    final textController = TextEditingController(
      text: controller.deliveryAddress.value,
    );

    Get.defaultDialog(
      title: 'Delivery Address',
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.updateDeliveryAddress(textController.text);
        Get.back();
      },
    );
  }
}

