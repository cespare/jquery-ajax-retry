/*
jQuery Ajax retry
https://github.com/cespare/jquery-ajax-retry
Requires jQuery 1.5+; tested with 1.7.2
Compiled with:
  $ coffee -cb jquery-ajax-retry.coffee
*/
var __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

(function($) {
  return $.ajaxPrefilter(function(options, originalOptions, jqXhr) {
    options.maxTries = originalOptions.maxTries || 1;
    if (options.tries != null) {
      options.tries += 1;
    } else {
      options.tries = 1;
      options.realError = originalOptions.error;
    }
    return options.error = function(innerJqXhr, textStatus, httpError) {
      var retryable, _ref;
      retryable = textStatus === "error" && options.retryCodes && (_ref = innerJqXhr.status, __indexOf.call(options.retryCodes, _ref) >= 0);
      if (options.tries < options.maxTries && (textStatus === "timeout" || retryable)) {
        return $.ajax(options);
      } else if (options.realError != null) {
        return options.realError(innerJqXhr, textStatus, httpError);
      }
    };
  });
})(jQuery);
