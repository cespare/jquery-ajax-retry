/*
jQuery Ajax retry
https://github.com/cespare/jquery-ajax-retry
Requires jQuery 1.5+; tested with 1.7.2
Compiled with:
  $ coffee -cb jquery-ajax-retry.coffee
*/
$.ajaxPrefilter(function(options, originalOptions, jqXhr) {
  if (!(originalOptions.maxTries >= 2 && (originalOptions.timeout != null))) {
    return;
  }
  if (originalOptions.tries != null) {
    originalOptions.tries += 1;
  } else {
    originalOptions.tries = 1;
    originalOptions.realError = originalOptions.error;
  }
  return options.error = function(innerJqXhr, textStatus, httpError) {
    if (originalOptions.tries >= originalOptions.maxTries || textStatus !== "timeout") {
      if (originalOptions.realError != null) {
        originalOptions.error(innerJqXhr, textStatus, httpError);
      }
      return;
    }
    return $.ajax(originalOptions);
  };
});
