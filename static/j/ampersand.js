$(document).ready(function () {
  $('body *').contents().each(function () {
    if (this.nodeType == 3 && this.nodeValue.indexOf('&') > -1) {
      $(this).replaceWith(this.nodeValue.replace('&', '<em class="amp">&</em>'));
    }
  });
});
