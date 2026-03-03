/*
 * -----------------------------------------------------------------
 * Copyright © 2026 Galata. All rights reserved.
 * See License for license information.
 * -----------------------------------------------------------------
 */

import rollupReplace from "@rollup/plugin-replace";
import { esbuildPlugin } from "@web/dev-server-esbuild";
import { fromRollup } from "@web/dev-server-rollup";
import rollupLitCss from "rollup-plugin-lit-css";

const replace = fromRollup(rollupReplace);
const litCss = fromRollup(rollupLitCss);

export const plugins = [
  litCss({
    include: ["packages/**/src/**/*.css"]
  }),
  replace({
    preventAssignment: true,
    "process.env.NODE_ENV": JSON.stringify(process.env.NODE_ENV || "test")
  }),
  esbuildPlugin({
    ts: true,
    target: "esnext"
  })
];
