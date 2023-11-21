.PHONY: help get clean fix fix-a watch watch-c test slang pod pod-f firebase fe icon splash link unlink video
.DEFAULT_GOAL := help

get: # パッケージを取得する
	flutter pub get

clean: # flutter clean をしてからパッケージを取得する
	flutter clean && flutter pub get

fix: # 静的解析の警告を自動で修正する（dry-run）
	dart fix --dry-run

fix-a: # 静的解析の警告を自動で修正する
	dart fix --apply

watch: # ファイルの変更を監視して、変更があったら自動でコンパイルする
	dart run build_runner watch --delete-conflicting-outputs

watch-c: # キャッシュを削除してから `make watch` する
	dart run build_runner clean && \
	dart run build_runner watch --delete-conflicting-outputs

test: # テストを実行する
	flutter test --coverage

slang: # i18n を生成する（`watch` でも生成される）
	dart run slang

pod: # iOS の Podfileを更新する
	cd ios && pod install --repo-update && cd ..

pod-f: # iOS の Pod のキャッシュを削除してから Podfile を更新する
	cd ios && \
	rm -rf Pods/ && \
	rm -rf Podfile.lock && \
	cd .. && \
	flutter clean && \
	flutter pub get && \
	cd ios && \
	pod install --repo-update && \
	cd ..

# 参考: https://stackoverflow.com/questions/71708885/cannot-use-import-statement-outside-a-module-typescript-nodejs-firebase-functio
fe: # Firebase のエミュレーターを起動する
	flutter build web --web-renderer=html --dart-define-from-file=dart_defines/dev.json && \
	cd functions && \
	npm run build && \
	firebase emulators:start && \
	cd ../

icon: # アプリアイコンを生成する
	dart run flutter_launcher_icons

splash: # スプラッシュ画面を生成する
	dart run flutter_native_splash:create

link: # シンボリックリンクを作成する
	ln -s $(LINK_FROM) $(LINK_TO)

unlink: # シンボリックリンクを削除する
	unlink $(NAME)

video: # mp4 を HLS に変換する。homebrew などで ffmpeg をインストールしておく必要がある。
	ffmpeg -i video.mp4 -c:v copy -c:a copy -f hls -hls_time 4 -hls_playlist_type vod -hls_segment_filename "video%3d.ts" video.m3u8

help: # ヘルプを表示する
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
