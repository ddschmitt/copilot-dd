	// Create and seed the generator.
	// Typically a non-fixed seed should be used, such as time.Now().UnixNano().
	// Using a fixed seed will produce the same output on every run.
	// r := rand.New(rand.NewSource(99))

package main

import (
	"math/rand"
	"time"
)

func seedRand() *rand.Rand {
	s := rand.NewSource(time.Now().UnixNano())
	r := rand.New(s)
	return r
}

func main() {
	r := seedRand()
	// Now you can use r to generate random numbers.
	// For example, to generate a random integer:
	n := r.Int()
	println(n)
}