import 'package:flutter/material.dart'
  show StatelessWidget, Widget, BuildContext, Key, required,
  PreferredSizeWidget, Container, Size, Alignment, Theme, EdgeInsets,
  ListView, Brightness, Colors, Navigator, IndexedWidgetBuilder, Column, Center, Icon, Icons,
  MainAxisAlignment, CrossAxisAlignment
;
import 'package:mywallet/Controller/Controller.dart' show Controller;
import 'X.dart';
import 'package:provider/provider.dart' show Provider;

class ControllerBuilder extends StatelessWidget{

  final Widget Function(BuildContext context, Controller controller) builder;

  ControllerBuilder({
    Key key,
    @required this.builder
  }) : super(key: key);

  Widget build(BuildContext context) => this.builder(context, Provider.of<Controller>(context));
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  final Widget title;
  final Widget leading;
  final Widget trailing;
  final double _height = 50;
  
  const TopBar({
    Key key,
    @required this.title,
    this.leading,
    this.trailing
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(this._height);

  Widget build(BuildContext context) {

    print("build TopBar");
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 24),
      child: ControllerBuilder(
        builder: (context, controller) =>
        XListTile(
          title: this.title,
          leading: this.leading,
          trailing: this.trailing,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build HomeBody");
    return ControllerBuilder(
      builder: (context, controller) {
        if (controller.getLengthWallet() > 0) return ListView.builder(
          itemCount: controller.getLengthWallet(),
          itemBuilder: (context, index) {
            String name = controller.getNameWallet(index);
            return WalletCard(name);
          },
        );
        else return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.do_not_disturb, size: 64, color: Theme.of(context).disabledColor,),
              XText("No Wallet Found", size: 24, color: Theme.of(context).disabledColor)
            ],
          ),
        );
      },
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard(this._walletName, {Key key}) : super(key: key);

  final String _walletName;

  @override
  Widget build(BuildContext context) {

    print("build WalletCard");
    return XCard(
      children: <Widget>[
        XListTile(
          title: ControllerBuilder(
            builder: (context, controller) => XText(this._walletName, 
              size: 18, isBold: true
            )
          ),
          trailing: ControllerBuilder(
            builder: (context, controller) => XText(controller.getValueWallet(this._walletName))
          ),
        ),
        ControllerBuilder(
          builder: (context, controller) => ColumnBuilder(
            itemCount: controller.getLengthDetailWallet(this._walletName),
            itemBuilder: (context, index) {
              String name = controller.getNameDetailWallet(this._walletName, index);
              String value = controller.getValueDetailWallet(this._walletName, name);
              return XListTile(
                title: XText(name),
                trailing: XText(value),
                isBorder: true,
              );
            },
          )
        ),
        XButton(
          margin: 6,
          child: XText("See Details",
            color: (Theme.of(context).accentColorBrightness == Brightness.dark) ? Colors.white : Colors.black,
          ),
          color: Theme.of(context).accentColor,
          height: 40,
          isBorder: true,
          onTap: () => Navigator.pushNamed(context, '/details', arguments: this._walletName),
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
    return new Column(
      children: new List.generate(
        this.itemCount, (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}
