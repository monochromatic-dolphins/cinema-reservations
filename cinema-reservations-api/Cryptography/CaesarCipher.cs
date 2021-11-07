namespace cinema_reservations_api.Cryptography {
    public static class CaesarCipher {
        private const string Alphabet = "abcdefghijklmnopqrstuvwxyz" +
                                         "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        private static readonly int AlphabetLength = Alphabet.Length;

        public static string Encode(string text) {
            var encodedText = "";
            foreach (var letter in text) {
                var letterIndex = Alphabet.IndexOf(letter);
                var newIndex = letterIndex + 1;
                if (newIndex == AlphabetLength) {
                    newIndex = 0;
                }
                encodedText += Alphabet[newIndex];
            }
            return encodedText;
        }
        
    }
}