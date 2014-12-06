document.addEventListener('DOMContentLoaded', function() {
  var elm = document.getElementById('clan');
  elm.addEventListener('change', function() {
    if(elm.value) {
      setTimeout(function() { document.location.reload(true); }, 500);
      var chat = parent.frames.chatpane.document;
      chat.getElementById('graf').value = '/whitelist ' + elm.value;
      chat.forms.chatform.querySelector('input[type="submit"]').click();
    }
  });
});
