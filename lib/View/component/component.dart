import 'package:flutter/material.dart';
import 'package:mywallet/model/model.dart';
import 'package:mywallet/share.dart';

part 'xtopbar.dart';
part 'xcard.dart';
part 'xtextfield.dart';
part 'xbox.dart';
part 'xtopprogressindicator.dart';

class XSnackBar extends SnackBar {
  XSnackBar({
    Key key,
    String contentText,
    String buttonText,
    double elevation,
    EdgeInsets margin,
    EdgeInsets padding,
    void Function() onPressed
  }) : super(
    key: key,
    content: Text(contentText),
    action: SnackBarAction(label: buttonText, onPressed: onPressed),
    margin: margin,
    padding: padding,
    elevation: elevation,
  );
}

class WalletCard<T> extends StatelessWidget {
  
  const WalletCard(this._wallet, {
    Key key,
    this.blocStream
  }) : super(key: key);

  final Wallet _wallet;
  final Stream<T> blocStream;

  @override
  Widget build(BuildContext context) {
    return XCard(
      child: Column(
        children: [
        ListTile(
          title: StreamBuilder<T>(
            stream: blocStream,
            builder: (context, snapshot) => Text(_wallet.name)
          ),
          trailing: StreamBuilder<T>(
            stream: blocStream,
            builder: (context, snapshot) => Text(snapshot.data as String)
          ),
        ),
        StreamBuilder<T>(
          stream: blocStream,
          builder: (context, snapshot) => ColumnBuilder(
            itemCount: snapshot.data as int,
            itemBuilder: (context, index) {
              const String name = "";
              const String value = "";
              return const ListTile(
                title: Text(name),
                trailing: Text(value),
              );
            },
          )
        ),
        FlatButton(
          color: Theme.of(context).accentColor,
          height: 40,
          onPressed: () => Navigator.pushNamed(context, '/detailswallet', arguments: _wallet),
          child: const Text("See Details",),
        ),

      ],)
    );
  }
}

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment,
    this.crossAxisAlignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: List.generate(
        itemCount, (index) => itemBuilder(context, index)).toList(),
    );
  }
}
