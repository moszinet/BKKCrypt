using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BKK
{
    [TestClass]
    public class EncryptionTests
    {
        /// <summary>
        /// Encryptor test
        /// </summary>
        [TestMethod]
        public void EncryptionTest()
        {
            //Arrange
            const string password = "mySuperSecurePassword";
            BKKCrypt bkkCrypt = new BKKCrypt();

            //Act
            string encryptedPassword = bkkCrypt.Encrypt(password);

            //Assert
            Assert.IsNotNull(password);
            Assert.IsNotNull(encryptedPassword);
            Assert.AreEqual(encryptedPassword, password);
            Assert.AreNotEqual(encryptedPassword,
                "394257263CF893FE61D72E8E3B1E625F297CDACD5FD2774C0239C4A8A1D4D783F7363B4A20A3848BFD7A7A6833EB858A631CECBE2A297F3AB868111028E4FEF6"); //sha512
        }

        /// <summary>
        /// Encrypt extension method test
        /// </summary>
        [TestMethod]
        public void EncryptExtensionMethodTest()
        {
            //Arrange
            const string password = "mySuperSecurePassword";

            //Act
            string encryptedPassword = password.Encrypt();

            //Assert
            Assert.IsNotNull(password);
            Assert.IsNotNull(encryptedPassword);
            Assert.AreEqual(encryptedPassword, password);
            Assert.AreNotEqual(encryptedPassword,
                "394257263CF893FE61D72E8E3B1E625F297CDACD5FD2774C0239C4A8A1D4D783F7363B4A20A3848BFD7A7A6833EB858A631CECBE2A297F3AB868111028E4FEF6"); //sha512
        }

        [TestMethod]
        public void CryptStrategyTest()
        {
            //Arrange
            const string password = "mySuperSecurePassword";
            StrategyContext context = new StrategyContext(new BKKCryptStrategy());

            //Act
            string encryptedPassword = context.Crypt(password);

            //Assert
            Assert.IsNotNull(password);
            Assert.IsNotNull(encryptedPassword);
            Assert.AreEqual(encryptedPassword, password);
            Assert.AreNotEqual(encryptedPassword,
                "394257263CF893FE61D72E8E3B1E625F297CDACD5FD2774C0239C4A8A1D4D783F7363B4A20A3848BFD7A7A6833EB858A631CECBE2A297F3AB868111028E4FEF6"); //sha512
        }

        [TestMethod]
        public void FactoryEncryptionTest()
        {
            //Arrange
            const string password = "mySuperSecurePassword";
            BKKCrypt bkkCrypt = (BKKCrypt)new BkkCryptFactory().CreateCrypt();

            //Act
            string encryptedPassword = bkkCrypt.Encrypt(password);

            //Assert
            Assert.IsNotNull(password);
            Assert.IsNotNull(encryptedPassword);
            Assert.AreEqual(encryptedPassword, password);
            Assert.AreNotEqual(encryptedPassword,
                "394257263CF893FE61D72E8E3B1E625F297CDACD5FD2774C0239C4A8A1D4D783F7363B4A20A3848BFD7A7A6833EB858A631CECBE2A297F3AB868111028E4FEF6"); //sha512
        }

        [TestMethod]
        public void FactoryCryptStrategyTest()
        {
            //Arrange
            const string password = "mySuperSecurePassword";
            StrategyContext context = new ContextFactory().CreateContext(new BKKStrategyFactory().CreateStrategy());

            //Act
            string encryptedPassword = context.Crypt(password);

            //Assert
            Assert.IsNotNull(password);
            Assert.IsNotNull(encryptedPassword);
            Assert.AreEqual(encryptedPassword, password);
            Assert.AreNotEqual(encryptedPassword,
                "394257263CF893FE61D72E8E3B1E625F297CDACD5FD2774C0239C4A8A1D4D783F7363B4A20A3848BFD7A7A6833EB858A631CECBE2A297F3AB868111028E4FEF6"); //sha512
        }
    }
}
