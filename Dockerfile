# Étape unique : image de base avec JDK 17 (basée sur Alpine pour légèreté)
FROM amazoncorretto:17-alpine

# Créer un utilisateur non-root pour plus de sécurité (optionnel mais recommandé)
# RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# USER appuser

# Définir le répertoire de travail
WORKDIR /app

# Copier le JAR généré par Maven (depuis le build Jenkins)
# Le nom doit correspondre exactement à celui généré par spring-boot-maven-plugin
COPY target/myapp-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port par défaut de Spring Boot
EXPOSE 8080

# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]