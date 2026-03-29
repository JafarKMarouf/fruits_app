import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/widgets/app_text_form_field.dart';

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
  bool get wantKeepAlive => true;

  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final order = context.read<OrderInputEntity>();

    return ValueListenableBuilder<AutovalidateMode>(
      valueListenable: widget.valueNotifier,
      builder: (context, autovalidateMode, _) => Form(
        key: widget.formKey,
        autovalidateMode: autovalidateMode,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _fields(order)
                .map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppTextFormField(
                      label: f.label,
                      hintText: f.hint,
                      textInputType: f.inputType,
                      textInputAction: f.inputAction,
                      showShadow: false,
                      onSaved: f.onSaved,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// ─── Field config ─────────────────────────────────────────────────────────────

class _FieldConfig {
  const _FieldConfig({
    required this.label,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.onSaved,
  });

  final String label;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final void Function(String?) onSaved;
}

List<_FieldConfig> _fields(OrderInputEntity order) => [
  _FieldConfig(
    label: 'الاسم كامل',
    hint: 'أدخل اسمك كامل',
    inputType: TextInputType.name,
    inputAction: TextInputAction.next,
    onSaved: (v) => order.shippingAddress!.name = v,
  ),
  _FieldConfig(
    label: 'البريد الإلكتروني',
    hint: 'example@email.com',
    inputType: TextInputType.emailAddress,
    inputAction: TextInputAction.next,
    onSaved: (v) => order.shippingAddress!.email = v,
  ),
  _FieldConfig(
    label: 'رقم الهاتف',
    hint: '0963xxxxxxxxx',
    inputType: TextInputType.phone,
    inputAction: TextInputAction.next,
    onSaved: (v) => order.shippingAddress!.phone = v,
  ),
  _FieldConfig(
    label: 'المحافظة',
    hint: 'مثال: طرطوس',
    inputType: TextInputType.text,
    inputAction: TextInputAction.next,
    onSaved: (v) => order.shippingAddress!.state = v,
  ),
  _FieldConfig(
    label: 'المدينة',
    hint: 'اسم المدينة',
    inputType: TextInputType.text,
    inputAction: TextInputAction.done,
    onSaved: (v) => order.shippingAddress!.city = v,
  ),
];
