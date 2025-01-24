package routes

import (
	"api/controllers"

	"github.com/gin-gonic/gin"
)

func RegisterUser(c *gin.Context) {
	resp, statusCode := controllers.RegisterUser(c)
	c.JSON(statusCode, resp)
}

func LoginUser(c *gin.Context) {
	resp, statusCode := controllers.LoginUser(c)
	c.JSON(statusCode, resp)
}
