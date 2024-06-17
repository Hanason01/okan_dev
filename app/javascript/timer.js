import "easytimer";

// タイマー作動フラグとして指定
export let timerRunning = false;

// 変数初期化
const timer = new easytimer.Timer();
let setCount = 0;
let totalSets;
let minutes;
let breaks;
let alarmEnabled = true;

// アラーム音の設定
const alarmSound = new Audio(alarmSoundPath);
const sessionEndSound = new Audio(sessionEndSoundPath);
const okanReprimands = new Audio(okanReprimandsPath);


document.addEventListener('turbo:load', function() {
  console.log("turbo:loadが読まれました");
  let pomodoro;
  const pomodoroDetails = document.getElementById('pomodoroDetails');
  const defaultPomodoros = document.getElementById('defaultPomodoros');
  if (pomodoroDetails) {
    pomodoro = JSON.parse(pomodoroDetails.dataset.pomodoro);}
  else if(defaultPomodoros){
    pomodoro = JSON.parse(defaultPomodoros.dataset.pomodoro);}
    // setCount２回でポモドーロと休憩の１セットなのでtotalsSetsは２倍
  totalSets = pomodoro.total_sets * 2;
  minutes = pomodoro.minutes;
  breaks = pomodoro.breaks;


   // アラームのオンオフ要素を切り替えるイベントリスナー
  document.getElementById('alarmOn').addEventListener('click', () => {
    console.log('alarm OFF!');
    document.getElementById('alarmOn').style.display = 'none';
    document.getElementById('alarmOff').style.display = 'block';
    if (document.getElementById('alarmOff').style.display == 'block') {
      alarmEnabled = false;
    }
  });

  document.getElementById('alarmOff').addEventListener('click', () => {
    console.log('alarm ON!');
    document.getElementById('alarmOff').style.display = 'none';
    document.getElementById('alarmOn').style.display = 'block';
    if (document.getElementById('alarmOn').style.display == 'block') {
      alarmEnabled = true;
    }
  });


    // クリックイベントに対応する処理の記載
  // スタートボタン
  document.getElementById('startButton').addEventListener('click', function() {
    setCount = 0;
    initPomodoroSets(totalSets/2);
    startPomodoro();
    document.getElementById('startButton').style.display = 'none';
  });

  // 離席ボタン
  const resetButtons = document.getElementsByClassName('reset-button');
  Array.from(resetButtons).forEach(button => {
    button.addEventListener('click', function() {
      timer.stop();
      timerRunning = false;
      if (alarmEnabled) {
        console.log("オカンアラーム発音");
        okanReprimands.play();
      }
      const popup = document.getElementById('okan-reprimand-popup');
      popup.style.display = 'block';
      randomReprimand();
    });
  });

  // 仕切りなおすボタンのイベントリスナー
  document.getElementById('resetPomodoroButton').addEventListener('click', function() {
    initPomodoro();
    // ポップアップを非表示にする
    const popup = document.getElementById('okan-reprimand-popup');
    popup.style.display = 'none';
  });
});

// 関数ーーーーーーーーーーーーーー
// 初期表示
function initPomodoro() {
  document.getElementById('pomodoroStatus').innerText = '';
  document.querySelector('.pomodoro-timer').style.backgroundColor = 'rgba(238, 237, 237, 0.5)';
  document.getElementById('timer').innerText = minutes.toString().padStart(2, '0') + ":00";
  document.getElementById('startButton').style.display = 'block';
}

// ポモドーロ、休憩のカウントをスタートする関数
function startPomodoro() {
  timer.stop();
  timerRunning = true;
  document.getElementById('pomodoroStatus').innerText = '作業中';
  document.querySelector('.pomodoro-timer').style.backgroundColor = 'rgba(42, 124, 191, 0.5)';
  timer.start({countdown: true, startValues: {minutes: minutes}});
  console.log("作業開始");
}

function startBreak() {
  timer.stop();
  document.getElementById('pomodoroStatus').innerText = '休憩中';
  document.querySelector('.pomodoro-timer').style.backgroundColor = 'rgba(255, 151, 15, 0.5)';
  timer.start({countdown: true, startValues: {minutes: breaks}});
  console.log("休憩開始");
}

// カウント終了時の関数
function handleTimerEnd() {
  console.log("handleTimerEnd called at", timer.getTimeValues().toString());
  if (setCount < totalSets - 1) {
    if (setCount % 2 === 0) {
        if (alarmEnabled) {
          console.log("アラーム発音");
          alarmSound.play();
        }
        startBreak();
    } else {
        if (alarmEnabled) {
          console.log("アラーム発音");
          alarmSound.play();
        }
        console.log(setCount);
        updatePomodoroSets(setCount - 1);
        startPomodoro();
      }
    setCount++;
  } else {
    updatePomodoroSets((setCount - 1)/2);
    document.getElementById('pomodoroStatus').innerText = 'クリア！';
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
    if (alarmEnabled) {
      console.log("終了アラーム発音");
      sessionEndSound.play();
    }
    alert("セッション終了");
    initPomodoroSets(totalSets);
    resetPomodoroSets();
    timerRunning = false;
}

// セットカウントの初期化
function initPomodoroSets(totalSets) {
  console.log("initPomodoroSets");
  const pomodoroSetsContainer = document.querySelector('.pomodoro-sets');
  pomodoroSetsContainer.innerHTML = '';
  for (let i = 0; i < totalSets; i++) {
    const setElement = document.createElement('div');
    setElement.className = 'pomodoro-set';
    pomodoroSetsContainer.appendChild(setElement);
  }
}

// セットカウントの更新(CSSを動的に変更)
function updatePomodoroSets(setCounted) {
  console.log("updatePomodoroSets");
  const pomodoroSets = document.querySelectorAll('.pomodoro-set');
  pomodoroSets[setCounted].classList.add('completed');
}

// セットカウントの初期化
function resetPomodoroSets() {
  const resetPomodoroSetsContainer = document.querySelector('.pomodoro-sets');
  resetPomodoroSetsContainer.innerText = '';
}

// ランダムにReprimandを選択して表示する関数
function randomReprimand(){
  const randomReprimand = reprimands[Math.floor(Math.random() * reprimands.length)];
  document.getElementById('reprimandText').innerText = randomReprimand.body;
  document.getElementById('startButton').style.display = 'block';
};


// タイマーの時間更新、終了によって呼び出されるイベントリスナー

timer.addEventListener('secondsUpdated', function (e) {
  updateTimer();
  console.log('SecondsUpdated', timer.getTimeValues().toString());
});

timer.addEventListener('targetAchieved', function(e){
  console.log('targetAchieved event triggered', timer.getTimeValues().toString());
  handleTimerEnd();
});