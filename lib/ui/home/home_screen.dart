import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme_provider/theme_changer.dart';

import './grid_details.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool darktheme = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pocket Campus'),
        actions: <Widget>[
          IconButton(
            icon: darktheme
                ? Icon(
                    Icons.wb_incandescent,
                    color: Colors.purple,
                  )
                : Icon(
                    Icons.wb_incandescent,
                    color: Colors.yellowAccent,
                  ),
            onPressed: () {
              if (darktheme == false) {
                themeChanger.setTheme(ThemeMode.dark);
                setState(() {
                  darktheme = true;
                });
                print(darktheme);
              } else {
                themeChanger.setTheme(ThemeMode.light);
                setState(() {
                  darktheme = false;
                });
              }
            },
          )
        ],
      ),
      body: Container(
        height: mediaQuery.size.height * 0.9,
        width: mediaQuery.size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: mediaQuery.size.height * 0.3,
              width: mediaQuery.size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: darktheme
                      ? [Colors.grey.shade900, Colors.grey.shade900]
                      : [Colors.blue, Colors.indigoAccent],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ColorFiltered(
                  colorFilter: darktheme
                      ? ColorFilter.mode(Colors.white, BlendMode.color)
                      : ColorFilter.mode(Colors.white , BlendMode.darken),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkaqXbA0rN7lUU5jqZwCgKzk8vEOpdZv1FVPVEuDKoFylXpwJt&usqp=CAU',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Consumer<GridDetails>(
                builder: (context, gridDetails, child) => GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: gridDetails.texts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemBuilder: (ctx, index) => InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(gridDetails.className[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: darktheme
                              ? [Colors.grey.shade900, Colors.grey.shade900]
                              : [Colors.blue, Colors.indigoAccent],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            gridDetails.icons[index],
                            color: Colors.white,
                          ),
                          Text(
                            '${gridDetails.texts[index]}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
