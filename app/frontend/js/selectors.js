export function component(name) {
  return document.querySelector(`[data-component='${name}']`);
}

export function components(name) {
  return document.querySelectorAll(`[data-component='${name}']`);
}
