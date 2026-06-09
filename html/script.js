window.addEventListener('message', function(event) {
    let data = event.data;

    if (data.action === "open") {
        document.getElementById('cam-title').innerText = data.title;
        document.getElementById('player-name').innerText = data.name;
        document.getElementById('cam-logo').src = data.logo;
        document.getElementById('bodycam-container').style.display = "block";
    } 
    else if (data.action === "close") {
        document.getElementById('bodycam-container').style.display = "none";
    } 
    else if (data.action === "updateTime") {
        document.getElementById('date-time').innerText = data.time;
    }
});
