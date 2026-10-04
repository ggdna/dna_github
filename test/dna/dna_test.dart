// @license
// Copyright (c) <YOUR_COPYRIGHT_HOLDER>
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:helix/helix.dart';
import 'package:test/test.dart';

void main() {
  test(
    'dna is instantiated and unmodified',
    () => runDnaTest(),
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
