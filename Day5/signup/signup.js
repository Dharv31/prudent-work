
function validate(event) {
    event.preventDefault();

    const name = document.myform.name.value;

    const email = document.myform.email.value;
    const password = document.myform.password.value;
    const number = document.myform.number.value;
    const date = document.myform.dob.value;
    const sem = document.myform.semester.value;
    const address = document.myform.Address.value;
    const role =  document.myform.role.value;
    const img = document.getElementById("img").files[0];
    const imgName = img ? img.name : '';
    const admincode = document.myform.admincode.value;


    let access = 'false';
    let approve = 'false';
    
    


    var arr = [name, email, password, number, date, sem, address, imgName , role ,access, approve ];



    const pattern1 = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    const pattern2 = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;

    const phonenumber = /^\d{10}$/;

    if (!(phonenumber.test(number))) {
        alert("Enter 10 digit phone number");
        return false;
    }


    if (!(pattern1.test(email))) {
        alert("Email is not matching the required format");
        return false;
    }


    if (!(pattern2.test(password))) {
        alert("Password must contain at least one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long.");
        return false;
    }

    if (localStorage.getItem(email) === null) {
        if(admincode === "Dharmik" && role === 'Admin'){
            localStorage.setItem(email, JSON.stringify(arr));
            alert("Admin sign up sucessfully");
            window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/login/login.html";
        }else if(role === 'User'){
            localStorage.setItem(email, JSON.stringify(arr));
            alert("USer sign up sucessfully");
            window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/login/login.html";
        }else{

            alert("Enter admin code to signup as admin")
        }
       
    } else {
        
        if(key1){
            const data = localStorage.getItem(email);
            const userdata = JSON.parse(data);
            localStorage.removeItem(userdata[1]);
            localStorage.setItem(userdata[1],JSON.stringify(arr));
            window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/StudentDetail/studentDetail.html";

        }else{
            alert("user already present");
        }
    }




    return true;
}
function back() {
    window.location.href = "C:/Users/pcit106/Desktop/Dharmik/Day5/outhome/outhome.html";
}

const urlParams = new URLSearchParams(window.location.search);
const key1 = urlParams.get('key1');
if(key1){
    updateData(key1);

}

function updateData(email){
    const data = localStorage.getItem(email);
    const userdata = JSON.parse(data);

    document.myform.name.value  = userdata[0];

     document.myform.email.value = userdata[1];
     document.myform.password.value = userdata[2];
     document.myform.number.value  = userdata[3];
     document.myform.dob.value = userdata[4];
     document.myform.semester.value = userdata [ 5];
     document.myform.Address.value = userdata[6];
     document.myform.role.value = userdata[8];

     const file  = new File([''],userdata[7],{type: 'image/jpg/png'});
     const datatransfer = new DataTransfer();
     datatransfer.items.add(file);

     document.myform.img.files = datatransfer.files;
   
}