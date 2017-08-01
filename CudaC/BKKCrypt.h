#ifndef BKK_CRYPT_H
#define BKK_CRYPT_H

/**
 *@brief This function implemets the world famous BKKCrypt algorithm
 *@param in: input string (null terminated C string)
 *@param out: output string (pointer to the output buffer)
 *@returns: false, if error occurs during CUDA runtime API calls or during the
 *execution of the CUDA kernel.
 *@note: It is the caller's responsibilty to allocate enough memory for the output buffer
*/
bool BKKCrypt(const char *in, char *out);


#endif BKK_CRYPT_H