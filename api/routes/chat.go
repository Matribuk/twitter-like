package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func GetChat(c *gin.Context) {
	resp, statusCode, err := controllers.GetChat(c)
	if err != nil {
		c.JSON(statusCode, gin.H{"error": err.Error()})
	} else {
		c.JSON(statusCode, resp)
	}
}

func SendChat(c *gin.Context) {
	resp, statusCode := controllers.SendChat(c)
	c.JSON(statusCode, resp)
}
