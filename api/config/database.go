package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

type ConfigDatabase struct {
	DBHost     string
	DBPort     string
	DBUser     string
	DBPassword string
	DBName     string
}

func ConfigLoad() ConfigDatabase {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Erreur lors du chargement des variables d'environnement: %v", err)
	}

	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbPassword := os.Getenv("DB_PASSWORD")
	dbName := os.Getenv("DB_NAME")

	if dbHost == "" || dbPort == "" || dbUser == "" || dbPassword == "" || dbName == "" {
		log.Fatalf("Certaines variables d'environnement nécessaires sont manquantes")
	}

	return ConfigDatabase{
		DBHost:     dbHost,
		DBPort:     dbPort,
		DBUser:     dbUser,
		DBPassword: dbPassword,
		DBName:     dbName,
	}
}
