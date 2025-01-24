const urlParams = new URLSearchParams(window.location.search);
const key1 = urlParams.get('key1');

var data = localStorage.getItem(key1);

var userdata = JSON.parse(data);


document.getElementById("username").innerHTML = `Hello ${userdata[0]}`;

const url = "C:/Users/pcit106/Desktop/Dharmik/Day5/profile/profile.html"
document.getElementById("studentDetail").href = `${url}?key1=${key1}&key2=User`; 



const url2 = "C:/Users/pcit106/Desktop/Dharmik/Day5/Contact/contact.html"
document.getElementById("contact").href = `${url2}?key1=${key1}`; 