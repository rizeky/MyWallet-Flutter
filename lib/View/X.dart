import 'package:flutter/material.dart';

class XText extends StatelessWidget {
  final String _data;
  final double size;
  final Color color;
  final double padding;
  final bool isBold;

  const XText(this._data, {
    Key key, 
    this.color,
    this.size = 16,
    this.padding = 6, 
    this.isBold = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(this.padding),
    child: Text(
      this._data,
      style: TextStyle(
        fontSize: this.size, 
        fontWeight: (this.isBold) ? FontWeight.bold : FontWeight.normal, 
        color: this.color
      ),
    ),
  );
}

class XButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final bool isBorder;
  final double margin;

  const XButton({
    Key key,
    @required this.child,
    @required this.onTap,
    this.color,
    this.margin = 4,
    this.width = double.infinity,
    this.height = 64,
    this.isBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build XButton");
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(this.margin),
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxWidth:this.width,
          maxHeight: this.height
        ),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(4),
          border: (this.isBorder)
            ? Border.all(color: Theme.of(context).dividerColor)
            : null,
        ),
        child: this.child,
      ),
      onTap: this.onTap,
    );
  }
}

class XListTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final Widget subtitle;
  final Color color;
  final bool isBorder;
  final double width;
  final double height;

  const XListTile({
    Key key,
    @required this.title,
    this.leading,
    this.trailing,
    this.subtitle,
    this.color,
    this.isBorder = false,
    this.width = 40,
    this.height = 40,
  }) : super(key: key);

  List<Widget> _buildChildren() {
    Widget widget = (this.subtitle != null)
      ? Container(
        height: this.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            this.title,
            this.subtitle,
          ]
        )
      ) : this.title;

    List<Widget> ls = [];
    if (this.leading != null) {
      ls.add(this.leading);
      ls.add(Spacer(flex: 1));
    }
    
    ls.add(widget);
    ls.add(Spacer(flex: 8));
    if (this.trailing != null) ls.add(this.trailing);
    return ls;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: this.color ?? Theme.of(context).cardColor,
        border: Border(
          left: (this.isBorder)
            ? BorderSide(
              color: Theme.of(context).accentColor,
              width: 4,
            ) : BorderSide.none,
        )
      ),
      constraints:
        BoxConstraints(minWidth: this.width, minHeight: this.height),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: this._buildChildren(),
      )
    );
  }
}

class XCard extends StatelessWidget {
  final List<Widget> children;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double margin;

  const XCard({
    Key key,
    @required this.children,
    this.color,
    this.margin = 6,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build XCard");
    return Container(
      margin: EdgeInsets.only(left: this.margin, right: this.margin, top: this.margin, bottom: 0),
      decoration: BoxDecoration(
        color: this.color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4),
        border: (Theme.of(context).brightness != Brightness.dark) 
          ? Border.all(color: Theme.of(context).dividerColor)
          : null,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        children: this.children
      ),
    );
  }
}
