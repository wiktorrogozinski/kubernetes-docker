package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	// for heroku since we have to use the assigned port for the app
	port := os.Getenv("PORT")
	if port == "" {
		// if we are running on minikube or just running the bin
		defaultPort := "3000"
		log.Println("no env var set for port, defaulting to " + defaultPort)
		// serve the contents of the static folder on /
		http.Handle("/", http.FileServer(http.Dir("./static")))
		http.ListenAndServe(":"+defaultPort, nil)
	} else {
		http.Handle("/", http.FileServer(http.Dir("./static")))
		log.Println("starting server on port " + port)
		http.ListenAndServe(":"+port, nil)
	}
}
