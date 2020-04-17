import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:async/async.dart';

void main() => runApp(MyApp());

const MaterialColor customSwatch = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFEFEFE),
    100: const Color(0xFFFDFDFD),
    200: const Color(0xFFFCFCFC),
    300: const Color(0xFFFBFBFB),
    400: const Color(0xFFFAFAFA),
    500: const Color(0xFFF9F9F9),
    600: const Color(0xFFF8F8F8),
    700: const Color(0xFFF7F7F7),
    800: const Color(0xFFF6F6F6),
    900: const Color(0xFFF5F5F5),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ChipsChoice',
      theme: ThemeData(
        primarySwatch: customSwatch,
        canvasColor: Colors.transparent,
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
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ChipsChoice'),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Content(
            title: 'Scrollable List Single Choice',
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
          Content(
            title: 'Scrollable List Multiple Choice',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
            ),
          ),
          Content(
            title: 'Wrapped List Single Choice',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tag = val),
              isWrapped: true,
            ),
          ),
          Content(
            title: 'Wrapped List Multiple Choice',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
              isWrapped: true,
            ),
          ),
          Content(
            title: 'Disabled Choice Item',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
                disabled: (i, v) => [0, 2, 5].contains(i),
              ),
              onChanged: (val) => setState(() => tag = val),
              isWrapped: true,
            ),
          ),
          Content(
            title: 'Hidden Choice Item',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
                hidden: (i, v) =>
                    ['Science', 'Politics', 'News', 'Tech'].contains(v),
              ),
              onChanged: (val) => setState(() => tags = val),
              isWrapped: true,
            ),
          ),
          Content(
            title: 'Append an Item to Options',
            child: ChipsChoice<int>.single(
              value: tag,
              options: ChipsChoiceOption.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              )..insert(0, ChipsChoiceOption<int>(value: -1, label: 'All')),
              onChanged: (val) => setState(() => tag = val),
            ),
          ),
          Content(
            title: 'Selected without Checkmark and Brightness Dark',
            child: ChipsChoice<int>.single(
              value: tag,
              onChanged: (val) => setState(() => tag = val),
              options: ChipsChoiceOption.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              )..insert(0, ChipsChoiceOption<int>(value: -1, label: 'All')),
              itemConfig: const ChipsChoiceItemConfig(
                showCheckmark: false,
                labelStyle: TextStyle(fontSize: 20),
                selectedBrightness: Brightness.dark,
                // unselectedBrightness: Brightness.dark,
              ),
            ),
          ),

          //以下がテーマカラーに影響されないコンテンツ
          Content(
            title: 'Works with FormField and Validator',
            child: FormField<List<String>>(
              autovalidate: true,
              initialValue: tags,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please select some categories';
                }
                if (value.length > 5) {
                  return "Can't select more than 5 categories";
                }
                return null;
              },
              builder: (state) {
                return Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: ChipsChoice<String>.multiple(
                        value: state.value,
                        options: ChipsChoiceOption.listFrom<String, String>(
                          source: options,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                        onChanged: (val) => state.didChange(val),
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Colors.indigo,
                          selectedBrightness: Brightness.dark,
                          unselectedColor: Colors.indigo,
                          unselectedBorderOpacity: .3,
                        ),
                        isWrapped: true,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.errorText ??
                              state.value.length.toString() + '/5 selected',
                          style: TextStyle(
                              color: state.hasError
                                  ? Colors.redAccent
                                  : Colors.green),
                        ))
                  ],
                );
              },
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
