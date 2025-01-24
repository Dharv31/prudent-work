function back() {

    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');
    
  
    

    
const url = home;
window.location.href = `${url}?key1=${key1}`; 


   
}
