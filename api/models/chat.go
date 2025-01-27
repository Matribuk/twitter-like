package models

type Chat struct {
	UserID   int    `json:"user_id"`
	Message  string `json:"message"`
	CreateAt string `json:"create_at"`
	UrlImage string `json:"url_image"`
	UserName string `json:"user_name"`
}

type ChatGetRequest struct {
	RequestIndex int `json:"request_index"`
}

type ChatSendRequest struct {
	UserID  int    `json:"user_id"`
	Message string `json:"message"`
}
