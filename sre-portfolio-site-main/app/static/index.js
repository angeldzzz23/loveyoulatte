// TODO: Query for button with an id "theme-button"
let themeButton = document.getElementById("theme-button");

let aNotherButton = document.getElementsByClassName("theme-button");


const toggleDarkMode = () => {
    // Write your code to manipulate the DOM here

  // alert("Hello! I am an alert box!!");


    document.body.classList.toggle("dark-mode");

  if (document.body.classList.contains("dark-mode")) {
    aNotherButton[0].textContent = "Light Mode";
    aNotherButton[1].textContent = "Light Mode";
  } else {
    aNotherButton[0].textContent = "Dark Mode"
    aNotherButton[1].textContent = "Dark Mode"
  }

  
}

// Set toggleDarkMode as the callback function.
// themeButton.addEventListener("click", toggleDarkMode);

aNotherButton[0].addEventListener("click", toggleDarkMode);
aNotherButton[1].addEventListener("click", toggleDarkMode);











// adding animation related aspects 
let animation = {
  revealDistance: 150,
  initialOpacity: 0,
  transitionDelay: 0,
  transitionDuration: '2s',
  transitionProperty: 'all',
  transitionTimingFunction: 'ease'
};





let revealableContainers = document.querySelectorAll('.revealable');

const reveal = () => {
  for (let i = 0; i < revealableContainers.length; i++) {
    let windowHeight = window.innerHeight;
    let topOfRevealableContainer = revealableContainers[i].getBoundingClientRect().top;
    if (topOfRevealableContainer < windowHeight - animation.revealDistance) {
      revealableContainers[i].classList.add('active');
    }
    else {
      revealableContainers[i].classList.remove('active');
    }
  }
}

window.addEventListener('scroll', reveal);


// day 1 is monday, sunday = 7


let workingHoursHeader = document.getElementById("workingHours");
const d = new Date();
let hour = d.getHours();
let day = d.getDay();
var isOpen = false;

// check the day 
if (day >= 1 && day <= 4) {
  // check the time 
    if (hour >= 8 && hour <= 17) {
      // open 
       
      isOpen = true;
    }  
    
} else {
  // check the time 
 if (hour >= 9 && hour <= 16) {
      isOpen = true;
  } 

}


if (isOpen) {
    // workingHoursHeader.style.color = 'green';
    workingHoursHeader.textContent +=  " 😁🤙☕️";

} else {
  // workingHoursHeader.style.color = 'red';
   workingHoursHeader.textContent += " 😴";
}

// added new function
function myFunction() {
  var x = document.getElementById("myLinks");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}




