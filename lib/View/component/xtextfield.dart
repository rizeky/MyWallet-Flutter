part of 'component.dart';

class XTextField extends StatelessWidget {

  final String labelText;
  final TextStyle labelStyle;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;

  const XTextField({ 
  Key key,
  this.labelText,
  this.labelStyle,
  this.controller,
  this.obscureText,
  this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: mainColor,
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        fillColor: blackColor,
        labelText: labelText,
        labelStyle: labelStyle ?? whiteSubtitle,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: mainColor,
            width: 3
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: accentColor,
            width: 3
          )
        ),
      ),
    );
  }
}