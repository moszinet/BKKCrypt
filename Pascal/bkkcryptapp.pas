program BKKCryptApp;
uses crt, BKKCrypt;

var
	password : String;
    encryptedpassword : String;

begin
    writeln('BKK Password Encrypter!');
    writeln('Please enter the password:');
    readln(password);
    encryptedpassword := BKKCrypt.encrypt(password);
    writeln('Encryption of ',password,' is: ',encryptedpassword);
end.
