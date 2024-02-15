import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;

void main() {
  final game = AnimationExample();
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setPortrait();
  Flame.device.fullScreen();
  runApp(GameWidget(game: game));
}

class AnimationExample extends Forge2DGame {
  late SpriteSheet boomSprite;
  final spriteSize = Vector2(128.0, 128.0);
  final spriteNum = 8;

  AnimationExample() : super(gravity: Vector2(0, 15));

  @override
  Future<void> onLoad() async {
    boomSprite = SpriteSheet(
      image: await images.load('boom.png'),
      srcSize: spriteSize,
    );

    for (double i = 0; i < spriteNum; i++) {
      createBoom();
    }
  }

  void createBoom() {
    add(FallingObj(
        content: AnimatedBoom(
      boomSprite: boomSprite,
      atPosition: Vector2(Random().nextInt(size.x.round()).toDouble(),
          Random().nextInt(size.y.round()).toDouble()),
      spriteSize: spriteSize,
      row: Random().nextInt(8),
      num: spriteNum,
    )));
  }
}

class AnimatedBoom extends SpriteAnimationComponent
    with HasGameRef<AnimationExample> {
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
    lifeTime = Timer(num * 0.2 + Random().nextDouble() * 10);
    FlameAudio.play('455530__befig__2019explosion.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);
    lifeTime.update(dt);
    if (lifeTime.finished) {
      removeFromParent();
      gameRef.createBoom();
    }
  }
}

class FallingObj extends BodyComponent {
  final SpriteAnimationComponent content;

  FallingObj({required this.content})
      : super(
            bodyDef: BodyDef(
          angularDamping: 0.8,
          type: BodyType.dynamic,
        ));
  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(content);
  }
}
