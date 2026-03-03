/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

import { browsers } from "./browsers.config.js";
import { coverageConfig } from "./coverage.config.js";
import { plugins } from "./plugins.config.js";

/** @type {import('@web/test-runner').TestRunnerConfig} */
export default {
  rootDir: "./",
  port: 8765,
  nodeResolve: true,
  browsers,
  testFramework: {
    config: { timeout: 5000 }
  },

  files: [
    "packages/**/__tests__/**/*.test.{js,ts}",
    "packages/**/__tests__/**/*.spec.{js,ts}",
    "!**/node_modules/**/*"
  ],

  mimeTypes: {
    "**/*.ts": "js",
    "**/*.tsx": "js",
    "**/*.css": "js"
  },

  coverage: true,
  coverageConfig,

  plugins,
  transformCache: false
};
