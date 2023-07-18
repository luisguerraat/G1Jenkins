#LABEL grupoG6 luis.guerra.at@usa.edu.co


FROM maven:3.6.1-jdk-8-slim AS build
#Se toma como base la imagen maven:3.6.1-jdk-8-slim y se le da el nombre build


RUN mkdir -p workspace
#Se crea la carpeta workspace en la imagen maven
WORKDIR workspace
#Se selecciona la carpeta workspace como carpeta base de la imagen
COPY pom.xml /workspace
#Se copia el archivo pom.xml desde el directorio de trabajo a la carpeta workspace
#de la imagen (si esta en otra ruta, se debe indicar la ruta completa)
COPY src /workspace/src
#Se la carpeta scr del proyecto spring a la carpeta workspace a la imagen
COPY frontend /workspace/frontend
#Se la carpeta frontend del proyecto a la carpeta workspace a la imagen
RUN mvn -f pom.xml clean install -DskipTests=true
#Se ejecuta la orden mvn para que valide las dependencias indicadas
FROM openjdk:8-alpine
#Se crea otra imagen a partir de la imagen base openjdk:8-alpine
COPY --from=build /workspace/target/*.jar app.jar
#Copia los archivo jar de la imagen anterior
EXPOSE 8080
#Expone el puerto 8080 de esta imagen
ENTRYPOINT ["java","-jar","app.jar"]
#Se ejecuta el comando “java –jar app.jar”