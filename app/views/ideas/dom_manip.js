let descriptions = document.querySelectorAll("small")
descriptions.forEach(d =>{
    d.hidden = true;
})
function logItem(e) {
    const item = document.querySelector(`idea-title-${e.target.id}]`);
    item.toggleAttribute('hidden');
  }
  
  const chapters = document.querySelectorAll('details');
  chapters.forEach((chapter) => {
    chapter.addEventListener('toggle', logItem);
  });
let headings = document.querySelectorAll("#idea-title");

// headings.forEach(title => {
//     let button = document.createElement("input")
//     button.setAttribute("type","image")
//     button.setAttribute("src", "https://upload.wikimedia.org/wikipedia/commons/a/a2/Icon_Add_256x256.png")
//     button.style.height = "20px";
//     title.prepend(button);
// })

let buttons = document.querySelectorAll(`#idea-title > input`)
buttons.forEach(button => {
    button.addEventListener("click", event =>{
            if(event.currentTarget == button){
                // console.log("plus was hit")
                let btn = event.currentTarget;
                let sml = btn.parentElement.nextElementSibling
                sml.hidden = false;
            }
        })
})