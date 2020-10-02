part of 'page.dart';

class DetailWalletPage extends StatelessWidget {
  DetailWalletPage(this._walletName, {Key key}) : super(key: key);

  final String _walletName;
  final TextEditingController _textNameController = TextEditingController(text: "");
  final TextEditingController _textValueController = TextEditingController(text: "");

  void _showDialog(BuildContext context, String name, String walletName, String detailName) {

    final TextEditingController _textNumController = TextEditingController(text: "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          title: Text(name),
          content: (name !=  "Delete") ? TextField(
            keyboardType: TextInputType.number,
            controller: _textNumController,
            decoration: const InputDecoration(hintText: "Input value"),
          ) : const Text("Are you sure want to delete this item ?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              height: 40,
              child: const Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                if (name == "Delete") {

                }
                else {
                Navigator.of(context).pop();
              }},
              child: Text((name != "Delete") ? "Submit" : "Sure"),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTopBar(
        textTitle: _walletName,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // controller.updateValues();
          },
        ),
        trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {
          Navigator.of(context).pop();
        },)
      ),
      body: ListView(
        children: <Widget>[
          Container(
          margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
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
            margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: ValueListenableBuilder(
              valueListenable: ValueNotifier<String>(""),
              builder: (context, controller, child) => TextField(
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
          FlatButton(
            height: 40,
            color: Theme.of(context).accentColor,
            onPressed: () {
              if (_textNameController.text.isNotEmpty && _textValueController.text.isNotEmpty) { 
                final String name = _textNameController.text;
                final int value = int.parse(_textValueController.text);
              }
              else {
              }
            }, 
            child: const Text("Add Detail"), 
          ),
          const Divider(),
          ValueListenableBuilder<String>(
            valueListenable: ValueNotifier<String>(""),
            builder: (_, value, child) => ColumnBuilder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return XCard(
                  children: <Widget>[
                    ListTile(
                      title: Text(""),
                      trailing: Text(value),
                    ),
                    Divider(thickness: 2,),
                    Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.add), 
                          onPressed: () => _showDialog(context, "Increment", _walletName, ""), 
                        ),
                        IconButton(icon: Icon(Icons.remove), 
                          onPressed: () => _showDialog(context, "Decrement", _walletName, ""), 
                        ),
                        IconButton(icon: Icon(Icons.edit), 
                          onPressed: () => _showDialog(context, "Edit", _walletName, ""), 
                        ),
                        Spacer(),
                        IconButton(icon: Icon(Icons.delete), onPressed: (){}),
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