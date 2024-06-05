const timer = new easytimer.Timer();
let setCount = 0;
let totalSets;
let minutes;
let breaks;

document.addEventListener('DOMContentLoaded', function() {
  const pomodoros = JSON.parse(document.getElementById('pomodoros').dataset.pomodoros);
// setCount２回でポモドーロと休憩の１セットなのでtotalsSetsは２倍
    // totalSets = pomodoros.total_sets *2 ;
    // minutes = pomodoros.minutes;
    // breaks = pomodoros.breaks;
// テスト用コード
  totalSets = 1 *2;
  minutes = 1;
  breaks = 1;
});

// 関数ーーーーーーーーーーーーーー
// 初期表示
function initPomodoro() {
  document.getElementById('timer').innerText = minutes.toString().padStart(2, '0') + ":00";
}

// ポモドーロ、休憩のカウントをスタートする関数
function startPomodoro() {
  timer.stop();
  timer.start({countdown: true, startValues: {minutes: minutes}});
  console.log("Pomodoro started");
}

function startBreak() {
  timer.stop();
  timer.start({countdown: true, startValues: {minutes: breaks}});
  console.log("Break started");
}

// カウント終了時の関数
function handleTimerEnd() {
  console.log("handleTimerEnd called at", timer.getTimeValues().toString());
  if (setCount < totalSets - 1) {
    if (setCount % 2 === 0) {
        startBreak();
    } else {
        startPomodoro();
      }
    setCount++;
  } else {
    setTimeout(function(){
    sessionFinished();
    initPomodoro();
    },1000);
    setCount = 0;
  }
}

// HTMLのタイマー表示をeasytimerのタイマーに合わせる
function updateTimer(){
  document.getElementById('timer').innerText = timer.getTimeValues().minutes.toString().padStart(2, '0') + ':' + timer.getTimeValues().seconds.toString().padStart(2, '0');
}

// セッションが終了したらする処理
function sessionFinished(){
    alert("セッション終了");
}

// タイマーの時間更新、終了によって呼び出されるイベントリスナー

timer.addEventListener('secondsUpdated', function (e) {
  updateTimer()
  console.log('SecondsUpdated発生', timer.getTimeValues().toString());
});

timer.addEventListener('targetAchieved', function(e){
  console.log('targetAchieved event triggered', timer.getTimeValues().toString());
  handleTimerEnd();
});

// クリックイベントに対応する処理の記載
// スタートボタン
document.getElementById('startButton').addEventListener('click', function() {
  setCount = 0;
  startPomodoro();
});

// 離席ボタン
document.getElementById('resetButton').addEventListener('click', function() {
  timer.stop();
  initPomodoro();
});
