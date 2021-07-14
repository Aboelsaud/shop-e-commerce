import '../libraries.dart';

class ShoppingCartColumn extends StatefulWidget {
  final String title;
  final double price;
  final String id;
  final String color;
  final String size;
  final String image;
  ShoppingCartColumn(
      this.title, this.price, this.id, this.color, this.size, this.image);

  @override
  _ShoppingCartColumnState createState() => _ShoppingCartColumnState();
}

class _ShoppingCartColumnState extends State<ShoppingCartColumn> {
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
        fit: BoxFit.fitHeight,
        width: (isBigScreen) ? 160 : double.infinity,
        height: (isBigScreen)
            ? ((screenSize.width - 250) / 3) - 40
            : (screenSize.width) / 2 - 40,
      ),
    );

    var data = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          child: Text("Remove", style: Theme.of(context).textTheme.headline3),
        ),
      ],
    );
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 60),
      width: (isBigScreen) ? ((screenSize.width - 250)) - 40 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          SizedBox(height: 15),
          data,
          SizedBox(height: 30),
          Row(
            children: [
              Text("Price", style: Theme.of(context).textTheme.headline4),
              Expanded(child: SizedBox()),
              Text(
                "\$${widget.price.toString()}",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text("Quantity", style: Theme.of(context).textTheme.headline4),
              Expanded(child: SizedBox()),
              Text(
                "1",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text("Total", style: Theme.of(context).textTheme.headline4),
              Expanded(child: SizedBox()),
              Text(
                "\$${widget.price.toString()}",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
