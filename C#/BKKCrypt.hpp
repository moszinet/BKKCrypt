#pragma once
#include <string>

typedef std::string pswd_t;
class ICrypt {
	 virtual pswd_t encrypt(pswd_t) = 0;
};

class BKKCryptImpl : public ICrypt {
public:
	pswd_t encrypt(pswd_t pswd) override { return pswd; }
};
