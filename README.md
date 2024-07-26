# Introducción

En esta segunda tarea de programación, se me pedirá que escriba una función en R que sea capaz de almacenar en caché cálculos que pueden consumir mucho tiempo. Por ejemplo, calcular la media de un vector numérico suele ser una operación rápida. Sin embargo, para un vector muy largo, puede llevar mucho tiempo calcular la media, especialmente si se tiene que calcular repetidamente (por ejemplo, en un bucle). Si el contenido de un vector no está cambiando, puede tener sentido almacenar en caché el valor de la media para que cuando lo necesitemos de nuevo, se pueda buscar en la caché en lugar de recalcularlo. En esta tarea de programación aprovecharé las reglas de alcance del lenguaje R y cómo pueden manipularse para preservar el estado dentro de un objeto R.

## Ejemplo: Almacenando en Caché la Media de un Vector

En este ejemplo, introduzco el operador `<<-` que puede usarse para asignar un valor a un objeto en un entorno que es diferente del entorno actual. A continuación, presento dos funciones que se utilizan para crear un objeto especial que almacena un vector numérico y almacena en caché su media.

La primera función, `makeVector`, crea un "vector" especial, que en realidad es una lista que contiene una función para:

1. Establecer el valor del vector
2. Obtener el valor del vector
3. Establecer el valor de la media
4. Obtener el valor de la media

```r
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}
La siguiente función calcula la media del "vector" especial creado con la función anterior. Sin embargo, primero verifica si la media ya ha sido calculada. Si es así, obtiene la media de la caché y omite el cálculo. De lo contrario, calcula la media de los datos y establece el valor de la media en la caché a través de la función setmean.

cachemean <- function(x, ...) {
    m <- x$getmean()
    if (!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
Tarea: Almacenando en Caché la Inversa de una Matriz
La inversión de matrices suele ser un cálculo costoso y puede haber algún beneficio en almacenar en caché la inversa de una matriz en lugar de calcularla repetidamente. Mi tarea es escribir un par de funciones que almacenen en caché la inversa de una matriz.

Escribí las siguientes funciones:
makeCacheMatrix: Esta función crea un objeto "matriz" especial que puede almacenar en caché su inversa.
cacheSolve: Esta función calcula la inversa de la "matriz" especial devuelta por makeCacheMatrix. Si la inversa ya se ha calculado (y la matriz no ha cambiado), entonces cacheSolve debe recuperar la inversa de la caché.
El cálculo de la inversa de una matriz cuadrada se puede hacer con la función solve en R. Por ejemplo, si X es una matriz cuadrada invertible, entonces solve(X) devuelve su inversa.

Para esta tarea, asumiré que la matriz suministrada siempre es invertible.

Pasos para Completar la Tarea:
Hacer fork del repositorio de GitHub que contiene los archivos R stub en este enlace para crear una copia bajo mi propia cuenta.
Clonar mi repositorio de GitHub bifurcado en mi computadora para que pueda editar los archivos localmente en mi propia máquina.
Editar el archivo R contenido en el repositorio git y colocar mi solución en ese archivo (por favor, no renombre el archivo).
Confirmar mi archivo R completado en MI repositorio git y empujar mi rama git al repositorio de GitHub bajo mi cuenta.
Enviar a Coursera la URL de mi repositorio de GitHub que contiene el código R completado para la tarea.
Código para la Tarea
Aquí está el código para las funciones makeCacheMatrix y cacheSolve:

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
    if (!is.null(inv)) {
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
