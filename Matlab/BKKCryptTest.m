classdef BKKCryptTest < matlab.unittest.TestCase

    methods (Test)
        function testNumericPassword(testCase)
            testCase.verifyEqual(BKKCrypt(123), 123);
        end
        
        function testStringPassword(testCase)
            testCase.verifyEqual(BKKCrypt('123'), '123');
        end
        
        function testEmptyStringPassword(testCase)
            testCase.verifyEqual(BKKCrypt(''), '');
        end
        
        function testEmptyPassword(testCase)
            testCase.verifyEqual(BKKCrypt([]), []);
        end
        
        function test500WorstPasswords(testCase)
            fileID = fopen('500-worst-passwords.txt');
            passwords = textscan(fileID, '%s', 'delimiter', '\n');
            passwords = passwords{1};
            fclose(fileID);
            for k = 1:length(passwords)
                password = passwords{k};
                testCase.verifyEqual(BKKCrypt(password), password);
            end
        end
        
        function testVectorizedUseCase(testCase)
            fileID = fopen('500-worst-passwords.txt');
            passwords = textscan(fileID, '%s', 'delimiter', '\n');
            passwords = passwords{1};
            fclose(fileID);
            testCase.verifyEqual(BKKCrypt(passwords), passwords);
        end
    end

end

