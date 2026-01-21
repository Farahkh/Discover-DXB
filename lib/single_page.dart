import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SinglePage extends StatelessWidget {
  const SinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final title = args?['title'] as String? ?? 'No Title';
    final imageUrl = args?['imageUrl'] as String? ?? 'no image found';
    final description = args?['description'] as String? ?? ' ';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          StreamBuilder<AccelerometerEvent>(
  stream: accelerometerEventStream(), // Use the new stream API
  builder: (context, snapshot) {
    // We extract the X and Y tilt values
    // Using a low multiplier (e.g., 8.0) keeps the effect subtle and professional
    double xOffset = (snapshot.data?.x ?? 0) * 8.0;
    double yOffset = (snapshot.data?.y ?? 0) * 8.0;

    return ClipPath(
      clipper: HeaderClipper(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              // We move the image in the opposite direction of the tilt
              top: -20 + yOffset, 
              left: -20 - xOffset,
              right: -20 + xOffset,
              bottom: -20 - yOffset,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  },
),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Icon(Icons.favorite_border_outlined),
                      Text(
                        title,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

// Custom Clipper for the circular bottom curve
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
