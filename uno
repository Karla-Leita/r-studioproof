# makeCacheMatrix function
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

# cacheSolve function
cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinverse(inv)
    inv
}

# Example of usage
m <- matrix(c(1, 2, 3, 4), 2, 2)
cachedMatrix <- makeCacheMatrix(m)

# First time calculation
inv1 <- cacheSolve(cachedMatrix)
print(inv1)

# Cached result
inv2 <- cacheSolve(cachedMatrix)
print(inv2)
