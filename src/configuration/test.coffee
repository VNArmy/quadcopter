define 'configuration', ->
  overrides:
    digitalPulse: (->)
    setWatch: (->)
    serial:
      setup: (->)
      write: (->)
  throttle:
    inputPin: 1
  propeller:
    frontLeft:
      outputPin: 2
    frontRight:
      outputPin: 3
    backLeft:
      outputPin: 4
    backRight:
      outputPin: 5
  serial:
    baudRate: 9600
    rx: 6
    tx: 7
  features:
    saveAnalyticsToFile: false
