document.addEventListener("turbo:load", () => {
  console.log("turbo:loadが発生");
  // データ属性からbreak reasonsを取得
  const breakReasonsData = document.getElementById('break-reasons-data').dataset.breakReasons;
  const breakReasons = JSON.parse(breakReasonsData);
  const selectedReasons = new Set();
  // 現在のセレクトボックス全体の要素を取得
  const breakReasonSelects = document.querySelectorAll(".break-reason-select");

  // セレクトボックスのオプションを更新する関数
  function updateSelectOptions() {
    breakReasonSelects.forEach(select => {
      // 現在のセレクトボックスの選択値を取得
      const currentReasonId = select.value;
      // 利用可能な理由をフィルタリング
      const availableReasons = breakReasons.filter(br => !selectedReasons.has(String(br.id)) || String(br.id) === currentReasonId);
      // セレクトボックスのオプションをクリア
      select.innerHTML = '';
      // 空白のオプションを追加
      select.appendChild(new Option('', ''));
      // 利用可能な理由をオプションとして追加
      availableReasons.forEach(reason => {
        const option = new Option(reason.reason, reason.id);
        // 現在選択されているオプションを保持
        if (String(reason.id) === currentReasonId) {
          option.selected = true;
        }
        select.appendChild(option);
      });
    });
  }

  // 初期化: 選択されている理由をセットに追加
  breakReasonSelects.forEach(select => {
    const reasonId = select.value;
    if (reasonId) {
      selectedReasons.add(reasonId);
    }
  });

  // 初期オプションの更新
  updateSelectOptions();

  // 個々のセレクトボックスのchangeイベントをリッスン
  breakReasonSelects.forEach(select => {
    select.addEventListener("change", event => {
      // リッスンしたら、indexにセレクトボックスの番号、reasonIdにそこに選択された離席理由のIdを格納
      const index = event.target.dataset.index;
      const reasonId = event.target.value;
      // 現在のセレクトボックスで以前選択された理由のIDを取得し、selectedReasonsセットから削除
      const previousReasonId = document.querySelector(`.hidden-break-reason-id[data-index='${index}']`).value;
      if (previousReasonId) {
        selectedReasons.delete(previousReasonId);
      }
      // 新たに選択された理由をセットに追加し、hiddenフィールドに値を設定
      if (reasonId) {
        selectedReasons.add(reasonId);
        document.querySelector(`.hidden-break-reason-id[data-index='${index}']`).value = reasonId;
      } else {
        document.querySelector(`.hidden-break-reason-id[data-index='${index}']`).value = '';
      }
      // 他のセレクトボックスのオプションを更新
      updateSelectOptions();
    });
  });
});
