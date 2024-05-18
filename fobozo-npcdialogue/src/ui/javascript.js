window.onload = function () {
    const buttons = document.querySelectorAll('.action-button');
    const buttonGroup = document.getElementById('button-group');

    if (buttons.length === 1) {
        buttons[0].style.gridColumn = "1 / span 2";
    } else if (buttons.length % 2 !== 0) {
        buttons[buttons.length - 1].style.gridColumn = "1 / span 2";
    }
};

function updateButtons(options, pedModel) {
    const buttonGroup = document.getElementById('button-group');
    buttonGroup.innerHTML = '';

    if (!options || options.length === 0) {
        hideButtons();
        return;
    }

    const playerRep = parseInt(document.querySelector('.rep-text').innerText.split(' ')[0]);
    let visibleOptions = 0;

    for (let i = 0; i < options.length; i++) {
        const option = options[i];
        if (playerRep >= (option.repRequired || 0)) {
            visibleOptions++;
            const button = document.createElement('button');
            button.className = 'action-button';
            button.innerHTML = `<span>${visibleOptions}</span> ${option.label}`;
            button.onclick = function () {
                if (!button.classList.contains('disabled')) {
                    $.post(`https://fobozo-npcdialogue/fobozo-npcdialogue:process`, JSON.stringify({
                        pedModel: pedModel,
                        optionLabel: option.label
                    }));
                    button.classList.add('disabled');
                    if (option.disableAfterUpdate) {
                        button.classList.add('disabled');
                    }
                    var accept = new Audio('accept.mp3');
                    accept.volume = 0.4;
                    accept.play();
                }
            };
            buttonGroup.appendChild(button);
        }
    }

    if (visibleOptions % 2 !== 0) {
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
        document.querySelector('.header-section').innerHTML = `
            <div class="dialogue-title" id="npc-name">${event.data.name}</div>
            <div class="rep-wrapper">
                <p class="rep-text" id="npc-rep">${event.data.rep} REP</p>
            </div>
            <div class="content-wrapper">
                <div class="dialogue-title" id="npc-inner-title">${event.data.name}</div>
                <div class="position-wrapper">
                    <p class="position-text" id="npc-job">${event.data.job}</p>
                </div>
            </div>
            <div class="dialogue-content" id="npc-text">
                <div class="triangle-element"></div>${event.data.text}
            </div>
        `;
        updateButtons(event.data.options, event.data.pedModel);
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
    } else if (event.data.type === 'appendText') {
        const newTextElement = document.createElement("div");
        newTextElement.className = "dialogue-content";
        newTextElement.innerHTML = `<div class="triangle-element"></div>${event.data.text}`;
        document.querySelector(".header-section").appendChild(newTextElement);
    } else if (event.data.type === 'disableButton') {
        const buttons = document.querySelectorAll('.action-button');
        buttons.forEach(button => {
            if (button.textContent.includes(event.data.label)) {
                button.classList.add('disabled');
            }
        });
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
    var button = document.querySelector(`.action-button:nth-child(${buttonIndex})`);
    if (button && button.style.display !== 'none' && !button.classList.contains('disabled')) {
        button.click();
    }
}
