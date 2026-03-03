/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

import { setViewport } from "@web/test-runner-commands";

beforeEach(async () => {
  await setViewport({ width: 1280, height: 800 });
  document.body.innerHTML = "";
});

afterEach(() => {
  document.body.innerHTML = "";
});
