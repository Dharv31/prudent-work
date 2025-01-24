document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');

    const url1 = adminstudentDetail;
    document.getElementById("adminstudentdetail").href = `${url1}?key1=${key1}&key2=Admin`;

    const url = profile;
    document.getElementById("profile").href = `${url}?key1=${key1}&key2=Admin`;

    const url2 = request;
    document.getElementById("request").href = `${url2}?key1=${key1}&key2=Admin`;  
    
});
