package routes

import (
	"github.com/gin-gonic/gin"
)

func UserRoutes(router *gin.Engine) {
	userRoutes := router.Group("/users")
	{
		userRoutes.POST("/register", RegisterUser)
		userRoutes.POST("/login", LoginUser)
	}
}

func InitRoutes(router *gin.Engine) {
	UserRoutes(router)
}
