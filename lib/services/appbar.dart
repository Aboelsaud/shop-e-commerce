import '../libraries.dart';

class Appbar extends StatefulWidget {
  int itemCount;
  Function search;
  Appbar(this.itemCount, this.search);
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  bool isBigScreen = false;
  bool fieldChange = false;
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (isBigScreen) ? 270 : 150,
          height: 40,
          child: TextField(
            onChanged: (txt) {
              widget.search(txt);
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2,
                  )),
              border: InputBorder.none,
              hintText: "Search",
              icon: Icon(Icons.search),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(widget.itemCount)));
          },
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.blueGrey,
              ),
              SizedBox(width: 5),
              Text("Cart ${widget.itemCount}",
                  style: TextStyle(
                    fontSize: isBigScreen ? 15 : 12,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
