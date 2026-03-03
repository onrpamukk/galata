/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

import { playwrightLauncher } from "@web/test-runner-playwright";
import { puppeteerLauncher } from "@web/test-runner-puppeteer";
import parseArgs from "minimist";

const args = parseArgs(process.argv.slice(2), {
  boolean: true
});

export let browsers = [
  playwrightLauncher({ product: "chromium" }),
  playwrightLauncher({ product: "firefox", concurrency: 1 }),
  playwrightLauncher({ product: "webkit" })
];

if (args.debug) {
  browsers = [
    puppeteerLauncher({
      launchOptions: {
        args: ["--no-sandbox"],
        devtools: true,
        headless: !!args.headless
      }
    })
  ];
}
