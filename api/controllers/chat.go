package controllers

import (
	"api/middlewares"
	"api/models"
	"api/storage"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetChat(c *gin.Context) ([]models.Chat, int, error) {
	var req models.ChatGetRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, http.StatusBadRequest, err
	}

	var chats []models.Chat
	chats, err := storage.GetChat(req.RequestIndex)
	if err != nil {
		return nil, http.StatusInternalServerError, err
	}
	print(chats)
	return chats, http.StatusOK, nil
}

func SendChat(c *gin.Context) (map[string]string, int) {
	var id, err = middlewares.GetClient(c)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}
	var req models.ChatSendRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return map[string]string{"error": err.Error()}, http.StatusBadRequest
	}

	err = storage.SendChat(req, id)
	if err != nil {
		return map[string]string{"error": err.Error()}, http.StatusInternalServerError
	}
	return map[string]string{"message": "success"}, http.StatusOK
}
