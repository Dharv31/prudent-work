function validate(event){
    event.preventDefault();
    const email = document.myform.email.value;
    const password = document.myform.password.value;
    const role = document.myform.role.value;

    var userdata = localStorage.getItem(email);

    if(userdata){
        var user =  JSON.parse(userdata);
    }
    

    if(user[2]===password){

        if(role === 'User' && user[8] === 'User'){

            alert("user sucessfull login");
        
            window.location.href = `C:/Users/pcit106/Desktop/Dharmik/Day5/home/home.html?key1=${email}`;
            
        }else if(role === 'Admin'  && user[8] ==='Admin'){

            alert(" admin  sucessfull login");
        
            window.location.href = `C:/Users/pcit106/Desktop/Dharmik/Day5/Admin/adminhome.html?key1=${email}`;
            
        }else{
            console.log(role);
            alert("select correct role");
        }
     
       
    }else{
        alert("wrong email or password");
    }
}
function back(){
    window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/outhome/outhome.html";
}
