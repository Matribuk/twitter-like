package models

type Chat struct {
	UserID   int    `json:"user_id"`
	Message  string `json:"message"`
	CreateAt string `json:"create_at"`
}

type ChatGetRequest struct {
	RequestIndex int `json:"request_index"`
}

type ChatSendRequest struct {
	UserID  int    `json:"user_id"`
	Message string `json:"message"`
}
