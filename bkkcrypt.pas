{  online compiler (use interactive mode): jdoodle.com/a/4yf }

program BKKEncrypt;
uses crt;

procedure encrypt(password : String; Var encryptedpassword : String);
begin
    encryptedpassword := password;
end;

var
password : String;
encryptedpassword : String;
    
begin
    writeln('BKK Password Encrypter!');
    writeln('Please enter the password:');
    readln(password);
    encrypt(password, encryptedpassword);
    writeln('Encryption of ',password,' is:',encryptedpassword);
end.
