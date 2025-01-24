function back() {

    const urlParams = new URLSearchParams(window.location.search);
    const key1 = urlParams.get('key1');
    
  
    

    
const url = "C:/Users/pcit106/Desktop/Dharmik/Day5/home/home.html"
window.location.href = `${url}?key1=${key1}`; 


   
}
