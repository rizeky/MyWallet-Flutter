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

class XDialog extends StatelessWidget {

  final String name;
  final void Function(String commit, int value) onSubmit;
  final void Function() onCancel;

  const XDialog({
    Key key,
    this.name,
    this.onSubmit,
    this.onCancel
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final TextEditingController _textCommitController = TextEditingController();
    final TextEditingController _textNumController = TextEditingController();

    return AlertDialog(
      elevation: 0,
      title: Text(name),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: _textCommitController,
              decoration: const InputDecoration(hintText: "Input commit"),
            ),
            const SizedBox(height: 12,),
            TextField(
              keyboardType: TextInputType.number,
              controller: _textNumController,
              decoration: const InputDecoration(hintText: "Input value"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (onCancel != null) onCancel();
            Navigator.of(context).pop();
          },
          height: 40,
          child: const Text('CANCEL'),
        ),
        FlatButton(
          color: mainColor,
          onPressed: () {
            if (onSubmit != null) onSubmit(_textCommitController.text, int.parse(_textNumController.text));
            Navigator.of(context).pop();
          },
          child: const Text("SUBMIT"),
        )
      ],
    );
  }
}

class WalletCard extends StatelessWidget {
  
  const WalletCard(this._wallet, {
    Key key,
    this.onSubmit
  }) : super(key: key);

  final void Function(String, int) onSubmit;
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
              onPressed: () => showDialog(
                context: context, 
                builder: (context) => XDialog(
                  name: _wallet.name, 
                  onSubmit: (commit, value) {
                    
                  },) 
                ),
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
                  leading: (value < 0) ? const Icon(Icons.remove, color: Colors.red,) 
                    : const Icon(Icons.add, color: Colors.green),
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
