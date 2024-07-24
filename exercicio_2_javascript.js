let numerosDaSorte = [37, 14, 26, 5, 94, 87];
numerosDaSorte.forEach((elemento) => {
  if (elemento % 2 == 0 && elemento < 50) {
    console.log(elemento, 'é par e menor que 50');
  } else if(elemento < 50){
    console.log(elemento, 'é menor que 50');
  } else if(elemento > 50){
    console.log(elemento, 'é maior que 50');
  }
});
