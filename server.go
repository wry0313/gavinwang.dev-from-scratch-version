package main

import (
	"fmt"
	"log"
	"net/http"
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
	log.Printf("Received request from %s\n", r.RemoteAddr)  // Logs the IP address of the client making the request.
	fmt.Fprintf(w, "<h1>Hello World</h1> <p> Let's fucking go<span> yessirr</span></p> <li>https</li>")
}

func main() {
	http.HandleFunc("/", helloWorldHandler)
	log.Println("Starting server on :8080")  // Logs a message when the server starts.
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatalf("Error starting server: %s", err.Error())  // Logs any error that might occur when starting the server.
	}
}
