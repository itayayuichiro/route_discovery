var result = [...document.querySelectorAll('.spotList dl')].map(dl => {
    var href = dl.querySelector('a').href
    var title = dl.querySelector('dt').innerText
    var img = dl.querySelector('img').src
    return '"hokkaido","', href + '","' + title + '","' + img + '"'
}).join("\n")

console.log(result)