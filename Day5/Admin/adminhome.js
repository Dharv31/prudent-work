document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');

    const url1 = "C:/Users/pcit106/Desktop/Dharmik/Day5/Admin/Adminstudentdetail/adminstudentDetail.html";
    document.getElementById("adminstudentdetail").href = `${url1}?key1=${key1}&key2=Admin`;

    const url = "C:/Users/pcit106/Desktop/Dharmik/Day5/profile/profile.html";
    document.getElementById("profile").href = `${url}?key1=${key1}&key2=Admin`;

    const url2 = "C:/Users/pcit106/Desktop/Dharmik/Day5/Admin/rquest/request.html";
    document.getElementById("request").href = `${url2}?key1=${key1}&key2=Admin`;  
    
});
