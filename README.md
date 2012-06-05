This is a simple jquery 'plugin' to help with retrying ajax requests. It's not a real plugin because it
doesn't use the plugin architecture; rather, it uses a single call to
[`ajaxPrefilter`](http://api.jquery.com/jQuery.ajaxPrefilter/) to modify the way ajax requests work. This does
not provide delays between attempts (backoff); there are other plugins that provide that kind of
functionality.

## Usage

Include the JS script on your page. (The JS is generated from the coffeescript).

``` javascript
$.ajax({
  method: "get",
  url: "/some/path",
  dataType: "json",
  success: function(data, textStatus, jqXHR) { ... }
  error: function(jqXHR, textStatus, httpError) { ... }

  // retry options
  timeout: 3000, // [required] You must provide a timeout to use retries
  maxTries: 3    // [required] How many times to retry.
})
```

## Compatibility

Might work with any 1.5+ version of jQuery. Tested with 1.7.2.

## Credits

Taken from the technique here:

[http://www.moretechtips.net/2012/04/retrying-ajax-requests-with-jquery.html](http://www.moretechtips.net/2012/04/retrying-ajax-requests-with-jquery.html)

## License

[This work is under the MIT License](http://www.opensource.org/licenses/mit-license.php)
