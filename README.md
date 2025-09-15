# Laravel Authentication API

A simple Laravel backend API with authentication using Laravel Sanctum and PostgreSQL.

## Features

- User registration
- User login/logout
- Protected routes with token authentication
- PostgreSQL database support
- CORS enabled for frontend integration

## Setup

1. **Install dependencies:**
   ```bash
   composer install
   ```

2. **Configure environment:**
   - Update `.env` file with your PostgreSQL credentials
   - Set `DB_CONNECTION=pgsql`
   - Set `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`

3. **Run migrations:**
   ```bash
   php artisan migrate
   ```

4. **Start the server:**
   ```bash
   php artisan serve
   ```

## API Endpoints

### Public Routes

#### Register User
- **POST** `/api/register`
- **Body:**
  ```json
  {
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
  ```
- **Response:**
  ```json
  {
    "success": true,
    "message": "User registered successfully",
    "data": {
      "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": "2023-01-01T00:00:00.000000Z",
        "updated_at": "2023-01-01T00:00:00.000000Z"
      },
      "token": "1|abc123...",
      "token_type": "Bearer"
    }
  }
  ```

#### Login User
- **POST** `/api/login`
- **Body:**
  ```json
  {
    "email": "john@example.com",
    "password": "password123"
  }
  ```
- **Response:**
  ```json
  {
    "success": true,
    "message": "Login successful",
    "data": {
      "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": "2023-01-01T00:00:00.000000Z",
        "updated_at": "2023-01-01T00:00:00.000000Z"
      },
      "token": "1|abc123...",
      "token_type": "Bearer"
    }
  }
  ```

### Protected Routes (Require Bearer Token)

#### Get Current User
- **GET** `/api/me`
- **Headers:** `Authorization: Bearer {token}`
- **Response:**
  ```json
  {
    "success": true,
    "data": {
      "user": {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": "2023-01-01T00:00:00.000000Z",
        "updated_at": "2023-01-01T00:00:00.000000Z"
      }
    }
  }
  ```

#### Logout User
- **POST** `/api/logout`
- **Headers:** `Authorization: Bearer {token}`
- **Response:**
  ```json
  {
    "success": true,
    "message": "Logged out successfully"
  }
  ```

## Error Responses

All endpoints return consistent error responses:

```json
{
  "success": false,
  "message": "Error message",
  "errors": {
    "field": ["Validation error message"]
  }
}
```

## Testing with cURL

### Register
```bash
curl -X POST http://localhost:8000/api/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }'
```

### Login
```bash
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

### Get User (Protected)
```bash
curl -X GET http://localhost:8000/api/me \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Logout
```bash
curl -X POST http://localhost:8000/api/logout \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```