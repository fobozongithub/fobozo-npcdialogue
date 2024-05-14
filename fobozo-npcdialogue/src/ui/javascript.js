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
    const buttonGroup = document.getElementById('button-group');
    buttonGroup.innerHTML = '';

    if (!options || options.length === 0) {
        hideButtons();
        return;
    }

    for (let i = 0; i < options.length; i++) {
        const option = options[i];
        const button = document.createElement('button');
        button.className = 'action-button';
        button.innerHTML = `<div class="button-number" id="button-${i + 1}">${i + 1}</div>${option.label}`;
        button.onclick = function () {
            $.post(`https://fobozo-npcdialogue/fobozo-npcdialogue:process`, JSON.stringify({
                event: option.event,
                args: option.args,
                type: option.type
            }));
            var accept = new Audio('accept.mp3');
            accept.volume = 0.4;
            accept.play();

            var body = document.body;
            body.style.animation = 'slideOutFadeOut 0.5s ease forwards';
            $.post(`https://fobozo-npcdialogue/fobozo-npcdialogue:hideMenu`); // Immediately call hideMenu
            setTimeout(function () {
                body.style.display = 'none';
                body.style.animation = ''; // Reset animation
            }, 500);
        };
        buttonGroup.appendChild(button);
    }

    if (options.length % 2 !== 0) {
        buttonGroup.lastChild.style.gridColumn = "1 / span 2";
    }
}

function hideButtons() {
    const buttonGroup = document.getElementById('button-group');
    buttonGroup.innerHTML = '';
}

window.addEventListener('message', function (event) {
    const body = document.body;
    if (event.data.type === 'dialog') {
        updateButtons(event.data.options);
        const nameElement = document.getElementById("npc-name");
        nameElement.innerHTML = `<b>${event.data.name.split(' ')[0]}</b> ${event.data.name.split(' ')[1]}`;
        const innerTitleElement = document.querySelector(".content-wrapper .dialogue-title");
        innerTitleElement.innerText = event.data.name; // Update inner title

        const textElement = document.getElementById("npc-text");
        textElement.innerHTML = `<div class="triangle-element"></div>${event.data.text}`;
        const jobElement = document.getElementById("npc-job");
        jobElement.innerText = event.data.job;

        body.style.animation = 'slideInFadeIn 0.5s ease forwards';
        body.style.display = 'block';

        const popup = new Audio('popup.mp3');
        popup.volume = 0.4;
        popup.play();
    } else if (event.data.type === 'hide') {
        body.style.display = 'none';
    } else if (event.data.type === 'updateRep') {
        const repElement = document.querySelector('.rep-text');
        repElement.innerText = `${event.data.rep} REP`;
    }
});

document.addEventListener('keydown', function (event) {
    const keyPressed = event.key;
    const body = document.body;
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
            body.style.animation = 'slideOutFadeOut 0.5s ease forwards';
            $.post(`https://fobozo-npcdialogue/fobozo-npcdialogue:hideMenu`);
            setTimeout(function () {
                var popupreverse = new Audio('popupreverse.mp3');
                popupreverse.volume = 0.4;
                popupreverse.play();
                body.style.display = 'none';
                body.style.animation = '';
            }, 500);
            break;
    }
});

function clickButton(buttonIndex) {
    var accept = new Audio('accept.mp3');
    accept.volume = 0.4;
    accept.play();
    var button = document.querySelector(`.action-button:nth-child(${buttonIndex})`);
    if (button && button.style.display !== 'none') {
        button.click();
    }
}
