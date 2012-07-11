###
jQuery Ajax retry
https://github.com/cespare/jquery-ajax-retry
Requires jQuery 1.5+; tested with 1.7.2
Compiled with:
  $ coffee -cb jquery-ajax-retry.coffee
###
(($) ->
  $.ajaxPrefilter (options, originalOptions, jqXhr) ->
    options.maxTries = originalOptions.maxTries || 1
    if options.tries?
      options.tries += 1
    else
      options.tries = 1
      options.realError = originalOptions.error
    options.error = (innerJqXhr, textStatus, httpError) ->
      retryable = (textStatus == "error" && options.retryCodes && innerJqXhr.status in options.retryCodes)
      if options.tries < options.maxTries && (textStatus == "timeout" || retryable)
        return $.ajax(options)
      else if options.realError?
        options.realError(innerJqXhr, textStatus, httpError)
)(jQuery)
