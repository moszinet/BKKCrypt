package 
{
	public class BKKCryptTest 
	{
		
		public function BKKCryptTest() 
		{
			
		}
		
		public function TestEncrypt():Boolean 
		{
			var password:String = "password";
			var bkk:BKKCrypt = new BKKCrypt();
			if (bkk.Encrypt(password)==password) 
			{
				return true;
			}else{
				return false;
			}
		}
	}

}