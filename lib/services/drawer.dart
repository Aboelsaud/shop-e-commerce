import '../libraries.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  bool isBigScreen = false;
  final db = FirebaseFirestore.instance;
  Size screenSize;
  int itemCount;

  void getCount(int count) {
    setState(() {
      itemCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
    });
    db.collection('cart').get().then((value) => getCount(value.docs.length));

    Widget button(String title, Function f) {
      return OutlineButton(
        borderSide: BorderSide.none,
        clipBehavior: Clip.antiAlias,
        hoverColor: Colors.teal[100],
        onPressed: f,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
    }

    void home() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void accessories() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Accessories(itemCount)));
    }

    void denim() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void footwear() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void jeans() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void outerwear() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void pants() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void shirts() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void t_shirts() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    void shorts() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    return Container(
      color: Colors.white.withOpacity(0.8),
      width: (isBigScreen) ? 250 : null,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Home", home),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Accessories", accessories),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Denim", denim),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Footwear", footwear),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Jeans", jeans),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Outerwear", outerwear),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Pants", pants),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Shirts", shirts),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("T-Shirts", t_shirts),
            SizedBox(height: 10),
            Divider(thickness: 0.1, height: 2),
            SizedBox(height: 10),
            button("Shorts", shorts),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
