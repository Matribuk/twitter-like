package main

import (
	"api/config"
	"api/routes"
	"api/storage"
	"log"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

func main() {
	config.ConfigLoad()

	storage.ConnectToDatabase()
	router := gin.Default()
	corsConfig := cors.DefaultConfig()
	corsConfig.AllowAllOrigins = true
	corsConfig.AllowMethods = []string{"POST", "GET", "PUT", "DELETE"}
	corsConfig.AllowHeaders = []string{"Origin", "Content-Type", "Authorization", "Accept", "User-Agent"}
	corsConfig.AllowCredentials = true
	corsConfig.MaxAge = 12 * time.Hour
	router.Use(cors.New(corsConfig))
	routes.InitRoutes(router)

	port := config.Config.Api.Port
	log.Printf("Starting server on port %s...", port)
	router.Run(":" + port)
}
