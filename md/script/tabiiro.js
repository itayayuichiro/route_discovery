var result = [...document.getElementsByClassName('ren-article-card')].map(a => {
    var href = a.href
    var title = a.getElementsByClassName('ren-article-card__ttl')[0].innerText
    var img = a.querySelector('.ren-article-card__img img').src
    return href + "," + title + "," + img
}).join("\n")

console.log(result)