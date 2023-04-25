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