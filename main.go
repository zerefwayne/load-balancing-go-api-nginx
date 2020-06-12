package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
	log.Println(r.Method, r.RequestURI)
	fmt.Fprintln(w, "Hello world!")
}

func main() {

	router := mux.NewRouter()

	router.HandleFunc("/", helloWorldHandler)

	corsRouter := cors.AllowAll().Handler(router)

	log.Println("Starting up server on :5000")
	log.Fatalln(http.ListenAndServe(":5000", corsRouter))

}
