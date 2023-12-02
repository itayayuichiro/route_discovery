var result = [...document.getElementsByClassName('ren-article-card')].map(a => {
    var href = a.href
    var title = a.getElementsByClassName('ren-article-card__ttl')[0].innerText.replace(/"/g, "'")
    var img = a.querySelector('.ren-article-card__img img').src

    const result = `<a href="${href}" class="list_content">` + "\n" +
        `<div class="list_img">` + "\n" +
            `<img src="${img}" />` + "\n" +
        `</div>` + "\n" +
        `<div class="list_text">` + "\n" +
            `${title}` + "\n" +
            `<div class="from">from HOKKAIDO LOVE!</div>` + "\n" +
        `</div>` + "\n" +
    `</a>` + "\n"

    return result
}).join("\n")

console.log(result)
copy(result);
