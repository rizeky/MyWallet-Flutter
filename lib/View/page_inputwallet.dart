part of 'page.dart';

class InputWalletPage extends Page<InputWalletBloc> {
  InputWalletPage({Key key}) : super(key: key);

  final TextEditingController _editingController = TextEditingController(text: "");

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XTopBar(
        title: Text("Input Wallet", style: whiteTitle,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            XTextField(
              labelText: 'Wallet Name',
              controller: _editingController,
            ),
          ],
        ),
      ),
    );
  }
}
