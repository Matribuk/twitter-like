package main

import (
	"api/config"
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	config := config.ConfigLoad()

	log.Printf("Connexion à la base de données : %s:%s (DB: %s)", config.DBHost, config.DBPort, config.DBName)

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		config.DBHost,
		config.DBPort,
		config.DBUser,
		config.DBPassword,
		config.DBName)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Erreur lors de la connexion à la base de données: %v", err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatalf("Impossible de se connecter à la base de données: %v", err)
	}
	fmt.Println("Connexion réussie à la base de données !")
}
