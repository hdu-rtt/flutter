// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../rendering/mock_canvas.dart';

void main() {
  test('Compound borders', () {
    final Border b1 = new Border.all(color: const Color(0xFF00FF00));
    final Border b2 = new Border.all(color: const Color(0xFF0000FF));
    expect(
      (b1 + b2).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 1.0, BorderStyle.solid))',
    );
    expect(
      (b1 + (b2 + b2)).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 2.0, BorderStyle.solid))',
    );
    expect(
      ((b1 + b2) + b2).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 2.0, BorderStyle.solid))',
    );
    expect((b1 + b2) + b2, b1 + (b2 + b2));
    expect(
      (b1 + b2).scale(3.0).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 3.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 3.0, BorderStyle.solid))',
    );
    expect(
      (b1 + b2).scale(0.0).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 0.0, BorderStyle.none)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 0.0, BorderStyle.none))',
    );
    expect(
      ShapeBorder.lerp(b2 + b1, b1 + b2, 0.0).toString(),
      'Border.all(BorderSide(Color(0xff0000ff), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff00ff00), 1.0, BorderStyle.solid))',
    );
    expect(
      ShapeBorder.lerp(b2 + b1, b1 + b2, 0.25).toString(),
      'Border.all(BorderSide(Color(0xff003fbf), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff00bf3f), 1.0, BorderStyle.solid))',
    );
    expect(
      ShapeBorder.lerp(b2 + b1, b1 + b2, 0.5).toString(),
      'Border.all(BorderSide(Color(0xff007f7f), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff007f7f), 1.0, BorderStyle.solid))',
    );
    expect(
      ShapeBorder.lerp(b2 + b1, b1 + b2, 1.0).toString(),
      'Border.all(BorderSide(Color(0xff00ff00), 1.0, BorderStyle.solid)) + '
      'Border.all(BorderSide(Color(0xff0000ff), 1.0, BorderStyle.solid))'
    );
    expect((b1 + b2).dimensions, const EdgeInsets.all(2.0));
    final Rect rect = new Rect.fromLTRB(11.0, 15.0, 299.0, 175.0);
    expect((Canvas canvas) => (b1 + b2).paint(canvas, rect), paints
      ..rect(rect: rect.deflate(0.5), color: b2.top.color)
      ..rect(rect: rect.deflate(1.5), color: b1.top.color)
    );
    expect((b1 + b2 + b1).dimensions, const EdgeInsets.all(3.0));
    expect((Canvas canvas) => (b1 + b2 + b1).paint(canvas, rect), paints
      ..rect(rect: rect.deflate(0.5), color: b1.top.color)
      ..rect(rect: rect.deflate(1.5), color: b2.top.color)
      ..rect(rect: rect.deflate(2.5), color: b1.top.color)
    );
  });
}
