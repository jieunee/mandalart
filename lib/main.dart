import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade600,
          title: const Text(
            'Mandalart',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[200],
              boxShadow: const [
                BoxShadow(blurRadius: 3, offset: Offset(1, 1)),
              ],
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var cId = 1; cId <= 3; cId++)
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var vId = 1; vId <= 3; vId++)
                          const Expanded(
                            flex: 1,
                            child: SecondGroup(),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondGroup extends StatelessWidget {
  const SecondGroup({
    Key? key,
  }) : super(key: key);

  final BorderRadius borderTopLeft = const BorderRadius.only(
    topLeft: Radius.circular(10),
  );
  final BorderRadius borderTopRight = const BorderRadius.only(
    topRight: Radius.circular(10),
  );
  final BorderRadius borderBottomLeft = const BorderRadius.only(
    bottomLeft: Radius.circular(10),
  );
  final BorderRadius borderBottomRight = const BorderRadius.only(
    bottomRight: Radius.circular(10),
  );
  final BorderRadius borderNormal = const BorderRadius.all(Radius.zero);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber.shade600,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
        ),
        boxShadow: const [
          BoxShadow(blurRadius: 3, offset: Offset(1, 1)),
        ],
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var cId = 1; cId <= 3; cId++)
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var rId = 1; rId <= 3; rId++)
                    Expanded(
                      flex: 1,
                      child: SmallCell(
                        color: (rId == 2 && cId == 2)
                            ? Colors.amber.shade800
                            : Colors.amber.shade300,
                        borderRadius: getRadius(rId, cId),
                        content: Text("Cell id[$cId][$rId]"),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  BorderRadius getRadius(var rid, var cid) {
    if (cid == 1) {
      if (rid == 1) {
        return borderTopLeft;
      } else if (rid == 3) {
        return borderTopRight;
      } else {
        return borderNormal;
      }
    } else if (cid == 3) {
      if (rid == 1) {
        return borderBottomLeft;
      } else if (rid == 3) {
        return borderBottomRight;
      } else {
        return borderNormal;
      }
    }
    return borderNormal;
  }
}

class SmallCell extends StatefulWidget {
  const SmallCell({
    Key? key,
    required this.content,
    required this.color,
    required this.borderRadius,
  }) : super(key: key);

  final Widget content;
  final Color color;
  final Color colorTap = Colors.red;
  final BorderRadius borderRadius;

  @override
  State<SmallCell> createState() => _SmallCellState();
}

class _SmallCellState extends State<SmallCell> {
  late double _width;
  late double _height;

  late Color normal;
  late Color hover;
  late Color current;

  @override
  void initState() {
    super.initState();
    _width = 80;
    _height = 80;
    normal = widget.color;
    hover = Colors.red;
    current = normal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        if (value) {
          current = hover;
        } else {
          current = normal;
        }
        setState(() {});
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: current,
          boxShadow: const [
            BoxShadow(blurRadius: 3, offset: Offset(1, 1)),
          ],
        ),
        padding: const EdgeInsets.all(1),
        margin: const EdgeInsets.all(1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Center(
          child: widget.content,
        ),
      ),
    );
  }
}
