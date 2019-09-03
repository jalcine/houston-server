// Highlight code blocks

import hljs from 'highlight.js/lib/highlight'
import vala from 'highlight.js/lib/languages/vala'

hljs.registerLanguage('vala', vala);

console.log(hljs)

function createLineHtml (count) {
  const ul = document.createElement('ul')
  ul.className = 'pre-numbering'

  for (var l = 1; l <= count; l++) {
    let li = document.createElement('li')
    li.innerHTML = l

    ul.append(li)
  }

  return ul
}

document.querySelectorAll('pre code').forEach((el) => {
  const classes = el.className.split(' ')

  const highlighted = !classes.includes('nohighlight')
  const isBash = classes.includes('language-bash')

  if (highlighted && !isBash) {
    const lineCount = el.innerHTML.trim().split('\n').length
    const lineHtml = createLineHtml(lineCount)

    el.parentNode.insertBefore(lineHtml, el)
  }

  if (highlighted) {
    hljs.highlightBlock(el)
  } else {
    el.className += ' hljs'
  }

  el.parentNode.className += ' highlighted'
})
