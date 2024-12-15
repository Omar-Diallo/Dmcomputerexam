import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final List<bool> _selectedCategories = List.generate(10, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void _onCategoryPressed(int index) {
    setState(() {
      _selectedCategories[index] = !_selectedCategories[index];
    });
  }
  //*******

  Widget buildCategoryButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: _selectedCategories[index]
                    ? Colors.green // Selected background color
                    : null, //
              ),

              onPressed: () {
                _onCategoryPressed(index);
              },
              child: Text('Catégorie ${index + 1}'),
            ),
          );
        },
      ),
    );
  }



}//fin



/*
 void _onCategoryPressed(int index) {

  print('Catégorie ${index + 1} pressée');

}
*/






//**********************


class SimpleCarousel extends StatelessWidget {
  final List<Widget> items;

  const SimpleCarousel({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 150.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }}

class shotLayoutCard extends StatelessWidget {
  const shotLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}


class DynamicButtonList extends StatelessWidget {
  final List<String> buttonTitles; // List of button titles (dynamic)
  final void Function(int index) onButtonPressed; // Callback for button press

  const DynamicButtonList({
    Key? key,
    required this.buttonTitles,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          buttonTitles.length,
              (index) => _buildDynamicButton(index, buttonTitles[index]),
        ),
      ),
    );
  }



  Widget _buildDynamicButton(int index, String title) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(fontSize: 14.0),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;

    final minButtonWidth = 100.0;
    final buttonWidth = math.max(textWidth + 2 * 8.0 + 16.0, minButtonWidth);

    return Container(
      width: buttonWidth,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () => onButtonPressed(index),
        child: Text(title, style: TextStyle(color: Colors.green),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: const EdgeInsets.all(8.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );


  }
}





