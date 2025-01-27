package models

type UserRegister struct {
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
	UrlImage string `json:"url_image"`
}

type UserLogin struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}
