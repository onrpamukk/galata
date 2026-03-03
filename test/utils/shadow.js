/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

export function getShadowRoot(el) {
  if (!el || !el.shadowRoot) {
    throw new Error(`ShadowRoot not found for <${el?.tagName?.toLowerCase?.() || "unknown"}>`);
  }
  return el.shadowRoot;
}

export function queryShadow(el, selector) {
  const root = getShadowRoot(el);
  const node = root.querySelector(selector);

  if (!node) {
    throw new Error(
      `Element "${selector}" not found inside <${el.tagName.toLowerCase()}> shadowRoot`
    );
  }

  return node;
}
