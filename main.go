package main

import (
	"fmt"
	"net/http"
	"github.com/julienschmidt/httprouter"
	"net"
)

var helloMessage string = `
<html>
  <body>
    <h2>Oh Hi.</h2>
    <p>
    I&apos;m the hello world example!
    </p>
  </body>
</html>
`

func HomeHandler(w http.ResponseWriter, r *http.Request, p httprouter.Params) {
	fmt.Fprint(w, helloMessage)
	return
}

func getRandPort() int{
	l,_ := net.Listen("tcp",":0")
	defer l.Close()
	return l.Addr().(*net.TCPAddr).Port
}

func main() {
	randPort := getRandPort()
	router := httprouter.New()
	router.GET("/", HomeHandler)
	fmt.Printf("http://localhost:%d", randPort)
	http.ListenAndServe(fmt.Sprintf(":%d",randPort), router)

}


