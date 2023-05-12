package main

import (
	"fmt"
	"net/http"
)

func (app *application) healthcheckHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println(w, "status: available")
	fmt.Fprintf(w, "envirenment: %s\n", app.config.env)
	fmt.Fprintf(w, "version: %s\n", version)
}
