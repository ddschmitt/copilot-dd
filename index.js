
/**
 * Checks if a number is prime.
 * @param {number} num - The number to check.
 * @returns {boolean} - Returns true if the number is prime, false otherwise.
 */
function isPrime(num) {
    for(let i = 2, sqrt = Math.sqrt(num); i <= sqrt; i++)
        if(num % i === 0) return false; 
    return num > 1;
}