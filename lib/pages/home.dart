import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:minigamesparty/pages.dart';
import 'package:minigamesparty/pages/connect.dart';
import 'package:minigamesparty/pages/create.dart';
import 'package:minigamesparty/pages/intro.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = [WelcomePage(), CreatePage(), ConnectPage()];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: TabBarView(
            children: _tabs,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: ConvexAppBar(
            curve: Curves.ease,
            items: [
              TabItem(icon: MdiIcons.homeOutline, title: "Home"),
              TabItem(
                  icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF5722),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 40),
              )),
              TabItem(icon: MdiIcons.menu, title: "Join")
            ],
            style: TabStyle.fixedCircle,
            onTabNotify: (i) {
              var intercept = i == 1;
              if (intercept) Navigator.pushNamed(context, RoutePages.create);
              return !intercept;
            },
          ),
        ));
  }
}