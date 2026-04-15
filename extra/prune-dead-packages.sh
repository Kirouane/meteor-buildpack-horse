# extra/prune-dead-packages.sh — prune npm packages that rspack aliases to
  # `false` on the server. They're copied into the slug but never require()d.

  echo "-----> Pruning dead server packages"

  _NM="$COMPILE_DIR/app/programs/server/npm/node_modules"

  if [ ! -d "$_NM" ]; then
      echo "       $_NM not found, skipping"
      return 0 2>/dev/null || true
  fi

  _DEAD=(
      "@mui"
      "@emotion"
      canvas
      mammoth
      pdfjs-dist
      react-pdf
      react-dom
      medium-editor
      dompurify
      idb
      notistack
      html-react-parser
      react-markdown
      dragula
      dom-autoscroller
      embla-carousel-react
      embla-carousel-wheel-gestures
      tributejs
      nouislider
      funnel-graph-js
      anchorme
      ifvisible.js
  )

  _before=$(du -sm "$_NM" | cut -f1)
  for _pkg in "${_DEAD[@]}"; do
      _target="$_NM/$_pkg"
      if [ -e "$_target" ]; then
          _size=$(du -sh "$_target" | cut -f1)
          rm -rf "$_target"
          echo "       removed $_pkg ($_size)"
      fi
  done
  _after=$(du -sm "$_NM" | cut -f1)
  echo "       server node_modules ${_before}M -> ${_after}M"

  unset _NM _DEAD _pkg _target _size _before _after
