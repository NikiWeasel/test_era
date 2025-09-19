init:
	make init-flutter-version
	fvm flutter clean
	make clean-ios
	fvm flutter pub get
	make codegen
init-flutter-version:
	fvm install $(FLUTTER_VERSION) && fvm use $(FLUTTER_VERSION)
	fvm flutter doctor
	fvm flutter clean
	fvm flutter pub get
clean-ios:
	fvm flutter clean
	cd ios/ && pod cache clean --all && xcodebuild clean && rm -rf .symlinks/ && rm -rf Pods && rm -rf Podfile.lock


codegen:
	fvm flutter pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs && make format

l10n:
	fvm flutter gen-l10n
reset-goldens:
	(cd test && find . -type d -name goldens -prune -exec rm -rf {} \;)
	fvm flutter test --update-goldens
spider-build:
	fvm dart run spider build && make format
	
	
# Сборка проекта:


build-qa:
	@echo " Android QA build started"
	fvm flutter clean
	fvm flutter pub get
	cd .. && fvm flutter build apk -t lib/main_qa.dart --flavor dev --split-per-abi --release
	
# Дистрибуция через Fastlane:
# Деплой последней сборки в Firebase. Берёт необходимые значения из env файла.

deploy-firebase:
	@echo "1 Started deploying to Firebase"
	source .secrets.env && source .dev.env && bundle exec fastlane firebase