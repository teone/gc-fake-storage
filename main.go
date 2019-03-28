package main

import (
	"fmt"

	"github.com/fsouza/fake-gcs-server/fakestorage"
)

func main() {
	server, err := fakestorage.NewServerWithOptions(fakestorage.Options{
		InitialObjects: []fakestorage.Object{
			{
				BucketName: "bucket",
				Name:       "bucket-precreate-object",
				Content:    []byte("This object just forces the bucket to exist when the server starts up."),
			},
			{
				BucketName: "another-bucket",
				Name:       "some-other-object",
				Content:    []byte("This object just forces the bucket to exist when the server starts up."),
			},
		},
		Host:        "0.0.0.0",
		Port:        4443,
		StorageRoot: "/storage",
	})
	if err != nil {
		panic(err)
	}
	fmt.Printf("Server started at %s\n", server.URL())
	select {}
}
