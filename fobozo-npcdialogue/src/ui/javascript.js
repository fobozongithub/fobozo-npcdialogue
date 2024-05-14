window.onload = function () {
  const buttons = document.querySelectorAll('.action-button');
  const buttonGroup = document.getElementById('button-group');

  if (buttons.length === 1) {
      buttons[0].style.gridColumn = "1 / span 2";
  } else if (buttons.length % 2 !== 0) {
      buttons[buttons.length - 1].style.gridColumn = "1 / span 2";
  }
};

function updateButtons(options) {
  var button1 = document.getElementById("button-text-1");
  var button2 = document.getElementById("button-text-2");
  var button3 = document.getElementById("button-text-3");
  var button4 = document.getElementById("button-text-4");

  if (!options || options.length === 0) {
      hideButtons();
      return;
  }

  for (var i = 0; i < options.length; i++) {
      var button = getButtonElement(i + 1);
      if (button) {
          button.innerHTML = `<div class="button-number" id="button-${i + 1}">${i + 1}</div>${options[i].label}`;
          button.style.display = 'block';
          button.onclick = (function (option) {
              return function () { 
                  $.post(`https://${GetParentResourceName()}/fobozo-npcdialogue:process`, JSON.stringify({
                      event: option.event,
                      args: option.args,
                      type: option.type
                  }));
                  if (option.event === "fobozo-npcdialogue:hideMenu") {
                      var accept = new Audio('accept.mp3');
                      accept.volume = 0.4;
                      accept.play();
                      var body = $('body'); 
                      body.fadeOut(700, function() {
                          $.post(`https://${GetParentResourceName()}/fobozo-npcdialogue:hideMenu`);
                      });
                  }
              };
          })(options[i]); 
      }
  }
  hideExtraButtons(options.length);
  adjustBackgroundHeight(options.length);
}

function hideButtons() {
  for (var i = 1; i <= 4; i++) {
      var button = getButtonElement(i);
      if (button) {
          button.style.display = 'none';
      }
  }
}

function hideExtraButtons(visibleButtonCount) {
  for (var j = visibleButtonCount + 1; j <= 4; j++) {
      var extraButton = getButtonElement(j);
      if (extraButton) {
          extraButton.style.display = 'none';
      }
  }
}

function adjustBackgroundHeight(visibleButtonCount) {
  var background = document.getElementById("dialogue-wrapper");
  if (visibleButtonCount > 2) {
      background.style.height = "95%";
  } else {
      background.style.height = "80%";
  }
}

function getButtonElement(index) {
  return document.getElementById("button-text-" + index);
}

window.addEventListener('message', function(event) {
  if (event.data.type === 'dialog') {
      updateButtons(event.data.options);
      var nameElement = document.getElementById("npc-name");
      nameElement.innerHTML = `<b>${event.data.name.split(' ')[0]}</b> ${event.data.name.split(' ')[1]}`;
      var textElement = document.getElementById("npc-text");
      textElement.innerHTML = `<div class="triangle-element"></div>${event.data.text}`;      
      var jobElement = document.getElementById("npc-job")
      jobElement.innerText = event.data.job
      document.body.style.display = 'block';
      var popup = new Audio('popup.mp3');
      popup.volume = 0.4;
      popup.play();
  } else if (event.data.type === 'hide') {
      document.body.style.display = 'none';
  } else if (event.data.type === 'updateRep') {
      var repElement = document.querySelector('.rep-text');
      repElement.innerText = `${event.data.rep} REP`;
  }
});

document.addEventListener('keydown', function(event) {
  var keyPressed = event.key;
  switch (keyPressed) {
      case '1':
          clickButton(1);
          break;
      case '2':
          clickButton(2);
          break;
      case '3':
          clickButton(3);
          break;
      case '4':
          clickButton(4);
          break;
      case 'Escape':
          var body = $('body');
          body.fadeOut(700, function() {
              var popupreverse = new Audio('popupreverse.mp3');
              popupreverse.volume = 0.4;
              popupreverse.play();
              $.post(`https://${GetParentResourceName()}/fobozo-npcdialogue:hideMenu`);
          });
          break;
  }
});

function clickButton(buttonIndex) {
  var accept = new Audio('accept.mp3');
  accept.volume = 0.4;
  accept.play();
  var button = getButtonElement(buttonIndex);
  if (button && button.style.display !== 'none') {
      button.click();
  }
}
