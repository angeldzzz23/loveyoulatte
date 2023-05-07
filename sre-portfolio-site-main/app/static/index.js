// TODO: Query for button with an id "theme-button"
let themeButton = document.getElementById("theme-button");


const toggleDarkMode = () => {
    // Write your code to manipulate the DOM here

  // alert("Hello! I am an alert box!!");


    document.body.classList.toggle("dark-mode");

  if (document.body.classList.contains("dark-mode")) {
    themeButton.textContent = "Light Mode";
  } else {
    themeButton.textContent = "Dark Mode";
  }

  
}

// Set toggleDarkMode as the callback function.
themeButton.addEventListener("click", toggleDarkMode);

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



// let themeButton = document.getElementById("hey");
// themeButton.textContent = "Light Mode";


/*
Monday  8 AM–5 PM ->   9,17
Tuesday 8 AM–5 PM -> 9,17
Wednesday 8 AM–5 PM -> 9,17
Thursday  8 AM–5 PM -> 9,17
Friday   9 AM–4 PM -> 9,16
Saturday 9 AM–4 PM -> 9,16
Sunday   9 AM–4 PM -> 9,16

*/

// day 1 is monday, sunday = 7
// const days = [1,2,3,4,6,7];

// const daysToHours = new Map([
//   [1, [8,17]], // monday
//   [2, [8,17]], // Tuesday
//   [3, [8,17]], // Wednesday 
//   [4, [8,17]], // Thursday
//   [5, [9,16]],  // Friday 
//   [6, [9,16]], // Saturday 
//   [7, [9,16]] // sunday
// ]);

// // time 

// const day = 5;
// const hour = 9;
// var isOpen = false;

// // check the day 
// if (day >= 1 && day <= 4) {
//   // check the time 
//     if (hour >= 8 && hour <= 17) {
//       // open 
       
//       isOpen = true;
//     }  
    
// } else {
//   // check the time 
//  if (hour >= 9 && hour <= 16) {
//       isOpen = true;
//   } 

// }


// if (isOpen) {
//     themeButton.style.color = 'green';
//     themeButton.textContent = "Open";

// } else {
//   themeButton.style.color = 'red';
//    themeButton.textContent = "Closed";
// }




