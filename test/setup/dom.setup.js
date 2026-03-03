/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

export const queryShadow = (el, selector) => el.shadowRoot?.querySelector(selector);

export const clickElement = (el) => {
  el.dispatchEvent(new MouseEvent("click", { bubbles: true, composed: true }));
};

export const wait = (ms = 10) => new Promise((resolve) => setTimeout(resolve, ms));
