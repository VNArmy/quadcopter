define 'configuration', ->
  overrides:
    digitalPulse: digitalPulse
    setWatch: setWatch
  throttle:
    inputPin: A13
  propeller:
    frontLeft:
      outputPin: C6
    frontRight:
      outputPin: C7
    backLeft:
      outputPin: C8
    backRight:
      outputPin: C9