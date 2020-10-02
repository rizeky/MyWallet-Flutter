part of 'component.dart';

class XBox extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final EdgeInsets margin;
  final Color borderColor;
  final Widget child;
  final EdgeInsets padding;

  const XBox({
    Key key, 
    this.text, 
    this.height, 
    this.width,
    this.child, 
    this.margin,
    this.padding,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        type: MaterialType.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 3, 
            color: borderColor ?? mainColor
          )
        ),
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: padding ?? const EdgeInsets.all(10),
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );
  }
}
