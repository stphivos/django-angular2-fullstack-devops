(function ($) {
  function detectEnv() {
    var body = $('body');
    var envs = ['xs', 'sm', 'md', 'lg'];

    var el = $('<div>');
    el.appendTo($(body));

    for (var i = envs.length - 1; i >= 0; i--) {
      var env = envs[i];

      el.addClass('hidden-' + env);
      if (el.is(':hidden')) {
        el.remove();
        $(body).removeClass('xs sm md lg').addClass(env);
        return;
      }
    }
  }

  $(window).resize(function () {
    detectEnv();
  });

  detectEnv();

  $(document).ready(function () {
    // TODO: Do cool stuff here!
  });

})(jQuery);
