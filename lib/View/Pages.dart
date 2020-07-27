import 'package:flutter/material.dart' 
  show StatelessWidget, Key, Widget, BuildContext,
  Scaffold, Icon, Icons, Navigator, TextEditingController,
  Padding, EdgeInsets, TextField, InputDecoration, Theme, showDialog,
  AlertDialog, TextInputType, ListView, Container, Divider, CrossAxisAlignment,
  Row, Spacer, Drawer, Column, Alignment, CircleAvatar, AssetImage;
import 'package:toast/toast.dart' show Toast;
import 'package:mywallet/Controller/Controller.dart' show Controller;
import 'package:mywallet/View/Component.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:mywallet/View/X.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).cardColor,
              height: 200,
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: AssetImage("assets/img/profile.jpg"),
              ),
            ),
            XText("About Developer"),
            XListTile(leading: XText("Name:"), title: XText("Rizky Eky"),),
            XListTile(title: XText("mochamad.rizky.darmawan"), subtitle: XText("@gmail.com"), height: 72,),
            XListTile(title: XText("github.com/rizkyeky"))
          ],
        ),
      ),
      appBar: TopBar(
        title: ControllerBuilder(builder: (child, controller) => XText(
          controller.getValues(), isBold: true, size: 18,
        )),
        leading: const Icon(Icons.account_balance_wallet),
        trailing: XButton(
          child: Icon(Icons.add),
          onTap: () => Navigator.pushNamed(context, '/input'),
        ),  
      ),
      body: HomeBody(),
    );
  }
}

class InputWallet extends StatelessWidget {
  InputWallet({Key key}) : super(key: key);

  final TextEditingController _editingController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: const XText("Input"),
        leading: const Icon(Icons.account_balance_wallet),
        trailing: XButton(
          child: Icon(Icons.check),
          onTap: () {
            if (this._editingController.text.isNotEmpty) {
              Provider.of<Controller>(context, listen: false).addWalletWithName(this._editingController.text);
              Navigator.of(context).pop();
            }
            else {
              Toast.show("Wallet name cannot empty", context, 
                backgroundColor: Theme.of(context).errorColor,
                gravity: Toast.CENTER
              );
            }
          },
        ),  
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ControllerBuilder(
          builder: (context, controller) => TextField(
            controller: _editingController,
            onSubmitted: (value) {
              if (this._editingController.text.isNotEmpty) {
                Provider.of<Controller>(context, listen: false).addWalletWithName(this._editingController.text);
                Navigator.of(context).pop();
              }
              else {
                Toast.show("Wallet name cannot empty", context, 
                  backgroundColor: Theme.of(context).errorColor,
                  gravity: Toast.CENTER
                );
              }
            },
            decoration: InputDecoration(
              labelText: "Wallet Name",
              fillColor: Theme.of(context).cardColor,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  Details(this._walletName, {Key key}) : super(key: key);

  final String _walletName;
  final TextEditingController _textNameController = new TextEditingController(text: "");
  final TextEditingController _textValueController = new TextEditingController(text: "");

  void _showDialog(BuildContext context, String name, String walletName, String detailName) {

    final TextEditingController _textNumController = new TextEditingController(text: "");
    final controller = Provider.of<Controller>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          title: XText(name, size: 20, isBold: true,),
          content: (name !=  "Delete") ? TextField(
            keyboardType: TextInputType.number,
            controller: _textNumController,
            decoration: InputDecoration(hintText: "Input value"),
          ) : XText("Are you sure want to delete this item ?"),
          actions: <Widget>[
            XButton(
              child: XText('Cancel', size: 18,),
              onTap: () => Navigator.of(context).pop(),
              width: 80,
              height: 40,
            ),
            XButton(
              child: XText((name != "Delete") ? "Submit" : "Sure", size: 18, color: Theme.of(context).primaryColorDark,),
              onTap: () {
                if (name == "Delete")
                  controller.deleteDetailWallet(walletName, detailName);
                else {
                  int value = int.parse(_textNumController.text);
                  if (name == "Increment") controller.incrementValueDetailWallet(walletName, detailName, value);
                  else if (name == "Decrement") controller.decrementValueDetailWallet(walletName, detailName, value);
                  else if (name == "Edit") controller.setValueDetailWallet(walletName, detailName, value);
                }
                Navigator.of(context).pop();
              },
              color: Theme.of(context).accentColor,
              width: 80,
              height: 40,
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context, listen: false);
    
    print("build Details");
    return Scaffold(
      appBar: TopBar(
        title: XText(this._walletName, isBold: true,),
        leading: XButton(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
            // controller.updateValues();
          },
        ),
        trailing: XButton(child: Icon(Icons.delete), onTap: () {
          Navigator.of(context).pop();
          controller.deleteWallet(this._walletName);
        },)
      ),
      body: ListView(
        children: <Widget>[
          Container(
          margin: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
            child: TextField(
              controller: _textNameController,
              decoration: InputDecoration(
                labelText: "Detail Name",
                fillColor: Theme.of(context).cardColor,
                filled: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
            child: ControllerBuilder(
              builder: (context, controller) => TextField(
                keyboardType: TextInputType.number,
                controller: _textValueController,
                decoration: InputDecoration(
                  labelText: "Value",
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                ),
              ),
            ),
          ),
          XButton(
            height: 40,
            margin: 12,
            child: XText("Add Detail", color: Theme.of(context).primaryColorDark,), 
            color: Theme.of(context).accentColor,
            onTap: () {
              if (this._textNameController.text.isNotEmpty && this._textValueController.text.isNotEmpty) { 
                String name = this._textNameController.text;
                int value = int.parse(this._textValueController.text);
                controller.addDetailWallet(this._walletName, name, value);
              }
              else {
                Toast.show("Detail name cannot empty", context, 
                  backgroundColor: Theme.of(context).errorColor,
                  gravity: Toast.CENTER
                );
              }
            }, 
          ),
          Divider(),
          ControllerBuilder(
            builder: (_, controller) => ColumnBuilder(
              itemCount: controller.getLengthDetailWallet(this._walletName),
              itemBuilder: (context, index) {
                String name = controller.getNameDetailWallet(this._walletName, index);
                String value = controller.getValueDetailWallet(this._walletName, name);
                return XCard(
                  margin: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    XListTile(
                      title: XText(name, isBold: true,),
                      trailing: XText(value),
                    ),
                    Divider(thickness: 2,),
                    Row(
                      children: <Widget>[
                        XButton(child: Icon(Icons.add), 
                          onTap: () => this._showDialog(context, "Increment", this._walletName, name), 
                          width: 30, height: 30, margin: 12,
                        ),
                        XButton(child: Icon(Icons.remove), 
                          onTap: () => this._showDialog(context, "Decrement", this._walletName, name), 
                          width: 30, height: 30, margin: 12,
                        ),
                        XButton(child: Icon(Icons.edit), 
                          onTap: () => this._showDialog(context, "Edit", this._walletName, name), 
                          width: 30, height: 30, margin: 12,
                        ),
                        Spacer(),
                        XButton(child: Icon(Icons.delete), 
                          onTap: () => this._showDialog(context, "Delete", this._walletName, name), 
                          width: 30, height: 30, margin: 12,
                        ),
                      ]
                    ),
                  ],
                );
              }, 
            ),
          ),
        ],
      ),
    );
  }
}