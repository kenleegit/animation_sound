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

    final animation = boomSprite.createAnimation(row: 0, stepTime: 0.2);
    final boomComponent = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(1, 1),
      size: spriteSize,
    );
    add(boomComponent);
  }
}
