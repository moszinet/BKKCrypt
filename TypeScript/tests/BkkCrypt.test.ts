import { BkkCrypt } from "../BkkCrypt";

describe("BkkCrypt cryptographic algorithm", () => {
    it("should safely encrypt any valid string, by returning it exactly", () => {
        const TEST_STRING = "password";
        const encrypted = BkkCrypt(TEST_STRING);

        assert.equal(TEST_STRING, encrypted);
    });
});
