MOCK_SERVER_PORT=8000
WEB_SERVER_PORT=8888

run:
	make hosting server -j2
	
hosting:
	EVALUATION_REQUEST_API=http://localhost:$(MOCK_SERVER_PORT) flutter run lib/main.dart -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0

server:
	MOCK_SERVER_PORT=$(MOCK_SERVER_PORT) dart test/repository/mock_server.dart

prod_build:
	flutter build web