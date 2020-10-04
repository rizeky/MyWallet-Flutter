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

class WalletCard extends StatelessWidget {
  
  const WalletCard(this._wallet, {
    Key key,
  }) : super(key: key);

  final Wallet _wallet;

  @override
  Widget build(BuildContext context) {
    return XCard(
      color: blackColor,
      child: Column(
        children: [
          ListTile(
            title: Text(_wallet.name, style: whiteContentRegular,),
            subtitle: Text(convertCurrRP(_wallet.totalValue), style: whiteNum),
            trailing: IconButton(
              icon: Icon(Icons.add, color: whiteColor), 
              onPressed: () {},
            ),
          ),
          Divider(color: whiteColor, indent: 12, endIndent: 12, height: 0,),
          Builder(
            builder: (context) => (_wallet.details.isNotEmpty) ? ColumnBuilder(
              itemCount: _wallet.details.length,
              itemBuilder: (context, index) {
                final String name = _wallet.details.keys.toList()[index] as String;
                final int value = _wallet.details.values.toList()[index] as int;
                return ListTile(
                  leading: (value < 0) ? const Icon(Icons.remove, size: 18,) 
                    : const Icon(Icons.add, size: 18),
                  title: Text(name),
                  trailing: Text(convertCurrRP(value)),
                );
              },
            ) : Padding(padding: const EdgeInsets.all(12), 
                child: Text('No Records', style: whiteContentRegular)
              )
          ),
        ],
      )
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
