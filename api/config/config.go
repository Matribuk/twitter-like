package config

var Config ConfigData

type ConfigData struct {
	Database ConfigDatabase
	Api      ConfigApi
}

func ConfigLoad() {
	Config = ConfigData{
		Database: ConfigDatabaseLoad(),
		Api:      ConfigApiLoad(),
	}
}
