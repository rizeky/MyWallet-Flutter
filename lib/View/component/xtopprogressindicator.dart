part of 'component.dart';


class XTopLinearProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {

  final Color backgroundColor;
  final Color valueColor;
  final Stream<bool> stream;
  
  @override
  Size get preferredSize => const Size.fromHeight(6);
  
  const XTopLinearProgressIndicator({
    Key key,
    this.backgroundColor,
    this.valueColor,
    this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<bool>(
        initialData: false,
        stream: stream,
        builder: (context, snapshot) => (snapshot.data) ? LinearProgressIndicator(
          backgroundColor: backgroundColor ?? whiteColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? mainColor),
        )
        : const SizedBox(height: 6,)
      ),
    );
  }
}