#!/bin/zsh
set -euo pipefail

ROOT="/Users/wuenbang/orbit-docs"
OUT="$ROOT/.preview"
TITLE="Orbit Documentation Preview"

mkdir -p "$OUT"
mkdir -p "$OUT/assets"
rm -rf "$OUT/assets/images"
cp -R "$ROOT/assets/images" "$OUT/assets/images"

pages=(
  "README.md|index.html|Home"
  "getting-started/README.md|getting-started.html|Getting Started"
  "concepts/README.md|concepts.html|Core Concepts"
  "protocol/README.md|protocol.html|Protocol Design"
  "protocol/market-lifecycle.md|market-lifecycle.html|Market Lifecycle"
  "protocol/technical-appendix.md|technical-appendix.html|Technical Appendix"
  "economics/README.md|economics.html|Economics"
  "risks/README.md|risks.html|Risks"
  "team-roadmap/README.md|team-roadmap.html|Team & Roadmap"
)

for page in "${pages[@]}"; do
  src="${page%%|*}"
  rest="${page#*|}"
  dest="${rest%%|*}"

  pandoc \
    "$ROOT/$src" \
    --from gfm \
    --to html5 \
    --standalone \
    --metadata title="$TITLE" \
    --css style.css \
    --output "$OUT/$dest"
done

cat > "$OUT/style.css" <<'EOF'
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  background: #f6f7f4;
  color: #142013;
  line-height: 1.65;
}

main {
  max-width: 860px;
  margin: 0 auto;
  padding: 48px 32px 80px;
}

nav {
  position: sticky;
  top: 0;
  z-index: 10;
  display: flex;
  gap: 18px;
  flex-wrap: wrap;
  padding: 18px 24px;
  background: #142013;
}

nav a {
  color: #f4f4ef;
  text-decoration: none;
  font-weight: 600;
}

h1, h2, h3 {
  color: #10170f;
  line-height: 1.15;
}

h1 {
  font-size: 2.4rem;
  margin-top: 0;
}

h2 {
  margin-top: 2.4rem;
}

img {
  max-width: 100%;
  height: auto;
  border-radius: 14px;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
  margin: 24px 0;
}

code {
  background: rgba(20, 32, 19, 0.08);
  padding: 0.1rem 0.35rem;
  border-radius: 6px;
}

pre code {
  display: block;
  padding: 1rem;
  overflow-x: auto;
}

blockquote {
  border-left: 4px solid #7d9565;
  margin-left: 0;
  padding-left: 1rem;
  color: #41543c;
}
EOF

wrap_page() {
  local file="$1"
  local tmp="$file.tmp"
  cat > "$tmp" <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$TITLE</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <nav>
    <a href="index.html">Home</a>
    <a href="getting-started.html">Getting Started</a>
    <a href="concepts.html">Core Concepts</a>
    <a href="protocol.html">Protocol Design</a>
    <a href="market-lifecycle.html">Market Lifecycle</a>
    <a href="technical-appendix.html">Technical Appendix</a>
    <a href="economics.html">Economics</a>
    <a href="risks.html">Risks</a>
    <a href="team-roadmap.html">Team & Roadmap</a>
  </nav>
  <main>
EOF

  sed -n '/<body>/,/<\/body>/p' "$file" | sed '1d;$d' >> "$tmp"

  cat >> "$tmp" <<'EOF'
  </main>
</body>
</html>
EOF

  mv "$tmp" "$file"
}

for html in "$OUT"/*.html; do
  wrap_page "$html"
  perl -0pi -e 's#\.\./assets/images/#assets/images/#g; s#\./getting-started/README\.md#getting-started.html#g; s#\./concepts/README\.md#concepts.html#g; s#\./protocol/README\.md#protocol.html#g; s#\./protocol/market-lifecycle\.md#market-lifecycle.html#g; s#\./protocol/technical-appendix\.md#technical-appendix.html#g; s#\./economics/README\.md#economics.html#g; s#\./risks/README\.md#risks.html#g; s#\./team-roadmap/README\.md#team-roadmap.html#g; s#\.\./concepts/README\.md#concepts.html#g; s#\.\./protocol/README\.md#protocol.html#g; s#\.\./protocol/market-lifecycle\.md#market-lifecycle.html#g; s#\.\./risks/README\.md#risks.html#g; s#\.\./team-roadmap/README\.md#team-roadmap.html#g' "$html"
done
