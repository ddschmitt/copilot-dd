import unittest
from prime import is_prime

class TestIsPrime(unittest.TestCase):
    def test_negative_number(self):
        self.assertFalse(is_prime(-1))
        self.assertFalse(is_prime(-10))

    def test_zero_and_one(self):
        self.assertFalse(is_prime(0))
        self.assertFalse(is_prime(1))

    def test_two_and_three(self):
        self.assertTrue(is_prime(2))
        self.assertTrue(is_prime(3))

    def test_other_primes(self):
        self.assertTrue(is_prime(5))
        self.assertTrue(is_prime(7))
        self.assertTrue(is_prime(11))
        self.assertTrue(is_prime(13))

    def test_non_primes(self):
        self.assertFalse(is_prime(4))
        self.assertFalse(is_prime(6))
        self.assertFalse(is_prime(8))
        self.assertFalse(is_prime(9))

if __name__ == '__main__':
    unittest.main()