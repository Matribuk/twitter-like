package storage

import (
	"api/config"
	"database/sql"
	"fmt"
	"log"
)

var Database *sql.DB

func ConnectToDatabase() {
	configDB := config.Config.Database
	log.Printf("Connexion à la base de données : %s:%s (DB: %s)", configDB.DBHost, configDB.DBPort, configDB.DBName)

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		configDB.DBHost,
		configDB.DBPort,
		configDB.DBUser,
		configDB.DBPassword,
		configDB.DBName)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Erreur lors de la connexion à la base de données: %v", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("Impossible de se connecter à la base de données: %v", err)
	}
	Database = db
	fmt.Println("Connexion réussie à la base de données !")
}
