import 'package:flutter/material.dart';

final TextStyle menufontStayle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double ekranYuksekligi, ekranGenisligi;
  late bool menuAcikmi = false;
  late AnimationController _controller;
  late Animation<double> _scalAnimation;
  late Animation<double> _scalmenuAnimation;
  late Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scalAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scalmenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scalmenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: menufontStayle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Mesajlar',
                  style: menufontStayle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Utility Bills',
                  style: menufontStayle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Fund Trasfer',
                  style: menufontStayle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Branches',
                  style: menufontStayle,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikmi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikmi ? -0.4 * ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scalAnimation,
        child: Material(
          borderRadius:
              menuAcikmi ? BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (menuAcikmi) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            menuAcikmi = !menuAcikmi;
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'My Card',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.purple,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.teal,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Ögrenci : $index'),
                          trailing: Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
