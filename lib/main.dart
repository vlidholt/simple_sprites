import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sprites/flutter_sprites.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Demo",
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new FlutterDemo()
      }
    )
  );
}

class FlutterDemo extends StatefulComponent {
  @override
  State createState() => new FlutterDemoState();
}

class FlutterDemoState extends State {
  // Make the sprite world part of the FlutterDemoState
  MySpriteWorld _spriteWorld;

  void initState() {
    super.initState();
    _spriteWorld = new MySpriteWorld();
  }

  Widget build(BuildContext context) {
    // Create a new SpriteWidget for our sprite world
    return new SpriteWidget(_spriteWorld);
  }
}

class MySpriteWorld extends NodeWithSize {

  // Setup a root node with a coordinate system size of 1024.0, 1024.0
  MySpriteWorld(): super(new Size(1024.0, 1024.0)) {
    // Create a red ball and add it to the scene
    MyCustomNode redBall = new MyCustomNode();
    redBall.position = new Point(512.0, 64.0);
    this.addChild(redBall);

    // Animate the ball up and bouncing down
    ActionSequence sequence = new ActionSequence([
      new ActionTween(
        (a) => redBall.position = a,
        new Point(512.0, 64.0),
        new Point(512.0, 960.0), 1.0,
        Curves.bounceOut),
      new ActionTween(
        (a) => redBall.position = a,
        new Point(512.0, 960.0),
        new Point(512.0, 64.0), 2.0,
        Curves.easeInOut)
    ]);

    // Loop the animation
    ActionRepeatForever loop = new ActionRepeatForever(sequence);

    // Run the animation
    this.actions.run(loop);
  }
}

// Custom node that paints a red ball
class MyCustomNode extends Node {

  // Override the paint method to do custom painting
  void paint(Canvas canvas) {
    Paint redPaint = new Paint()..color = new Color.fromARGB(255, 255, 0, 0);
    canvas.drawCircle(Point.origin, 64.0, redPaint);
  }
}
