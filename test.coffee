Settings =
  success:
    url: "/test.json"
  success1Try:
    url: "/test.json"
    timeout: 300
    maxTries: 1
  success3Tries:
    url: "/test.json"
    timeout: 300
    maxTries: 3
  failure:
    url: "/foobar"
  failure1Try:
    url: "/foobar"
    timeout: 300
    maxTries: 1
    retryCodes: [404]
  failure3Tries:
    url: "/foobar"
    timeout: 300
    maxTries: 3
    retryCodes: [404]
  timeout3Tries:
    url: "http://www.google.com"
    timeout: 1 # Hopefully google will not respond in <= 1ms :P
    maxTries: 3

Criteria =
  success: (tries, successOrFailure) -> tries == 1 && successOrFailure == "success"
  success1Try: (tries, successOrFailure) -> tries == 1 && successOrFailure == "success"
  success3Tries: (tries, successOrFailure) -> tries == 1 && successOrFailure == "success"
  failure: (tries, successOrFailure) -> tries == 1 && successOrFailure == "error"
  failure1Try: (tries, successOrFailure) -> tries == 1 && successOrFailure == "error"
  failure3Tries: (tries, successOrFailure) -> tries == 3 && successOrFailure == "error"
  timeout3Tries: (tries, successOrFailure) -> tries == 3 && successOrFailure == "error"

Test =
  start: ->
    $.ajaxPrefilter (options, originalOptions, jqXhr) -> Test.tries += 1
    Test.currentRow = $("tr").first()
    @runTest()

  runTest: ->
    Test.tries = 0
    $cell = Test.currentRow.children("td")
    testName = $cell.attr("data-name")
    Test.changeColor($cell, "#e5a700")
    options =
      method: "get"
      dataType: "json"
      success: -> Test.determineTestStatus(testName, $cell, "success")
      error: -> Test.determineTestStatus(testName, $cell, "error")
    options[settingName] = settingValue for settingName, settingValue of Settings[testName]
    $.ajax(options)

  determineTestStatus: (testName, $cell, successOrFailure) ->
    if Criteria[testName](Test.tries, successOrFailure)
      Test.changeColor($cell, "#24a748")
      $cell.text($cell.text() + " \u2713")
    else
      Test.changeColor($cell, "#e83d32")
      $cell.text($cell.text() + " \u2717")
    Test.currentRow = Test.currentRow.next()
    @runTest() unless Test.currentRow.size() == 0

  changeColor: ($element, color) -> $element.css({ "background-color": color })

$(document).ready -> Test.start()
