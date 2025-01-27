package middlewares

import (
	"api/utils"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

func GetClient(c *gin.Context) (int, error) {
	id, err := c.Get("id_client")
	if !err {
		return 0, fmt.Errorf("failed to get client")
	}
	return id.(int), nil
}

func TokenToClient(token *jwt.Token) string {
	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return ""
	}
	userID, ok := claims["sub"].(string)
	if !ok {
		return ""
	}
	return userID
}

func VerifyToken(c *gin.Context) {

	token := c.GetHeader("Authorization")
	if token == "" {
		c.JSON(http.StatusUnauthorized, "No token provided")
		c.Abort()
		return
	}
	tokenParts := strings.Split(token, "Bearer ")
	if len(tokenParts) < 2 {
		c.JSON(http.StatusUnauthorized, "Invalid token format")
		c.Abort()
		return
	}
	tokenPretty := tokenParts[1]
	parsedToken, err := utils.ValidateJWT(tokenPretty)
	if err != nil || parsedToken == nil {
		c.JSON(http.StatusUnauthorized, "Invalid token")
		c.Abort()
		return
	}

	var idClientStr = TokenToClient(parsedToken)
	if idClientStr == "" {
		c.JSON(http.StatusInternalServerError, "Failed to get client")
	}

	idClientInt, err := strconv.Atoi(idClientStr)
	if err != nil {
		c.JSON(http.StatusInternalServerError, "Invalid client ID format")
		c.Abort()
		return
	}
	c.Set("id_client", idClientInt)
	c.Next()
}
