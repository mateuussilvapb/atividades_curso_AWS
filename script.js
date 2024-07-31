const titulo = document.getElementById("titulo");
titulo.innerHTML = "Ola, mundo!";

const link = document.querySelector("a");
link.innerText = "Acessar o Proz";

const orderList = document.querySelector("ol");
const unorderList = document.querySelector("ul");

orderList.innerHTML = `<li><a href="#">Item 1</a></li><li><a href="#">Item 2</a></li><li><a href="#">Item 3</a></li>`;
unorderList.innerHTML = "<li>Item 1</li><li>Item 2</li><li>Item 3</li>";
