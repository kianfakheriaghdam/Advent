package main

import (
	"strings"
)

// turns the forest grid into a matrix of bytes
func getForest() [][]int {
	// split the forest to rows, by new-line
	rows := strings.Split(data, "\n")

	// store our matrix
	acc := [][]int{}

	// loop threw each row
	for _, i := range rows {
		// convert the columns into int
		columns := []int{}

		// iterate threw the characters of the columns
		for _, j := range i {
			columns = append(columns, int(j-'0'))
		}

		// add the converted column to our matrix
		acc = append(acc, columns)
	}

	return acc
}

// reverses an array
func reverse(array []int) []int {
	// check if the array is empty
	if len(array) == 0 {
		return []int{}
	}

	// add the first element to a new array, which will reverse it
	return append(reverse(array[1:]), array[0])
}

// check if it connects to an edge
func connected(i []int, j int) bool {
	// loop threw it's side
	for _, v := range i {
		// in-case a tree is bigger than it
		if v >= j {
			// then it must not connect to the edge
			return false
		}
	}

	// by default, it is connected to the edge
	return true
}

// gets the trees at the top of a tree
func up(forest [][]int, x int, y int) []int {
	// accumulator for storing tree on top
	acc := []int{}

	// loop through the forest grid
	for i, v := range forest {
		for j, w := range v {
			// check if that element is on top of it
			if y == j && i < x {
				// append it to the accumulator
				acc = append(acc, w)
			}
		}
	}

	return reverse(acc)
}

// gets the trees at the bottom of a tree
func bottom(forest [][]int, x int, y int) []int {
	// accumulator for storing tree on bottom
	acc := []int{}

	// loop through the forest grid
	for i, v := range forest {
		for j, w := range v {
			// check if that element is on bottom of it
			if y == j && i > x {
				// append it to the accumulator
				acc = append(acc, w)
			}
		}
	}

	return acc
}

// checks if a tree in-side the forest is visible
func visible(forest [][]int, x int, y int, i []int, j int) bool {
	// check if all trees near are shorter down it
	result := (j > forest[x+1][y]) && (j > forest[x-1][y]) && (j > forest[x][y+1]) && (j > forest[x][y-1])

	// check if it connects to an edge horizontally
	result = result || connected(i[y+1:], j) || connected(reverse(i[:y]), j)
	// check if it connects to an edge vertically
	result = result || connected(up(forest, x, y), j) || connected(bottom(forest, x, y), j)

	return result
}

// get the count of every visible tree in the forest
func visibleCount(forest [][]int) int {
	// an accumulator to store the counts
	acc := 0

	// loop threw the matrix
	for x, i := range forest {
		for y, j := range i {
			// check if the tree is at the edge
			if x == 0 || x == len(forest)-1 || y == 0 || y == len(forest)-1 {
				acc++
			} else if visible(forest, x, y, i, j) {
				acc++
			}
		}
	}

	return acc
}

func main() {
	println(visibleCount(getForest()))
}
