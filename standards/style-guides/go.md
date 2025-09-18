# Go Style Guide 🐹

A comprehensive Go coding standard following official Go conventions with extended guidelines for modern Go development, best practices, and idiomatic patterns.

## 📋 Table of Contents

- [Code Formatting](#code-formatting)
- [Naming Conventions](#naming-conventions)
- [Package Organization](#package-organization)
- [Error Handling](#error-handling)
- [Concurrency Patterns](#concurrency-patterns)
- [Best Practices](#best-practices)

## 📐 Code Formatting

### Basic Formatting
```go
// ✅ Good: Use gofmt/goimports for consistent formatting
package main

import (
    "context"
    "fmt"
    "log"
    "net/http"
    "time"

    "github.com/gorilla/mux"
    "github.com/pkg/errors"

    "myapp/internal/user"
    "myapp/pkg/database"
)

func main() {
    router := mux.NewRouter()
    router.HandleFunc("/users/{id}", getUserHandler).Methods("GET")

    server := &http.Server{
        Addr:         ":8080",
        Handler:      router,
        ReadTimeout:  30 * time.Second,
        WriteTimeout: 30 * time.Second,
    }

    log.Fatal(server.ListenAndServe())
}
```

### Line Length and Indentation
```go
// ✅ Good: Break long lines sensibly
func CreateUser(
    ctx context.Context,
    name string,
    email string,
    preferences *UserPreferences,
) (*User, error) {
    if err := validateEmail(email); err != nil {
        return nil, fmt.Errorf("invalid email: %w", err)
    }

    user := &User{
        ID:          generateID(),
        Name:        name,
        Email:       email,
        Preferences: preferences,
        CreatedAt:   time.Now(),
    }

    return user, nil
}

// ✅ Good: Align struct fields
type User struct {
    ID          string             `json:"id" db:"id"`
    Name        string             `json:"name" db:"name"`
    Email       string             `json:"email" db:"email"`
    Preferences *UserPreferences   `json:"preferences,omitempty" db:"preferences"`
    CreatedAt   time.Time          `json:"created_at" db:"created_at"`
    UpdatedAt   *time.Time         `json:"updated_at,omitempty" db:"updated_at"`
}
```

## 🏷️ Naming Conventions

### Variables and Functions
```go
// ✅ Good: Use camelCase for unexported names
var maxRetryCount = 3
var userCache = make(map[string]*User)

func calculateTotalPrice(items []Item) float64 {
    var total float64
    for _, item := range items {
        total += item.Price * float64(item.Quantity)
    }
    return total
}

// ✅ Good: Use PascalCase for exported names
const MaxUploadSize = 10 * 1024 * 1024 // 10MB
const DefaultTimeout = 30 * time.Second

func GetUserByID(ctx context.Context, id string) (*User, error) {
    // Implementation
    return nil, nil
}

// ✅ Good: Use short, clear names for local variables
func processUsers(users []*User) error {
    for _, u := range users {
        if err := u.Validate(); err != nil {
            return err
        }
    }
    return nil
}
```

### Types and Interfaces
```go
// ✅ Good: Use PascalCase for exported types
type UserService struct {
    db     *sql.DB
    logger *log.Logger
    cache  Cache
}

type UserRepository interface {
    GetByID(ctx context.Context, id string) (*User, error)
    Create(ctx context.Context, user *User) error
    Update(ctx context.Context, user *User) error
    Delete(ctx context.Context, id string) error
}

// ✅ Good: Use single-word interface names when possible
type Reader interface {
    Read([]byte) (int, error)
}

type Writer interface {
    Write([]byte) (int, error)
}

type ReadWriter interface {
    Reader
    Writer
}

// ✅ Good: Use descriptive names for complex types
type PaymentProcessor struct {
    gateway     PaymentGateway
    validator   PaymentValidator
    logger      Logger
    retryPolicy RetryPolicy
}
```

### Constants and Enums
```go
// ✅ Good: Group related constants
const (
    StatusPending   = "pending"
    StatusConfirmed = "confirmed"
    StatusShipped   = "shipped"
    StatusDelivered = "delivered"
    StatusCancelled = "cancelled"
)

// ✅ Good: Use iota for incrementing constants
type Priority int

const (
    PriorityLow Priority = iota
    PriorityMedium
    PriorityHigh
    PriorityCritical
)

// ✅ Good: Use typed constants for better type safety
type UserRole string

const (
    RoleAdmin     UserRole = "admin"
    RoleUser      UserRole = "user"
    RoleModerator UserRole = "moderator"
)
```

## 📦 Package Organization

### Package Structure
```go
// ✅ Good: Organize by domain, not by layer
myapp/
├── cmd/
│   └── myapp/
│       └── main.go
├── internal/
│   ├── user/
│   │   ├── handler.go
│   │   ├── service.go
│   │   ├── repository.go
│   │   └── models.go
│   ├── order/
│   │   ├── handler.go
│   │   ├── service.go
│   │   └── repository.go
│   └── common/
│       ├── database/
│       ├── logger/
│       └── config/
├── pkg/
│   ├── middleware/
│   ├── validator/
│   └── crypto/
└── api/
    └── openapi.yaml
```

### Package Declaration
```go
// ✅ Good: Package name matches directory name
package user

import (
    "context"
    "fmt"
    "time"

    "github.com/google/uuid"

    "myapp/internal/common/database"
    "myapp/pkg/validator"
)

// Service handles user business logic
type Service struct {
    repo      Repository
    validator *validator.Validator
    logger    Logger
}

// NewService creates a new user service
func NewService(repo Repository, v *validator.Validator, logger Logger) *Service {
    return &Service{
        repo:      repo,
        validator: v,
        logger:    logger,
    }
}
```

### Internal vs External Packages
```go
// ✅ Good: Use internal/ for private packages
// internal/user/service.go - Not importable by external packages
package user

type Service struct {
    // Private implementation
}

// ✅ Good: Use pkg/ for reusable packages
// pkg/validator/validator.go - Can be imported by external packages
package validator

import "regexp"

type Validator struct {
    emailRegex *regexp.Regexp
}

func New() *Validator {
    return &Validator{
        emailRegex: regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`),
    }
}

func (v *Validator) ValidateEmail(email string) bool {
    return v.emailRegex.MatchString(email)
}
```

## ❌ Error Handling

### Error Creation and Wrapping
```go
import (
    "errors"
    "fmt"
)

// ✅ Good: Define package-level errors
var (
    ErrUserNotFound     = errors.New("user not found")
    ErrInvalidEmail     = errors.New("invalid email format")
    ErrEmailAlreadyUsed = errors.New("email already in use")
)

// ✅ Good: Custom error types for rich error information
type ValidationError struct {
    Field   string
    Message string
}

func (e ValidationError) Error() string {
    return fmt.Sprintf("validation failed for field '%s': %s", e.Field, e.Message)
}

// ✅ Good: Error wrapping with context
func (s *Service) GetUser(ctx context.Context, id string) (*User, error) {
    user, err := s.repo.GetByID(ctx, id)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, ErrUserNotFound
        }
        return nil, fmt.Errorf("failed to get user %s: %w", id, err)
    }

    return user, nil
}

// ✅ Good: Error checking with proper handling
func (s *Service) CreateUser(ctx context.Context, req CreateUserRequest) (*User, error) {
    if err := s.validateCreateRequest(req); err != nil {
        return nil, fmt.Errorf("validation failed: %w", err)
    }

    existingUser, err := s.repo.GetByEmail(ctx, req.Email)
    if err != nil && !errors.Is(err, ErrUserNotFound) {
        return nil, fmt.Errorf("failed to check existing user: %w", err)
    }
    if existingUser != nil {
        return nil, ErrEmailAlreadyUsed
    }

    user := &User{
        ID:        uuid.New().String(),
        Name:      req.Name,
        Email:     req.Email,
        CreatedAt: time.Now(),
    }

    if err := s.repo.Create(ctx, user); err != nil {
        return nil, fmt.Errorf("failed to create user: %w", err)
    }

    return user, nil
}
```

### Error Handling Patterns
```go
// ✅ Good: Early return pattern
func processPayment(payment *Payment) error {
    if payment == nil {
        return errors.New("payment cannot be nil")
    }

    if payment.Amount <= 0 {
        return errors.New("payment amount must be positive")
    }

    if err := validatePaymentMethod(payment.Method); err != nil {
        return fmt.Errorf("invalid payment method: %w", err)
    }

    // Process payment
    return nil
}

// ✅ Good: Error aggregation
type MultiError struct {
    errors []error
}

func (m *MultiError) Error() string {
    if len(m.errors) == 0 {
        return "no errors"
    }

    var msg strings.Builder
    msg.WriteString(fmt.Sprintf("multiple errors (%d): ", len(m.errors)))
    for i, err := range m.errors {
        if i > 0 {
            msg.WriteString("; ")
        }
        msg.WriteString(err.Error())
    }
    return msg.String()
}

func (m *MultiError) Add(err error) {
    if err != nil {
        m.errors = append(m.errors, err)
    }
}

func (m *MultiError) HasErrors() bool {
    return len(m.errors) > 0
}
```

## 🔄 Concurrency Patterns

### Goroutines and Channels
```go
// ✅ Good: Worker pool pattern
func processItems(items []Item) error {
    const numWorkers = 10

    itemChan := make(chan Item, len(items))
    errChan := make(chan error, len(items))

    // Start workers
    var wg sync.WaitGroup
    for i := 0; i < numWorkers; i++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for item := range itemChan {
                if err := processItem(item); err != nil {
                    errChan <- fmt.Errorf("failed to process item %s: %w", item.ID, err)
                }
            }
        }()
    }

    // Send items to workers
    for _, item := range items {
        itemChan <- item
    }
    close(itemChan)

    // Wait for workers to complete
    wg.Wait()
    close(errChan)

    // Collect errors
    var errors []error
    for err := range errChan {
        errors = append(errors, err)
    }

    if len(errors) > 0 {
        return fmt.Errorf("processing failed with %d errors: %v", len(errors), errors[0])
    }

    return nil
}

// ✅ Good: Context cancellation
func fetchUserData(ctx context.Context, userID string) (*UserData, error) {
    resultChan := make(chan *UserData, 1)
    errChan := make(chan error, 1)

    go func() {
        // Simulate long-running operation
        time.Sleep(5 * time.Second)

        userData, err := expensiveUserDataFetch(userID)
        if err != nil {
            errChan <- err
            return
        }
        resultChan <- userData
    }()

    select {
    case result := <-resultChan:
        return result, nil
    case err := <-errChan:
        return nil, err
    case <-ctx.Done():
        return nil, ctx.Err()
    }
}
```

### Synchronization
```go
// ✅ Good: Proper mutex usage
type SafeCounter struct {
    mu    sync.RWMutex
    count int
}

func (c *SafeCounter) Increment() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.count++
}

func (c *SafeCounter) Value() int {
    c.mu.RLock()
    defer c.mu.RUnlock()
    return c.count
}

// ✅ Good: sync.Once for initialization
type Config struct {
    once   sync.Once
    data   map[string]string
    initErr error
}

func (c *Config) Get(key string) (string, error) {
    c.once.Do(func() {
        c.data, c.initErr = loadConfigFromFile()
    })

    if c.initErr != nil {
        return "", c.initErr
    }

    return c.data[key], nil
}

// ✅ Good: Channel-based synchronization
func fanOut(input <-chan int, workers int) []<-chan int {
    outputs := make([]<-chan int, workers)

    for i := 0; i < workers; i++ {
        output := make(chan int)
        outputs[i] = output

        go func(out chan<- int) {
            defer close(out)
            for n := range input {
                out <- n * n // Square the number
            }
        }(output)
    }

    return outputs
}
```

## ⭐ Best Practices

### Interface Design
```go
// ✅ Good: Small, focused interfaces
type Reader interface {
    Read([]byte) (int, error)
}

type Writer interface {
    Write([]byte) (int, error)
}

// ✅ Good: Accept interfaces, return structs
func ProcessData(r Reader, w Writer) error {
    data := make([]byte, 1024)
    for {
        n, err := r.Read(data)
        if err == io.EOF {
            break
        }
        if err != nil {
            return err
        }

        if _, err := w.Write(data[:n]); err != nil {
            return err
        }
    }
    return nil
}

// ✅ Good: Interface segregation
type UserGetter interface {
    GetUser(ctx context.Context, id string) (*User, error)
}

type UserCreator interface {
    CreateUser(ctx context.Context, user *User) error
}

type UserUpdater interface {
    UpdateUser(ctx context.Context, user *User) error
}

type UserRepository interface {
    UserGetter
    UserCreator
    UserUpdater
}
```

### Struct Design
```go
// ✅ Good: Embed interfaces for composition
type Service struct {
    UserRepository
    Logger
    cache  map[string]*User
    config *Config
}

// ✅ Good: Use functional options pattern
type ServerOption func(*Server)

func WithTimeout(timeout time.Duration) ServerOption {
    return func(s *Server) {
        s.timeout = timeout
    }
}

func WithLogger(logger Logger) ServerOption {
    return func(s *Server) {
        s.logger = logger
    }
}

func NewServer(addr string, opts ...ServerOption) *Server {
    s := &Server{
        addr:    addr,
        timeout: 30 * time.Second, // default
        logger:  defaultLogger,    // default
    }

    for _, opt := range opts {
        opt(s)
    }

    return s
}

// Usage
server := NewServer(":8080",
    WithTimeout(60*time.Second),
    WithLogger(customLogger),
)
```

### Context Usage
```go
// ✅ Good: Pass context as first parameter
func (s *Service) GetUser(ctx context.Context, id string) (*User, error) {
    // Check for cancellation
    select {
    case <-ctx.Done():
        return nil, ctx.Err()
    default:
    }

    return s.repo.GetUser(ctx, id)
}

// ✅ Good: Context with timeout
func fetchWithTimeout(url string) (*Response, error) {
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()

    req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
    if err != nil {
        return nil, err
    }

    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        return nil, err
    }
    defer resp.Body.Close()

    // Process response
    return processResponse(resp)
}

// ✅ Good: Context values for request-scoped data
type contextKey string

const (
    UserIDKey    contextKey = "user_id"
    RequestIDKey contextKey = "request_id"
)

func withUserID(ctx context.Context, userID string) context.Context {
    return context.WithValue(ctx, UserIDKey, userID)
}

func getUserID(ctx context.Context) (string, bool) {
    userID, ok := ctx.Value(UserIDKey).(string)
    return userID, ok
}
```

### Testing Patterns
```go
// ✅ Good: Table-driven tests
func TestCalculateTotal(t *testing.T) {
    tests := []struct {
        name     string
        items    []Item
        expected float64
        wantErr  bool
    }{
        {
            name: "empty items",
            items: []Item{},
            expected: 0,
            wantErr: false,
        },
        {
            name: "single item",
            items: []Item{{Price: 10.50, Quantity: 2}},
            expected: 21.00,
            wantErr: false,
        },
        {
            name: "multiple items",
            items: []Item{
                {Price: 10.00, Quantity: 1},
                {Price: 20.00, Quantity: 2},
            },
            expected: 50.00,
            wantErr: false,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result, err := CalculateTotal(tt.items)

            if tt.wantErr {
                if err == nil {
                    t.Errorf("expected error, got nil")
                }
                return
            }

            if err != nil {
                t.Errorf("unexpected error: %v", err)
                return
            }

            if result != tt.expected {
                t.Errorf("expected %v, got %v", tt.expected, result)
            }
        })
    }
}

// ✅ Good: Test helpers
func setupTestDB(t *testing.T) *sql.DB {
    t.Helper()

    db, err := sql.Open("sqlite3", ":memory:")
    if err != nil {
        t.Fatalf("failed to open test database: %v", err)
    }

    t.Cleanup(func() {
        db.Close()
    })

    return db
}

// ✅ Good: Mock interfaces
type MockUserRepository struct {
    users map[string]*User
}

func (m *MockUserRepository) GetUser(ctx context.Context, id string) (*User, error) {
    user, exists := m.users[id]
    if !exists {
        return nil, ErrUserNotFound
    }
    return user, nil
}

func (m *MockUserRepository) CreateUser(ctx context.Context, user *User) error {
    m.users[user.ID] = user
    return nil
}
```

## 🛠️ Tooling Configuration

### Go Modules
```go
// go.mod
module myapp

go 1.21

require (
    github.com/gorilla/mux v1.8.0
    github.com/pkg/errors v0.9.1
    github.com/stretchr/testify v1.8.4
)

require (
    github.com/davecgh/go-spew v1.1.1 // indirect
    github.com/pmezard/go-difflib v1.0.0 // indirect
    gopkg.in/yaml.v3 v3.0.1 // indirect
)
```

### Makefile
```makefile
# Makefile
.PHONY: build test lint clean

build:
	go build -o bin/myapp ./cmd/myapp

test:
	go test -v -race -coverprofile=coverage.out ./...

lint:
	golangci-lint run

fmt:
	go fmt ./...
	goimports -w .

clean:
	rm -rf bin/
	go clean -cache

deps:
	go mod download
	go mod tidy

coverage:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
```

### golangci-lint Configuration
```yaml
# .golangci.yml
run:
  timeout: 5m
  issues-exit-code: 1
  tests: true

output:
  format: colored-line-number
  print-issued-lines: true
  print-linter-name: true

linters:
  enable:
    - errcheck
    - gosimple
    - govet
    - ineffassign
    - staticcheck
    - typecheck
    - unused
    - varcheck
    - deadcode
    - structcheck
    - misspell
    - unconvert
    - gocyclo
    - gofmt
    - goimports

linters-settings:
  gocyclo:
    min-complexity: 15
  misspell:
    locale: US
  goimports:
    local-prefixes: myapp
```

## 🎯 Quick Reference Checklist

### Before Committing
- [ ] Code formatted with `gofmt`
- [ ] Imports organized with `goimports`
- [ ] All tests passing (`go test ./...`)
- [ ] No linting errors (`golangci-lint run`)
- [ ] Error handling is comprehensive
- [ ] Context is passed appropriately
- [ ] Documentation comments for exported functions

### Code Review Checklist
- [ ] Proper error handling and wrapping
- [ ] Goroutines are properly managed
- [ ] Interfaces are small and focused
- [ ] Context cancellation is respected
- [ ] No data races (test with `-race`)
- [ ] Resource cleanup (defer statements)
- [ ] Performance considerations addressed

This Go style guide ensures idiomatic, performant, and maintainable Go code following community best practices and official Go conventions.