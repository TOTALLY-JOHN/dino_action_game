import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'game_object.dart';
import 'sprite.dart';

List<Sprite> dino = [
  Sprite()
    ..imagePath = "assets/images/dino/dino_1.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
  Sprite()
    ..imagePath = "assets/images/dino/dino_2.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
  Sprite()
    ..imagePath = "assets/images/dino/dino_3.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
  Sprite()
    ..imagePath = "assets/images/dino/dino_4.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
  Sprite()
    ..imagePath = "assets/images/dino/dino_5.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
  Sprite()
    ..imagePath = "assets/images/dino/dino_6.png"
    ..imageWidth = dinoWidth
    ..imageHeight = dinoHeight,
];

enum DinoState {
  jumping,
  boosting,
  running,
  dead,
}

class Dino extends GameObject {
  Sprite currentSprite = dino[0];
  double dispY = 0;
  double velY = 0;
  DinoState state = DinoState.running;

  @override
  Widget render() {
    return Image.asset(currentSprite.imagePath);
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      screenSize.width / 8,
      screenSize.height / 1.2 - currentSprite.imageHeight - dispY,
      currentSprite.imageWidth.toDouble(),
      currentSprite.imageHeight.toDouble(),
    );
  }

  @override
  void update(Duration lastUpdate, Duration? elapsedTime) {
    double elapsedTimeSeconds;
    try {
      currentSprite = dino[(elapsedTime!.inMilliseconds / 100).floor() % 2 + 2];
    } catch (_) {
      currentSprite = dino[0];
    }
    try {
      elapsedTimeSeconds = (elapsedTime! - lastUpdate).inMilliseconds / 1000;
    } catch (_) {
      elapsedTimeSeconds = 0;
    }

    dispY += velY * elapsedTimeSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      state = DinoState.running;
    } else {
      velY -= gravity * elapsedTimeSeconds;
    }
  }

  void jump() {
    if (state != DinoState.jumping) {
      state = DinoState.jumping;
      velY = jumpVelocity;
    }
  }

  void die() {
    currentSprite = dino[5];
    state = DinoState.dead;
  }
}
