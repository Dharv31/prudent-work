function displayData() {
    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');

    var data = localStorage.getItem(key1);

    var userdata = JSON.parse(data);

    document.getElementById("name").innerHTML = userdata[0];
    document.getElementById("email").innerHTML = userdata[1];
    document.getElementById("role").innerHTML = userdata[8];
    document.getElementById("date").innerHTML = userdata[4];
    document.getElementById("phone").innerHTML = userdata[3];
    document.getElementById("semester").innerHTML = userdata[5];
    document.getElementById("address").innerHTML = userdata[6];
    var imgPath = "C:Users/pcit106/Desktop/Dharmik/day 2/js/img/" + userdata[7];
    document.getElementById("img").innerHTML = `<button onclick="viewimage('${imgPath}')">view</button>`;


    document.getElementById("delete").innerHTML = ` ${userdata[9] ?
        `<button onclick="deleteData('${userdata[1]}')">Delete</button>`

        :
        `No Access`}`
    document.getElementById("update").innerHTML = ` ${userdata[9] ?
        `
                       <button onclick="updateData('${userdata[1]}')">Update</button>`
        :
        `
                        No Access`}`


    document.getElementById("approval").innerHTML = `${userdata[10] === "false" ? "Pending" : "Approved"}`



}





window.onload = function () {

    displayData();

}

function deleteData(email) {
    localStorage.removeItem(email);
    document.getElementById("data").innerHTML = '';
    displayData();

}

function updateData(email) {
    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');
    const key2 = urlParams.get('key2');
    var data = localStorage.getItem(key1);

    var userdata = JSON.parse(data);


    
    if (key2 === 'Admin') {
        
        url1 =update;
        window.location.href = `${url1}?key1=${key1}&key2=Admin`;
    } else if (key2 === 'User'){
       
        const url2 = update;
        window.location.href = `${url2}?key1=${key1}&Key2=User`;
    }


    // const url = "C:/Users/pcit106/Desktop/Dharmik/Day5/update/update.html";
    // window.location.href = `${url}?key1=${email}`;

}

function viewimage(imgpath) {
    document.getElementById("fullscreenimage").src = imgpath;
    document.getElementById("fullscreen").style.display = "flex";

}

function closeFullscreen() {
    document.getElementById("fullscreen").style.display = "none";
}

function back() {
    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');
    const key2 = urlParams.get('key2');
    var data = localStorage.getItem(key1);

    var userdata = JSON.parse(data);


    
    if (key2 === 'Admin') {
        
        url1 =adminhome;
        window.location.href = `${url1}?key1=${key1}&key2=Admin`;
    } else if (key2 === 'User'){
       
        const url2 = home;
        window.location.href = `${url2}?key1=${key1}&Key2=User`;
    }


   


}
