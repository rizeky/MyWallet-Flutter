part of 'component.dart';

class XTextField extends StatelessWidget {

  final String text;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;

  const XTextField({ 
  Key key,
  this.text,
  this.controller,
  this.obscureText,
  this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: blackSubtitle,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: accentColor,
            width: 3
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: mainColor,
            width: 3
          )
        ),
      ),
    );
  }
}