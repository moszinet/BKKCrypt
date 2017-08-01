create or replace function BKKCrypt(password in varchar2) return varchar2 is
	--
	-- Oracle PL/SQL implementation of the BKK cryptographic method 
	--
begin
	return password;
end;
/
