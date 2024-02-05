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
    const spriteNum = 8;
    boomSprite = SpriteSheet(
      image: await images.load('boom.png'),
      srcSize: spriteSize,
    );

    for (double i = 0; i < spriteNum; i++) {
      add(AnimatedBoom(
        boomSprite: boomSprite,
        atPosition: spriteSize * i,
        spriteSize: spriteSize,
        row: i.round(),
        num: spriteNum,
      ));
    }
  }
}

class AnimatedBoom extends SpriteAnimationComponent {
  final SpriteSheet boomSprite;
  final Vector2 atPosition;
  final Vector2 spriteSize;
  final int row;
  final int num;
  late Timer lifeTime;

  AnimatedBoom({
    required this.boomSprite,
    required this.atPosition,
    required this.spriteSize,
    required this.row,
    required this.num,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    scale = Vector2(2, 2);
    position = atPosition;
    animation = boomSprite.createAnimation(row: row, stepTime: 0.2);
    lifeTime = Timer(num * 0.2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    lifeTime.update(dt);
    if (lifeTime.finished) {
      removeFromParent();
    }
  }
}
