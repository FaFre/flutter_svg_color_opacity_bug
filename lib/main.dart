import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class SvgPainter extends CustomPainter {
  DrawableRoot svg;

  SvgPainter(this.svg);

  @override
  void paint(Canvas canvas, Size size) {
    svg
      ..scaleCanvasToViewBox(canvas, const Size(128, 128))
      ..clipCanvasToViewBox(canvas)
      ..draw(canvas, Rect.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyApp extends StatelessWidget {
  Future<DrawableRoot> loadSvg() async {
    final svgBytes = await rootBundle.load('assets/aerialway.svg');
    return svg.fromSvgBytes(svgBytes.buffer.asUint8List(), 'test',
        theme: SvgTheme(
            currentColor:
                Colors.blue.withOpacity(0.1))); //Should be nearly invisible
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: FutureBuilder<DrawableRoot>(
        future: loadSvg(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? CustomPaint(
                  painter: SvgPainter(snapshot.data!),
                )
              : const SizedBox.shrink();
        },
      ),
    ));
  }
}
