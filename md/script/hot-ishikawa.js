var result = [...document.getElementsByClassName('spotContent')].map(a => {
    var href = a.querySelector('a').href
    var title = a.querySelector('h3').innerText.replace(/"/g, "'")
    var img = a.querySelector('img').src

    const result = `<a href="${href}" class="list_content">` + "\n" +
        `<div class="list_img">` + "\n" +
            `<img src="${img}" />` + "\n" +
        `</div>` + "\n" +
        `<div class="list_text">` + "\n" +
            `${title}` + "\n" +
            `<div class="from">from ほっと石川旅ねっと</div>` + "\n" +
        `</div>` + "\n" +
    `</a>` + "\n"

    return result
}).join("\n")

console.log(result)
copy(result);