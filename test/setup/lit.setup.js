/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

import { assert, expect, fixture, html, oneEvent, elementUpdated } from "@open-wc/testing";

export const setupLitTest = async (template) => {
  const el = await fixture(template);
  if (el.updateComplete) {
    await el.updateComplete;
  }
  return el;
};

export { html, fixture, expect, oneEvent, assert, elementUpdated };
