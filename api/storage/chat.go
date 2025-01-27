package storage

import "api/models"

func GetChat(actualIndex int) ([]models.Chat, error) {
	var chats []models.Chat

	rows, err := Database.Query("SELECT chats.message, chats.user_id, chats.created_at, users.url_image, users.nickname FROM chats INNER JOIN users ON chats.user_id = users.id ORDER BY chats.id LIMIT 10 OFFSET $1", actualIndex)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var message string
		var userID int
		var createdAt string
		var urlImage string
		var userName string

		err := rows.Scan(&message, &userID, &createdAt, &urlImage, &userName)
		if err != nil {
			return nil, err
		}
		chats = append(chats, models.Chat{
			Message:  message,
			UserID:   userID,
			CreateAt: createdAt,
			UrlImage: urlImage,
			UserName: userName,
		})
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return chats, nil
}

func SendChat(chat models.ChatSendRequest, id_client int) error {
	requestBegin, err := Database.Begin()
	if err != nil {
		return err
	}

	request, err := requestBegin.Prepare("INSERT INTO chats (user_id, message) VALUES ($1, $2)")
	if err != nil {
		return err
	}
	defer request.Close()

	_, err = request.Exec(id_client, chat.Message)
	if err != nil {
		requestBegin.Rollback()
		return err
	}

	err = requestBegin.Commit()
	if err != nil {
		return err
	}
	return nil
}
