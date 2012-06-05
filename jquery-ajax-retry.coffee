###
jQuery Ajax retry
https://github.com/cespare/jquery-ajax-retry
Requires jQuery 1.5+; tested with 1.7.2
Compiled with:
  $ coffee -cb jquery-ajax-retry.coffee
###
$.ajaxPrefilter (options, originalOptions, jqXhr) ->
  return unless (originalOptions.maxTries >= 2 && originalOptions.timeout?)

  if originalOptions.tries?
    originalOptions.tries += 1
  else
    originalOptions.tries = 1
    originalOptions.realError = originalOptions.error

  options.error = (innerJqXhr, textStatus, httpError) ->
    if originalOptions.tries >= originalOptions.maxTries || textStatus != "timeout"
      originalOptions.error(innerJqXhr, textStatus, httpError) if originalOptions.realError?
      return
    $.ajax(originalOptions)
