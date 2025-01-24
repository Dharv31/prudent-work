const urlParams = new URLSearchParams(window.location.search);
const key1 = urlParams.get('key1');

var data = localStorage.getItem(key1);

var userdata = JSON.parse(data);


document.getElementById("username").innerHTML = `Hello ${userdata[0]}`;

const url = profile;
document.getElementById("studentDetail").href = `${url}?key1=${key1}&key2=User`; 



const url2 = contact;
document.getElementById("contact").href = `${url2}?key1=${key1}`; 