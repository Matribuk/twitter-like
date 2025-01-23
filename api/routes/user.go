package routes

import (
	"api/controllers"
	"net/http"

	"github.com/gin-gonic/gin"
)

func RegisterUser(c *gin.Context) {
	resp, statusCode := controllers.RegisterUser(c)
	if statusCode == http.StatusOK {
		c.JSON(statusCode, resp)
	} else {
		c.JSON(statusCode, resp)
	}
}

func LoginUser(c *gin.Context) {

}
