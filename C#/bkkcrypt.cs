using System;

namespace BKK
{
    #region Strategy
    /// <summary>
    /// Crypt Strategy base
    /// </summary>
    public abstract class CryptStrategyBase
    {
        public abstract string Crypt(string passToEncrypt);
    }

    /// <summary>
    /// Strategy Context
    /// </summary>
    public class StrategyContext
    {
        private readonly CryptStrategyBase _strategy;

        //for lazy lads
        public StrategyContext()
        {
            this._strategy = new BKKCryptStrategy();
        }
        public StrategyContext(CryptStrategyBase strategy)
        {
            this._strategy = strategy;
        }

        public string Crypt(string passToEncrypt)
        {
            return _strategy.Crypt(passToEncrypt);
        }
    }

    /// <summary>
    /// BKK crypt strategy
    /// </summary>
    public class BKKCryptStrategy : CryptStrategyBase
    {
        public override string Crypt(string passToEncrypt)
        {
            return passToEncrypt.Encrypt();
        }
    }
    #endregion

    #region Factory
    /// <summary>
    /// Factory base for further usage
    /// </summary>
    public abstract class FactoryBase
    {
        //todo: dont forget this one
    }

    /// <summary>
    /// Context factory base
    /// </summary>
    public abstract class ContextFactoryBase : FactoryBase
    {
        public abstract StrategyContext CreateContext();
        public abstract StrategyContext CreateContext(CryptStrategyBase cryptStrategyBase);
    }

    /// <summary>
    /// Context factory
    /// </summary>
    public class ContextFactory : ContextFactoryBase
    {
        public override StrategyContext CreateContext()
        {
            return new StrategyContext();
        }

        public override StrategyContext CreateContext(CryptStrategyBase cryptStrategyBase)
        {
            return new StrategyContext(cryptStrategyBase);
        }
    }

    /// <summary>
    /// Strategy factory base
    /// </summary>
    public abstract class StrategyFactoryBase : FactoryBase
    {
        public abstract CryptStrategyBase CreateStrategy();
    }

    /// <summary>
    /// BKK strategy factory
    /// </summary>
    public class BKKStrategyFactory : StrategyFactoryBase
    {
        public override CryptStrategyBase CreateStrategy()
        {
            return new BKKCryptStrategy();
        }
    }

    /// <summary>
    /// Crypto factory base
    /// </summary>
    public abstract class CryptFactoryBase : FactoryBase
    {
        public abstract ICrypt CreateCrypt();
    }

    /// <summary>
    /// BKK crypt factory
    /// </summary>
    public class BkkCryptFactory : CryptFactoryBase
    {
        public override ICrypt CreateCrypt()
        {
            return new BKKCrypt();
        }
    }
    #endregion

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

    public static class SecureBKKCrypt
    {
        /// <summary>
        /// Encrypt extension method
        /// </summary>
        /// <param name="passToEncrypt"></param>
        /// <returns></returns>
        public static string Encrypt(this string passToEncrypt)
        {
            return passToEncrypt;
        }
    }
}
