<TestClass()> Public Class BKKCryptUnitTest

    <TestMethod()> Public Sub TestEncrypt()
        Dim superPassword = "mySuperPassword"
        Dim crypt = New BKKCrypt.BKKCrypt()

        Assert.AreEqual(superPassword, crypt.Encrypt(superPassword))
    End Sub

End Class