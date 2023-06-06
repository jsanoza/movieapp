import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';
import '../../../translations/app_translations.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    this.hintText,
    this.errorText,
    this.obscureText,
    this.enabled,
    this.textInputType,
    this.maxLength,
    required this.controller,
  }) : super(key: key);
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final bool? enabled;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController controller;
  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final RxBool _obscureText = false.obs;
  @override
  void initState() {
    super.initState();
    _obscureText.value = widget.obscureText ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.neutral6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(
              () => TextField(
                maxLength: widget.maxLength ?? widget.maxLength,
                keyboardType: widget.textInputType ?? widget.textInputType,
                enabled: widget.enabled ?? widget.enabled,
                style: TextStyle(color: Colors.black),
                controller: widget.controller,
                obscureText: _obscureText.value,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: AppTextStyles.base.neutral3Color.s14,
                  suffixIcon: widget.obscureText != false
                      ? GestureDetector(
                          onTap: () => _obscureText.value = !_obscureText.value,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _obscureText.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          ),
                        )
                      : const SizedBox(),
                  suffixIconConstraints: const BoxConstraints(
                    maxWidth: 32,
                  ),
                ),
              ),
            ),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                top: 4,
              ),
              child: Text(
                widget.errorText ?? AppTranslationKey.noEmpty,
                style: AppTextStyles.base.s14.redColor,
              ),
            ),
        ],
      ),
    );
  }
}
