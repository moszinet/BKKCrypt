[<TestFixture>]
type BKKCryptTests() = 

    [<Test>]
    member this.EncryptAsdfInputReturnsAsdf() = 
        Assert.AreEqual('asdf', encrypt 'asdf')


    [<Test>]
    member this.EncryptYoloInputReturnsYolo() =
        Assert.AreEqual('yolo', encrypt 'yolo')
