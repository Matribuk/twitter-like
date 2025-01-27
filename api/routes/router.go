package routes

import (
	"api/middlewares"

	"github.com/gin-gonic/gin"
)

func HomeRoutes(router *gin.Engine) {
	homeRoutes := router.Group("/chat", middlewares.VerifyToken)
	{
		homeRoutes.POST("/get", GetChat)
		homeRoutes.POST("/send", SendChat)
	}
}

func UserRoutes(router *gin.Engine) {
	userRoutes := router.Group("/users")
	{
		userRoutes.POST("/register", RegisterUser)
		userRoutes.POST("/login", LoginUser)
	}
}

func InitRoutes(router *gin.Engine) {
	UserRoutes(router)
	HomeRoutes(router)
}
