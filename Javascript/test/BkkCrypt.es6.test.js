import { BkkCrypt } from '../BkkCrypt.es6'

describe('BkkCrypt cryptographic algorythm', () => {
  it('should safely encrypt any valid string, by returning it exactly', () => {
    const TEST_STRING = 'test'
    const encrypted = BkkCrypt(TEST_STRING)

    assert.equal(TEST_STRING, encrypted)
  })
})
