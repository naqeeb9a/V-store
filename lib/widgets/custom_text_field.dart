import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;

  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enable;
  final Widget? suffixIcon;
  final VoidCallback? suffixIconFunction;
  final Widget? prefixIcon;
  final VoidCallback? prefixIconFunction;
  final String? Function(String?)? function;
  final Color boundaryColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.enable = true,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconFunction,
    this.prefixIconFunction,
    this.function,
    this.boundaryColor = noColor,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideShow = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        enabled: widget.enable,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        cursorColor: kBlack,
        cursorWidth: 2.0,
        textAlign: TextAlign.start,
        cursorHeight: 20.0,
        style: const TextStyle(
          color: kBlack,
          fontSize: 13,
        ),
        validator: widget.function,
        decoration: InputDecoration(
          fillColor: kGrey.withOpacity(0.3),
          filled: true,
          suffixIcon: widget.suffixIcon == null
              ? null
              : InkWell(
                  onTap: widget.isPassword
                      ? () {
                          setState(() {
                            hideShow = !hideShow;
                          });
                        }
                      : widget.suffixIconFunction,
                  child: widget.suffixIcon,
                ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : InkWell(
                  onTap: widget.prefixIconFunction, child: widget.prefixIcon),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kBlack.withOpacity(0.6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
            borderSide: BorderSide(
              width: 2,
              color: widget.boundaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
            borderSide: BorderSide(
              width: 2,
              color: widget.boundaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
            borderSide: BorderSide(
              width: 2,
              color: widget.boundaryColor,
            ),
          ),
        ),
        obscureText: widget.isPassword ? hideShow : false,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
