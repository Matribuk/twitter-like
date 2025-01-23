package storage

import (
	"api/utils"
	"errors"
)

func RegisterUser(username string, email string, hashedPassword string) (int, error) {
	var id int
	requestBegin, err := Database.Begin()
	if err != nil {
		return -1, err
	}

	request, err := requestBegin.Prepare("INSERT INTO users (email, nickname, password) VALUES (?, ?, ?) RETURNING id")
	if err != nil {
		return -1, err
	}
	defer request.Close()

	err = request.QueryRow(email, username, hashedPassword).Scan(&id)
	if err != nil {
		return -1, err
	}

	err = requestBegin.Commit()
	if err != nil {
		return -1, err
	}
	return id, nil
}

func LoginUser(email string, password string) (int, error) {
	var id int
	var hashedPassword string
	err := Database.QueryRow("SELECT id, password FROM users WHERE email = ?", email).Scan(&id, &hashedPassword)
	if err != nil {
		return -1, err
	}
	if !utils.CheckHashPassword(password, hashedPassword) {
		return -1, errors.New("mot de passe incorrect")
	}
	return id, nil
}
