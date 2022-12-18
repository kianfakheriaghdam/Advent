package main

import (
	"fmt"
	"strconv"
	"strings"
)

// // PART 1

// reads the device & into a readable map of size & path
func readDevice() map[string]int {
	// keep track of every folder & file in root
	root := make(map[string]int)

	// keep track of current path
	path := []string{}

	// loop through each line
	for _, i := range strings.Split(data, "\n") {

		// check if it's a cd
		if strings.Contains(i, "$ cd") {

			// check if it's a cd to the parent directory
			if i[5:] == ".." {
				// revert path
				path = path[:len(path)-1]
			} else { // other-wise change path
				path = append(path, i[5:])
			}

		} else if i != "$ ls" || !strings.Contains(i, "dir") {
			// in-case it's not an ls or a directory, it must be a file
			// get the file size, by white-space
			size, _ := strconv.Atoi(strings.Split(i, " ")[0])

			// add the size to the size of every folder in path
			for i := 1; i <= len(path); i++ {
				root[strings.Join(path[:i], "")] = root[strings.Join(path[:i], "")] + size
			}
		}
	}

	return root
}

// get's the sum of every folder with a size of less than 100000
func sumSize(root map[string]int) int {
	// accumulator for storing sum
	acc := 0

	// loop through all of it's size
	for _, i := range root {
		// in-case they are less than 100000
		if i < 100000 {
			// add them to the accumulator
			acc += i
		}
	}

	return acc
}

// get's the minimum folder to free up for update
func minSize(root map[string]int) int {
	// calculate the minimum size of a folder to be deleted
	min := 30000000 - (70000000 - root["/"])

	// accumulator for storing current minimum folder
	acc := 30000000

	// loop through all of it's size
	for _, i := range root {
		// in-case they are bigger than min size & the last one
		if i >= min && i < acc {
			// add them to the accumulator
			acc = i
		}
	}

	return acc
}

func main() {
	root := readDevice()

	fmt.Printf("Root Files = %v\n", root)

	fmt.Printf("Sum of folders less than 100000 = %v\n", sumSize(root))
	fmt.Printf("Minimum folder needed for update = %v\n", minSize(root))
}
