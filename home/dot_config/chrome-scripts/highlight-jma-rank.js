(() => {
  "use strict";

  const targetYearInput = prompt("ハイライトする年を西暦4桁で入力してください。", "2026");
  if (targetYearInput === null) return;

  const TARGET_YEAR = targetYearInput.trim();
  if (!/^\d{4}$/.test(TARGET_YEAR)) {
    alert("年は西暦4桁で入力してください（例: 2026）。");
    return;
  }

  const maxRankInput = prompt("何位まで表示しますか？（1～10）", "10");
  if (maxRankInput === null) return;

  const MAX_RANK_TO_SHOW = Number(maxRankInput.trim());
  if (!Number.isInteger(MAX_RANK_TO_SHOW) || MAX_RANK_TO_SHOW < 1 || MAX_RANK_TO_SHOW > 10) {
    alert("表示順位は1～10の整数で入力してください。");
    return;
  }

  const TABLE_SELECTOR = "table#tablefix1.data2_s";
  const HIGHLIGHT_CLASS = "jma-rank-highlight";
  const HIDDEN_CLASS = "jma-rank-hidden-column";
  const HIDDEN_ROW_CLASS = "jma-rank-hidden-row";
  const STYLE_ID = "jma-rank-highlight-style";

  const table = document.querySelector(TABLE_SELECTOR);
  if (!table) {
    console.warn("JMAの『観測史上1～10位の値』テーブルが見つかりませんでした。");
    return;
  }

  // スニペットを再実行しても、前回の加工が残らないようにする。
  table
    .querySelectorAll(`.${HIGHLIGHT_CLASS}, .${HIDDEN_CLASS}, .${HIDDEN_ROW_CLASS}`)
    .forEach((element) =>
      element.classList.remove(HIGHLIGHT_CLASS, HIDDEN_CLASS, HIDDEN_ROW_CLASS),
    );
  document.getElementById(STYLE_ID)?.remove();

  const style = document.createElement("style");
  style.id = STYLE_ID;
  style.textContent = `
    #tablefix1 .${HIGHLIGHT_CLASS} {
      background-color: #ffd9d9 !important;
    }
    #tablefix1 .${HIDDEN_CLASS} {
      display: none !important;
    }
    #tablefix1 tr.${HIDDEN_ROW_CLASS} {
      display: none !important;
    }
  `;
  document.head.append(style);

  const rows = [...table.rows];
  const headerRow = rows[0];
  if (!headerRow) return;

  // 「要素名／順位」と「統計期間」を除いた、1～10位の列を取得する。
  const rankColumnIndexes = [...headerRow.cells]
    .map((_, index) => index)
    .slice(1, -1);

  const containsTargetYear = (cell) => {
    const text = cell.textContent.trim();
    const value = text.split("(", 1)[0].trim();

    return value !== "--" && new RegExp(`\\(\\s*${TARGET_YEAR}(?:\\D|$)`).test(text);
  };

  // 設定した順位より下の列を、見出しを含めて非表示にする。
  for (const columnIndex of rankColumnIndexes.slice(MAX_RANK_TO_SHOW)) {
    for (const row of rows) {
      row.cells[columnIndex]?.classList.add(HIDDEN_CLASS);
    }
  }

  // 表示対象の順位内にハイライト対象がない観測項目は、行ごと非表示にする。
  for (const row of rows.slice(1)) {
    let hasHighlightedCell = false;

    for (const columnIndex of rankColumnIndexes.slice(0, MAX_RANK_TO_SHOW)) {
      const cell = row.cells[columnIndex];
      if (cell && containsTargetYear(cell)) {
        cell.classList.add(HIGHLIGHT_CLASS);
        hasHighlightedCell = true;
      }
    }

    if (!hasHighlightedCell) {
      row.classList.add(HIDDEN_ROW_CLASS);
    }
  }
})();
