import '../libraries.dart';

class ShoppingCart extends StatefulWidget {
  final String title;
  final double price;
  final String id;
  final String color;
  final String size;
  final String image;
  ShoppingCart(
      this.title, this.price, this.id, this.color, this.size, this.image);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  CollectionReference item = FirebaseFirestore.instance.collection('cart');
  Size screenSize;
  bool isBigScreen = false;

  Future<void> removeItem() {
    return item.doc(widget.id).delete().then((value) => print("Item Deleted"));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
    });
    var image = Container(
      child: Image.network(
        widget.image,
        fit: BoxFit.cover,
        width: 150,
        height: (isBigScreen)
            ? ((screenSize.width - 250) / 6) - 40
            : screenSize.width - 40,
      ),
    );

    var data = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 10),
        Text(
          "${widget.color} / ${widget.size}",
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: removeItem,
          child: Text(
            "Remove",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 30),
      width: (isBigScreen) ? ((screenSize.width - 250)) - 40 : null,
      child: Row(
        children: [
          image,
          SizedBox(width: 15),
          data,
          Expanded(
            child: SizedBox(),
          ),
          Text(
            "\$${widget.price.toString()}",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(width: 100),
          Text(
            "1",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(width: 100),
          Text(
            "\$${widget.price.toString()}",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
