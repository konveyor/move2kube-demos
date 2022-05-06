# Usage

## Running locally

Start the customer info backend API
```
$ cd customers
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Start the order info backend API
```
$ cd orders
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Start the product info backend API
```
$ cd inventory
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Start the gateway service
```
$ cd gateway
$ SPRING_PROFILES_ACTIVE=local ./mvnw clean spring-boot:run -P local
```

Start the frontend website
```
$ cd frontend
$ npm install && npm run build && node server.js -p 4000 -g localhost:8080
```

Browse to http://localhost:4000
