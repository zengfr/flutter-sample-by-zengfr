// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppTextScaleValue {
  const AppTextScaleValue(this.scale, this.label);

  final double scale;
  final String label;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final AppTextScaleValue typedOther = other;
    return scale == typedOther.scale && label == typedOther.label;
  }

  @override
  int get hashCode => hashValues(scale, label);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<AppTextScaleValue> kAllAppTextScaleValues =
    <AppTextScaleValue>[
  AppTextScaleValue(null, 'System Default'),
  AppTextScaleValue(0.8, 'Small'),
  AppTextScaleValue(1.0, 'Normal'),
  AppTextScaleValue(1.3, 'Large'),
  AppTextScaleValue(2.0, 'Huge'),
];
