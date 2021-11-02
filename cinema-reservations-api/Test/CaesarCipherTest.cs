using cinema_reservations_api.Cryptography;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace cinema_reservations_api.Test {
    
    [TestClass]
    public class CaesarCipherTest {
        
        [TestMethod]
        public void TestEncode() {
            var text = "admin";
            var encodedText = "benjo";
            Assert.AreEqual(CaesarCipher.Encode(text), encodedText);
        }
    }
}