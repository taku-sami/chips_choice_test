import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:async/async.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ChipsChoice',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tag = 1;
  List<String> tags = [];

  List<String> options = [
    '育成牛すべて',
    '3ヶ月未満',
    '3ヶ月〜6ヶ月',
    '7〜9ヶ月',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ChipsChoice'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
//            onPressed: () => _about(context),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Content(
            title: '表示する育成牛を選択してください',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tag = val),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool selected) onSelect;

  CustomChip(this.label, this.selected, this.onSelect, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 70,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
                visible: selected,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 32,
                )),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

//void _about(BuildContext context) {
//  showDialog(
//    context: context,
//    builder: (_) => Dialog(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          ListTile(
//            title: Text(
//              'chips_choice',
//              style: Theme.of(context)
//                  .textTheme
//                  .headline
//                  .copyWith(color: Colors.black87),
//            ),
//            subtitle: Text('by davigmacode'),
//            trailing: IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () => Navigator.pop(context),
//            ),
//          ),
//          Flexible(
//            fit: FlexFit.loose,
//            child: Container(
//              padding: EdgeInsets.symmetric(horizontal: 15),
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Text(
//                    'Easy way to provide a single or multiple choice chips.',
//                    style: Theme.of(context)
//                        .textTheme
//                        .body1
//                        .copyWith(color: Colors.black54),
//                  ),
//                  Container(height: 15),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}
