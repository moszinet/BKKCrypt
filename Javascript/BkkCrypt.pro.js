// This is the pro version of the world famous BKK cryptographic algorithm
export const BkkCryptPRO = input => [...[...[...input].reverse()].reverse()].join('');
