function displayData() {
    var body = document.getElementById("data");

    for (let i = 0; i < localStorage.length; i++) {

        var data = localStorage.getItem(localStorage.key(i));

        var rowdata = JSON.parse(data);

        var imgPath = "C:Users/pcit106/Desktop/Dharmik/day 2/js/img/" + rowdata[7];

        if(rowdata[8] !== 'Admin'){
            body.innerHTML += `
            <tr>
                <td>${rowdata[0]}</td>
                 <td>${rowdata[8]}</td>
                <td>${rowdata[4]}</td>
                <td>${rowdata[3]}</td>
                <td>${rowdata[5]}</td>
                <td>${rowdata[6]}</td>
                
                <td>${rowdata[1]}</td>
                <td><button onclick="viewimage('${imgPath}')">view</button></td>
                ${rowdata[9] ? 
                        `<td id="delete"><button onclick="deleteData('${localStorage.key(i)}')">Delete</button></td>
                        <td id="update"><button onclick="updateData('${localStorage.key(i)}')">Update</button></td>` 
                        : 
                        `<td id="delete">No Access</td>
                        <td id="update">No Access</td>`}
               <td>${rowdata[10] === "false" ? "Pending" : "Approved"}</td>
            </tr>
        `;
        }

       
    }
}

window.onload = function () {
   
    displayData();
   
}

function deleteData(email) {
    localStorage.removeItem(email);
    document.getElementById("data").innerHTML = '';
    displayData();

}

function updateData(email){
    const url = "C:/Users/pcit106/Desktop/Dharmik/Day5/update/update.html";
    window.location.href = `${url}?key1=${email}`;

}

function viewimage(imgpath){
    document.getElementById("fullscreenimage").src = imgpath;
    document.getElementById("fullscreen").style.display = "flex";

}

function closeFullscreen(){
    document.getElementById("fullscreen").style.display = "none";
}

function back(){
    window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/home/home.html";
}
