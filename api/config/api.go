package config

import (
	"api/utils"
	"log"
	"os"

	"github.com/joho/godotenv"
)

type ConfigApi struct {
	GinMode  string
	Port     string
	TokenKey string
}

func ConfigApiLoad() ConfigApi {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Erreur lors du chargement des variables d'environnement: %v", err)
	}

	ginMode := os.Getenv("API_GIN_MODE")
	port := os.Getenv("API_PORT")
	token := os.Getenv("API_KEY")

	if ginMode == "" || port == "" || token == "" {
		log.Fatalf("Certaines variables d'environnement nécessaires sont manquantes")
	}

	utils.SetJWTKey(token)

	return ConfigApi{
		GinMode:  ginMode,
		Port:     port,
		TokenKey: token,
	}
}
