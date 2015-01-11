import 'dart:html';
import '../mapgenerator/map_entities.dart';
import '../mapgenerator/procedural_generated_map.dart';

import 'package:stagexl/stagexl.dart';


ImageElement wall, grass, floor, corner, tree;

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;

// Start Load of images and waits for them to complete.
LoadImages() {


  resourceManager = new ResourceManager()
      ..addBitmapData("wall", "img/stone.png")
      ..addBitmapData("grass", "img/grass.png")
      ..addBitmapData("floor", "img/floor.png")
      ..addBitmapData("corner", "img/corner.png")
      ..addBitmapData("tree", "img/ftree.png");



  return resourceManager.load();
}

void drawStage(CanvasElement ca, PGMap Amap, int tilesize) {
  int width = Amap.Width;
  int height = Amap.Height;
  int tw = 10;
  ca.width = width * tw;
  ca.height = height * tw;
  print("tilesize $tilesize");

  stage = new Stage(ca, webGL: true, width: ca.width, height: ca.height);
  stage.backgroundColor = Color.Blue;
  stage.scaleMode = StageScaleMode.SHOW_ALL;
  stage.align = StageAlign.NONE;

  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);


  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int c = Amap.getBlock(x, y).base;
      if (c == WALLN || c == WALLS || c == WALLE || c == WALLW) {
        BitmapData wallBitmapData = resourceManager.getBitmapData("wall");
        Bitmap wallBitmap = new Bitmap(wallBitmapData);
        Sprite wall = new Sprite();
        wall.x = x * tw;
        wall.y = y * tw;
        wall.scaleX = tw;
        wall.scaleY = tw;
        wall.addChild(wallBitmap);
        wall.addTo(stage);
      } else if (c == WALLCORNER) {
        BitmapData wallBitmapData = resourceManager.getBitmapData("corner");
        Bitmap wallBitmap = new Bitmap(wallBitmapData);
        Sprite wall = new Sprite();
        wall.x = x * tw;
        wall.y = y * tw;
        wall.scaleX = tw;
        wall.scaleY = tw;

        wall.addChild(wallBitmap);
        wall.addTo(stage);
      } else if (c == TREE) {
        BitmapData wallBitmapData = resourceManager.getBitmapData("grass");
        Bitmap wallBitmap = new Bitmap(wallBitmapData);
        Sprite wall = new Sprite();
        wall.x = x * tw;
        wall.y = y * tw;
        wall.scaleX = tw;
        wall.scaleY = tw;

        wall.addChild(wallBitmap);
        wall.addTo(stage);
        BitmapData treeBitmapData = resourceManager.getBitmapData("tree");
        Bitmap treeBitmap = new Bitmap(wallBitmapData);
        Sprite tree = new Sprite();
        tree.x = x * tw;
        tree.y = (y * tw) - 4;
        tree.scaleX = tw;
        tree.scaleY = tw;

        tree.addChild(treeBitmap);
        tree.addTo(stage);
      } else if (c == ROOM || c == CORRIDOR) {
        BitmapData wallBitmapData = resourceManager.getBitmapData("floor");
        Bitmap wallBitmap = new Bitmap(wallBitmapData);
        Sprite wall = new Sprite();
        wall.x = x * tw;
        wall.y = y * tw;
        wall.scaleX = tw;
        wall.scaleY = tw;

        wall.addChild(wallBitmap);
        wall.addTo(stage);
      } else {
        BitmapData wallBitmapData = resourceManager.getBitmapData("grass");
        Bitmap wallBitmap = new Bitmap(wallBitmapData);
        Sprite wall = new Sprite();
        wall.x = x * tw;
        wall.y = y * tw;
        wall.scaleX = tw;
        wall.scaleY = tw;

        wall.addChild(wallBitmap);
        wall.addTo(stage);
      }
    }
  }



}

void drawMap(CanvasElement ca, PGMap Amap, int tileSize) {
  int width = Amap.Width;
  int height = Amap.Height;
  int tw = tileSize;
  ca.width = width * tw;
  ca.height = height * tw;

  CanvasRenderingContext2D ctx = ca.getContext("2d");
  ctx.imageSmoothingEnabled = false;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int c = Amap.getBlock(x, y).base;
      if (c == WALLN || c == WALLS || c == WALLE || c == WALLW) {
        ctx.drawImageScaled(wall, x * tw, y * tw, tw, tw);
      } else if (c == WALLCORNER) {
        ctx.drawImageScaled(corner, x * tw, y * tw, tw, tw);
      } else if (c == TREE) {
        ctx.drawImageScaled(grass, x * tw, y * tw, tw, tw);
        ctx.drawImageScaled(tree, x * tw, (y * tw) - 4, tw, tw);
      } else if (c == ROOM || c == CORRIDOR) {
        ctx.drawImageScaled(floor, x * tw, y * tw, tw, tw);
      } else {
        ctx.drawImageScaled(grass, x * tw, y * tw, tw, tw);
      }
    }
  }
}
