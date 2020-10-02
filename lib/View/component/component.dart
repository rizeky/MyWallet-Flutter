import 'package:flutter/material.dart';
import 'package:mywallet/share.dart';
import '../X.dart';

part 'xtopbar.dart';
part 'xcard.dart';

SnackBar snackBar({
  String contentText, String labelText, VoidCallback onPressed
}) => SnackBar(
  content: Text(contentText),
  action: SnackBarAction(
    label: labelText,
    onPressed: onPressed,
  ),
);

class WalletCard<T> extends StatelessWidget {
  
  const WalletCard(this._walletName, {
    Key key,
    this.blocStream
  }) : super(key: key);

  final String _walletName;
  final Stream<T> blocStream;

  @override
  Widget build(BuildContext context) {
    return XCard(
      children: <Widget>[
        XListTile(
          title: StreamBuilder<T>(
            stream: blocStream,
            builder: (context, snapshot) => XText(_walletName, 
              size: 18, isBold: true
            )
          ),
          trailing: StreamBuilder<T>(
            stream: blocStream,
            builder: (context, snapshot) => XText(snapshot.data as String)
          ),
        ),
        StreamBuilder<T>(
          stream: blocStream,
          builder: (context, snapshot) => ColumnBuilder(
            itemCount: snapshot.data as int,
            itemBuilder: (context, index) {
              const String name = "";
              const String value = "";
              return const XListTile(
                title: XText(name),
                trailing: XText(value),
                isBorder: true,
              );
            },
          )
        ),
        XButton(
          margin: 6,
          color: Theme.of(context).accentColor,
          height: 40,
          isBorder: true,
          onTap: () => Navigator.pushNamed(context, '/details', arguments: _walletName),
          child: XText("See Details",
            color: (Theme.of(context).accentColorBrightness == Brightness.dark) ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount, (index) => itemBuilder(context, index)).toList(),
    );
  }
}
