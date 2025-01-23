function Myfunction() {
    var element = document.querySelector(".navitems");
    element.classList.toggle("active");
}

function lightmode() {
    document.getElementById("dark").style.display = "none";
    document.getElementById("light").style.display = "block";
    document.body.style.backgroundColor = "white";
    document.body.style.color = "black";
    /*document.querySelector(".navitems.active").style.backgroundColor = "black";
    document.querySelector(".navitems.active:hover").style.color = "palevioletred";
    document.querySelectorAll(".navitem.active.a").forEach(function (link) {
        link.style.color = "white";
    });*/
    



}

function darkmode() {
    document.body.style.backgroundColor = "black";
    document.body.style.color = "white";
    document.getElementById("dark").style.display = "block"; 
    document.getElementById("light").style.display = "none";

    /*document.querySelector(".navitems.active").style.backgroundColor = "white";
    document.querySelector(".navitems.active:hover").style.color = "palevioletred";

    document.querySelectorAll(".navitem.active.a").forEach(function (link) {
        link.style.color = "black";
    });*/

}

