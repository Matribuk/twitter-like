package utils

import (
	"strconv"
	"time"

	"github.com/dgrijalva/jwt-go"
)

var jwtKey []byte

func SetJWTKey(key string) {
	jwtKey = []byte(key)
}

func GenerateJWT(userID int) (string, error) {
	claims := &jwt.StandardClaims{
		ExpiresAt: time.Now().Add(24 * time.Hour).Unix(),
		Subject:   strconv.Itoa(userID),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(jwtKey)
}

func ValidateJWT(tokenString string) (*jwt.Token, error) {
	return jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})
}
