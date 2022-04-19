import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enable;
  final Widget suffixIcon;
  final VoidCallback? suffixIconFunction;
  final Widget prefixIcon;
  final VoidCallback? prefixIconFunction;
  final String? Function(String?)? function;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.enable = true,
    required this.suffixIcon,
    required this.prefixIcon,
    this.suffixIconFunction,
    this.prefixIconFunction,
    this.function,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      cursorColor: kBlack,
      cursorWidth: 2.0,
      cursorHeight: 20.0,
      style: const TextStyle(
        color: kBlack,
        fontSize: 13,
      ),
      validator: widget.function,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: widget.isPassword
              ? () {
                  setState(() {
                    hideShow = !hideShow;
                  });
                }
              : widget.suffixIconFunction,
          child: widget.suffixIcon,
        ),
        prefixIcon:
            InkWell(onTap: widget.prefixIconFunction, child: widget.prefixIcon),
        label: Text(widget.label),
        labelStyle: TextStyle(color: kBlack.withOpacity(0.5)),
        // hintText: widget.hintText,
        // hintStyle: const TextStyle(color: kBlack),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 2,
            color: kWhite,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 2,
            color: kWhite,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 2,
            color: kWhite,
          ),
        ),
      ),
      obscureText: widget.isPassword ? hideShow : false,
      keyboardType: widget.keyboardType,
    );
  }
}
