import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/app_text_form_field.dart';

class AddressStep extends StatefulWidget {
  const AddressStep({
    super.key,
    required this.formKey,
    required this.valueNotifier,
  });

  final GlobalKey<FormState> formKey;
  final ValueListenable<AutovalidateMode> valueNotifier;

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var order = context.read<OrderEntity>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: widget.valueNotifier,
        builder: (context, value, child) => Form(
          key: widget.formKey,
          autovalidateMode: value,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              AppTextFormField(
                hintText: 'الاسم كامل',
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                showShadow: false,
                onSaved: (name) {
                  order.shippingAddress!.name = name;
                },
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                hintText: 'البريد الإلكتروني',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                showShadow: false,
                onSaved: (email) {
                  order.shippingAddress!.email = email;
                },
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                hintText: 'العنوان',
                textInputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                showShadow: false,
                onSaved: (address) {
                  order.shippingAddress!.address = address;
                },
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                hintText: 'المدينه',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                showShadow: false,
                onSaved: (city) {
                  order.shippingAddress!.city = city;
                },
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                hintText: 'رقم الطابق , رقم الشقه ..',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                showShadow: false,
                onSaved: (addressDetails) {
                  order.shippingAddress!.addressDetails = addressDetails;
                },
              ),
              const SizedBox(height: 12),
              AppTextFormField(
                hintText: 'رقم الهاتف',
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                showShadow: false,
                onSaved: (phone) {
                  order.shippingAddress!.phone = phone;
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
