import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

void main() {
  final game = SpriteBatchLoadExample();
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setPortrait();
  Flame.device.fullScreen();
  runApp(GameWidget(game: game));
}

class SpriteBatchLoadExample extends FlameGame {
  late SpriteSheet boomSprite;

  @override
  Future<void> onLoad() async {
    final spriteSize = Vector2(128.0, 128.0);
    boomSprite = SpriteSheet(
      image: await images.load('boom.png'),
      srcSize: spriteSize,
    );

    for (double i = 0 ; i <=7 ; i++) {
    final animation = boomSprite.createAnimation(row: i.round(), stepTime: 0.2);
    final boomComponent = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(2, 2),
      size: spriteSize,
      position: spriteSize * i,
    );
    add(boomComponent);
    }
  }
}
