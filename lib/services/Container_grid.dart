import '../libraries.dart';

class ContainerGrid extends StatefulWidget {
  final String text;
  final double price;
  final int index;
  final String img;
  int itemCount;

  ContainerGrid(this.text, this.price, this.index, this.img, this.itemCount);

  @override
  _ContainerGridState createState() => _ContainerGridState();
}

class _ContainerGridState extends State<ContainerGrid> {
  void navigate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemScreen(widget.text, widget.price,
                widget.index, widget.img, widget.itemCount)));
  }

  Widget textUrl(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Widget textUrlPrice(double text) {
    return Text(
      "\$${text.toString()}",
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  bool isHovered = false;

  bool isBigScreen = false;

  Size screenSize;

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
    });
    return InkWell(
      onHover: (isHover) {
        setState(() {
          isHovered = isHover;
        });
      },
      onTap: () {
        navigate();
      },
      child: Container(
        color: Colors.white,
        width: (isBigScreen) ? ((screenSize.width - 250) / 3) - 60 : null,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: (isBigScreen)
                      ? ((screenSize.width - 250) / 3) - 60
                      : screenSize.width - 60,
                ),
                widget.index == 1
                    ? Positioned(
                        top: 1,
                        right: 1,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            "Sale",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : Text(""),
                Container(
                  width: double.infinity,
                  height: (isBigScreen)
                      ? ((screenSize.width - 250) / 3) - 60
                      : screenSize.width - 60,
                  color: (isHovered) ? Colors.grey.withOpacity(0.13) : null,
                ),
              ],
            ),
            SizedBox(height: 10),
            textUrl(widget.text),
            SizedBox(height: 8),
            textUrlPrice(widget.price),
          ],
        ),
      ),
    );
  }
}
