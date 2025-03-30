import random
from Crypto.Util import number
import math


def generate_rsa_keys(bits=256):
    p, q = number.getPrime(bits//2), number.getPrime(bits//2)
    while p == q:
        q = number.getPrime(bits//2)

    n = p * q
    phi = (p - 1) * (q - 1)

    e = random.randint(2, phi - 1)
    while math.gcd(e, phi) != 1:
        e = random.randint(2, phi - 1)

    d = number.inverse(e, phi)
    return (e, n), (d, n)


if __name__ == "__main__":
    public_key, private_key = generate_rsa_keys(512)
    print("n (public + private):", public_key[1])
    print("e (public):", public_key[0])
    print("d (private):", private_key[0])
