# ────────────── Stage 1: Build ──────────────
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# نسخ ملفات المشروع
COPY pom.xml .
COPY src ./src

# بناء الـ jar
RUN mvn clean package -DskipTests

# ────────────── Stage 2: Run ──────────────
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# نسخ الـ jar الناتج من الـ build
COPY --from=builder /app/target/*.jar app.jar

# ضبط Profile و تعطيل H2 scripts
ENV SPRING_PROFILES_ACTIVE=mysql
ENV SPRING_SQL_INIT_MODE=never

# تشغيل التطبيق
ENTRYPOINT ["java", "-jar", "app.jar"]

