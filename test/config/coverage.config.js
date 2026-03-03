/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

export const coverageConfig = {
  include: ["packages/**/dist/**/*.js"],
  exclude: ["**/__tests__/**", "**/*.stories.ts", "**/index.ts", "**/node_modules/**"],
  report: true,
  reportDir: "coverage",
  reports: ["html", "text-summary"],
  threshold: {
    branches: 100,
    statements: 100,
    functions: 100,
    lines: 100
  }
};
