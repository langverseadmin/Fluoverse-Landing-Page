import fs from "fs";
import { execSync } from "child_process";

const path = "lib/guides/spain-expat-data.ts";
let s = fs.readFileSync(path, "utf8");

// Inline // comment on one line commented out apps: [...] and the rest of the file
const marker = ', // Ordered best';
const idx = s.indexOf(marker);
if (idx !== -1) {
  const appsIdx = s.indexOf("apps: [", idx);
  if (appsIdx !== -1) {
    s = s.slice(0, idx) + ",\n  apps: [" + s.slice(appsIdx + "apps: [".length);
  }
}

fs.writeFileSync(path, s);
execSync(`npx prettier --write "${path}"`, { stdio: "inherit" });
console.log("repaired and formatted", path);
