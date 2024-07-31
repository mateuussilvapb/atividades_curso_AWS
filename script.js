/**
 * Crie um projeto com dois arquivos: index.html e script.js.
 * No arquivo 'index' insira apenas a estrutura base HTML e a
 * tag script para conectar o arquivo HTML com o arquivo de extensão JavaScript.
 *
 * Usando os conceitos aprendidos nesse módulo, e sem alterar o arquivo index.html,
 * adicione um título simples ao site com o id 'titulo', e um elemento que represente
 * um produto à venda. O produto precisa incluir pelo menos o nome, a descrição e o preço.
 * Pode incluir outros "elementos filhos" se achar necessário como, por exemplo, uma imagem.
 * Procure usar o método simples e o método complexo, ensinados neste tópico.
 */

const titulo = document.createElement("header");

titulo.innerHTML = `
    <h1 id="titulo">Produto à venda</h1>
`;

const divProduto = document.createElement("section");
divProduto.innerHTML = `
    <h2>Notebook</h2>
    <p>12gb Ram, i7, 512GB de SSD</p>
    <p>R$ 3.500,00</p>
`;

const body = document.querySelector("body");

body.appendChild(titulo);
body.appendChild(divProduto);

body.innerHTML += `
    <img src="https://picsum.photos/200/300" alt="Imagem do produto">
`;
