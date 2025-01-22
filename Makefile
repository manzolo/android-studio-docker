IMAGE_NAME :=manzolo/android-studio
REGISTRY:=docker-hub.lan:5000/

# Target per avviare i container
start:
	@echo "Consentire connessioni X11 locali"
	@xhost +SI:localuser:$(shell id -un)
	@echo "Riavvio i container Docker Compose"
	docker compose run --remove-orphans android-studio

# Target per fermare i container
stop:
	@echo "Fermo e rimuovo i container Docker Compose"
	docker compose down
	docker compose rm -f

# Target per la build dell'immagine
build:
	@echo "Build dell'immagine"
	docker build --build-arg CONTAINER_USERNAME=utente -t ${IMAGE_NAME} .
	@echo "Immagine costruita: ${IMAGE_NAME}"

registry_tag:
	docker tag ${IMAGE_NAME} ${REGISTRY}${IMAGE_NAME}

registry_push:
	docker push ${REGISTRY}${IMAGE_NAME}

# Target per la build dell'immagine
logs:
	@echo "Container logs"
	docker compose logs -f

# Target per la build dell'immagine
enter:
	@echo "Consentire connessioni X11 locali"
	@xhost +SI:localuser:$(shell id -un)
	@echo "Enter Container"
	docker compose run --remove-orphans android-studio /bin/bash
