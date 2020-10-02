part of 'component.dart';

class XTopBar extends AppBar {
  
  XTopBar({
    Key key,
    Widget title,
    Widget leading,
    List<Widget> actions,
    Color backgroundColor,
    bool isLoading = false,
    bool centerTitle = false,
    Stream<bool> isLoadingStream  
  }) : super(
    key: key,
    backgroundColor: backgroundColor ?? mainColor,
    elevation: 0,
    title: title,
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,
    bottom: isLoading ? XTopLinearProgressIndicator(stream: isLoadingStream,) : null
  );
}