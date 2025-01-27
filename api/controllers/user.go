package controllers

import (
	"api/models"
	"api/storage"
	"api/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

func RegisterUser(c *gin.Context) (map[string]string, int) {
	var user models.UserRegister
	if err := c.ShouldBindJSON(&user); err != nil {
		return map[string]string{"error": err.Error()}, http.StatusBadRequest
	}

	hashedPassword, _ := utils.GenerateHash(user.Password)
	user.Password = hashedPassword

	userID, err := storage.RegisterUser(user.Username, user.Email, user.Password, user.UrlImage)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}

	token, err := utils.GenerateJWT(userID)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}
	return map[string]string{"token": token}, http.StatusOK
}

func LoginUser(c *gin.Context) (map[string]string, int) {
	var user models.UserLogin
	if err := c.ShouldBindJSON(&user); err != nil {
		return map[string]string{"error": err.Error()}, http.StatusBadRequest
	}

	userID, err := storage.LoginUser(user.Email, user.Password)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}

	token, err := utils.GenerateJWT(userID)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}
	return map[string]string{"token": token}, http.StatusOK
}
