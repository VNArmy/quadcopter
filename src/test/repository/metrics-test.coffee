
define 'repository/metrics-test', ['spec-helper', 'mini-test-it'], (specHelper, it) ->

  it 'metrics repository should save metrics to file', (test) ->
    written = null

    stubs = {
      'espruino/time': (-> 56),
      'espruino/file': (-> append: (data) -> written = data)
      'configuration': features: saveAnalyticsToFile: true
    }

    specHelper.require 'repository/metrics', stubs, (metricsRepository) ->
      metricsRepository.save('loop-frequency-hz', '401')

      test.expect(written).toBe('56|loop-frequency-hz|401\n')
      test.done()

  it 'metrics repository should write to new file each time', (test) ->
    metricsFile = null

    stubs = {
      'utility/random-string-generator': -> 'ABCDE'
      'espruino/file': (filename) ->
        metricsFile = filename
        return append: (->)
      'configuration': features: saveAnalyticsToFile: true
    }

    specHelper.require 'repository/metrics', stubs, (metricsRepository) ->
      metricsRepository.save('my-fancy-metric', 'true')

      test.expect(metricsFile).toBe('metrics-ABCDE.txt')
      test.done()

  it 'metrics repository should return saved metrics', (test) ->

    stubs = {
      'utility/random-string-generator': -> 'ABCDE'
      'espruino/file': ->
        append: (->)
        read: -> 'my.file.contents'
      'configuration': features: saveAnalyticsToFile: true
    }
    specHelper.require 'repository/metrics', stubs, (metricsRepository) ->
      fileContents = metricsRepository.get()
      test.expect(fileContents).toBe 'my.file.contents'
      test.done()

  it 'metrics repository should not save analytics to file when feature toggle is turned off', (test) ->
    written = false

    stubs = {
      'utility/random-string-generator': -> 'ABCDE'
      'espruino/file': ->
        append: -> written = true
        read: (->)
      'configuration': features: saveAnalyticsToFile: false
    }

    specHelper.require 'repository/metrics', stubs, (metricsRepository) ->
      metricsRepository.save('loop-frequency-hz', '407')
      test.expect(written).toBe false
      test.done()
