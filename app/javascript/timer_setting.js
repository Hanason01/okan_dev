import { timerRunning } from 'timer';


document.addEventListener('turbo:load', function() {
  console.log("turbo:loadが読まれました");

  // ポモドーロ選択ボタンのイベントリスナー
  document.getElementById("pomodoroSelectButton").addEventListener("click", () => {
    if (timerRunning) {
      alert("タイマーがスタートしている間はポモドーロタイマーを変更できません。");
      return;
    }
    const menu = document.getElementById("pomodoroSelectMenu");
    menu.style.display = menu.style.display === "none" ? "block" : "none";
    document.getElementById("pomodoroSelectSubmit").style.display = "block";
  });

  // 表示ボタンのイベントリスナー
  document.getElementById("pomodoroSelectSubmit").addEventListener("click", () => {
    const selectedPomodoroId = document.getElementById("pomodoroSelectMenu").value;
    if (selectedPomodoroId) {
      // フォームを送信して選択されたポモドーロの詳細を取得
      document.getElementById("pomodoroSection").submit();
    } else {
      alert("ポモドーロを選択してください");
    }
  });

  // 離席理由セクションの表示

  if (document.getElementById("pomodoroDetails")){
    document.getElementById("breakReasonTemplateSection").style.display = "block";
  }

  // 離席理由テンプレート選択ボタンのイベントリスナー
  document.getElementById("breakReasonTemplateSelectButton").addEventListener("click", () => {
    if (timerRunning) {
      alert("タイマーがスタートしている間は離席理由テンプレートを変更できません。");
      return;
    }
    const menu = document.getElementById("breakReasonTemplateSelectMenu");
    menu.style.display = menu.style.display === "none" ? "block" : "none";
    document.getElementById("breakReasonTemplateSelectSubmit").style.display = "block";
  });

  // 離席理由テンプレート表示ボタンのイベントリスナー
  document.getElementById("breakReasonTemplateSelectSubmit").addEventListener("click", () => {
    const selectedTemplateId = document.getElementById("breakReasonTemplateSelectMenu").value;
    if (selectedTemplateId) {
      // フォームを送信して選択されたテンプレートの詳細を取得
      document.getElementById("breakReasonTemplateSection").submit();
    } else {
      alert("離席理由テンプレートを選択してください");
    }
  });
});