part of 'page.dart';

class InputWalletPage extends StatelessWidget {
  InputWalletPage({Key key}) : super(key: key);

  final TextEditingController _editingController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTopBar(
        textTitle: "Input",
        leading: const Icon(Icons.account_balance_wallet), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _editingController,
          onSubmitted: (value) {
            if (_editingController.text.isNotEmpty) {
            }
            else {
            
            }
          },
          decoration: InputDecoration(
            labelText: "Wallet Name",
            fillColor: Theme.of(context).cardColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}
