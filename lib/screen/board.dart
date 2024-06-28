import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({
    super.key,
    required this.lists,
    this.onTap,
  });

  final List<String> lists;
  final Function? onTap;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemCount: widget.lists.length,
            itemBuilder: (context, index) {
              return widget.lists[index] != "0"
                  ? GridButton(
                      image: widget.lists[index],
                      click: () {
                        widget.onTap!(context, index);
                      },
                    )
                  : SizedBox.shrink(
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    );
            }),
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  const GridButton({
    super.key,
    this.click,
    required this.image,
  });
  final VoidCallback? click;
  final String image;

  // int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Hero(
          tag: 'dash',
          child: Image.asset(
            image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          )),
      //style: ElevatedButton.styleFrom(primary: Colors.white),
    );
  }
}
