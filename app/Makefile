run:
	flutter run lib/main.dart -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0 \
	--dart-define=TETRIS_API=${TETRIS_API} \
	--dart-define=TETRIS_FRONTEND_DOMAIN=${TETRIS_FRONTEND_DOMAIN} \
	--web-renderer html

.PHONY: build

build:
	flutter build web \
	--dart-define=TETRIS_API=${TETRIS_API} \
	--dart-define=TETRIS_FRONTEND_DOMAIN=${TETRIS_FRONTEND_DOMAIN} \
	--web-renderer html

deploy:
	aws s3 sync build/web s3://${S3_HOSTING_BUCKET} --delete