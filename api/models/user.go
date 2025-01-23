package models

type UserRegister struct {
	Username string
	Email    string
	Password string
}

type UserLogin struct {
	Email    string
	Password string
}
