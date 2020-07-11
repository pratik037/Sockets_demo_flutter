import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketsapp/utility.dart';

class SocketDemo extends StatefulWidget {
  final String title = 'Chat Screen';
  final UtilityService utilService;

  const SocketDemo({Key key, this.utilService}) : super(key: key);
  @override
  _SocketDemoState createState() => _SocketDemoState();
}

class _SocketDemoState extends State<SocketDemo> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    this.widget.utilService.connectWebSocketChannel();
  }  

  @override
  void dispose() {
    this.widget.utilService.channel.sink.close();
    _textEditingController.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    var utilService = this.widget.utilService;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
                stream: utilService.channel.stream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.all(24),
                    // child: utilService.isTyping ? Text("Typing") : 
                    child: Text(snapshot.hasData? '${snapshot.data}' : ''),
                  );
                }),
            InputUserMessage(textEditingController: _textEditingController),
          ],
        ),
      ),
    );
  }
}

class InputUserMessage extends StatelessWidget {
  const InputUserMessage({
    Key key,
    @required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController, super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 10,
        child: TextField(
          controller: _textEditingController,
          // onTap: (){
            // Provider.of<UtilityService>(context, listen: false).typing();
          // },
          // onChanged: (String text){
          //   Provider.of<UtilityService>(context).typing();
          // },
          // onEditingComplete: (){
          //   Provider.of<UtilityService>(context, listen: false).doneTyping();
          // },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6)),
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Message'),
        ),
      ),
      Flexible(
        flex: 1,
          child: Container(
        child: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            // Provider.of<UtilityService>(context, listen: false).doneTyping();
            Provider.of<UtilityService>(context, listen: false).channel.sink.add(_textEditingController.text);
            _textEditingController.clear();
            // Provider.of<UtilityService>(context).sendMessage(_textEditingController.text);
          },
        ),
      ))
    ]);
  }
}
