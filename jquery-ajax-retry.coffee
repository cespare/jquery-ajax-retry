###
jQuery Ajax retry
https://github.com/cespare/jquery-ajax-retry
Requires jQuery 1.5+; tested with 1.7.2
Compiled with:
  $ coffee -cb jquery-ajax-retry.coffee
###
(($) ->
    $.ajaxPrefilter (options, originalOptions, jqXhr) ->
       options.maxTries = originalOptions.maxTries or 1
       if options.tries?
           options.tries += 1
       else
           options.tries = 1
           options.realError = originalOptions.error
       options.error = (innerJqXhr, textStatus, httpError) ->
           if options.tries < options.maxTries and 
	          ((textStatus == "error" and options.retryCodes and options.retryCodes.indexOf(innerJqXhr.status) != -1) or 
	          textStatus == "timeout")
              return $.ajax(options)
           else if options.realError?
              options.realError(innerJqXhr, textStatus, httpError)
)(jQuery)
