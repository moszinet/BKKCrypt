package bkkcrypt;

import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

@Test(groups = "unit")
public class BKKCryptTest
{
    @DataProvider
    public Object[][] dataProvider()
    {
        return new Object[][]{
                {null, null},
                {"", ""},
                {"admin", "admin"},
                {"password123", "password123"},
                {"@#$&", "@#$&"}
        };
    }

    @Test(dataProvider = "dataProvider")
    public void test(String input, String expected)
    {
        Assert.assertEquals(BKKCrypt.encode(input), expected);
    }
}