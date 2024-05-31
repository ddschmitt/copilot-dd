def is_prime(n):
    """
    Check if a number is prime.

    Args:
        n (int): The number to check.

    Returns:
        bool: True if the number is prime, False otherwise.
    """

    if n in (2, 3):
        return True
    if n % 2 == 0 or n % 3 == 0 or n <= 1:
        return False
    for f in range(5, int(n ** 0.5) + 1, 6):
        if n % f == 0 or n % (f + 2) == 0:
            return False
    return True
