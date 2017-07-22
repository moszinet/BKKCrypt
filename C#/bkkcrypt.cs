using System;

namespace BKK 
{
	public interface ICrypt
	{
		string Encrypt(string input);
	}

	public class BKKCrypt : ICrypt
	{
    	public string Encrypt(string input)
    	{
      		return input;
    	}
  	}
}
