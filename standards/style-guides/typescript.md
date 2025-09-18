# TypeScript Style Guide 📘

A comprehensive TypeScript coding standard that promotes type safety, readability, and maintainability while leveraging TypeScript's powerful type system.

## 📋 Table of Contents

- [File Organization](#file-organization)
- [Naming Conventions](#naming-conventions)
- [Type Definitions](#type-definitions)
- [Code Structure](#code-structure)
- [Best Practices](#best-practices)
- [Tooling Configuration](#tooling-configuration)

## 📁 File Organization

### File Naming
```typescript
// ✅ Good: Use kebab-case for files
user-service.ts
api-client.ts
database-connection.ts

// ❌ Bad: Avoid camelCase or PascalCase for files
userService.ts
ApiClient.ts
DatabaseConnection.ts
```

### File Structure
```typescript
// file-structure.ts
// 1. Type imports first
import type { User, ApiResponse } from './types';

// 2. Value imports second
import { DatabaseService } from './services/database-service';
import { Logger } from './utils/logger';

// 3. Type definitions
interface UserCreateRequest {
  name: string;
  email: string;
  role: UserRole;
}

// 4. Enums and constants
enum UserRole {
  ADMIN = 'admin',
  USER = 'user',
  MODERATOR = 'moderator'
}

const MAX_RETRY_ATTEMPTS = 3;

// 5. Main implementation
export class UserService {
  // Implementation
}

// 6. Default export (if needed)
export default UserService;
```

### Directory Structure
```
src/
├── types/           # Type definitions
│   ├── index.ts     # Re-export all types
│   ├── user.ts      # User-related types
│   └── api.ts       # API-related types
├── services/        # Business logic
├── utils/           # Utility functions
├── components/      # React components (if applicable)
└── __tests__/       # Test files
```

## 🏷️ Naming Conventions

### Variables and Functions
```typescript
// ✅ Good: camelCase for variables and functions
const userName = 'john_doe';
const maxRetryCount = 3;

function calculateTotalPrice(items: Item[]): number {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// ✅ Good: Use descriptive names
const isUserAuthenticated = checkUserAuth();
const userPreferences = getUserPreferences();

// ❌ Bad: Abbreviations and unclear names
const usr = 'john_doe';
const calc = (x: number) => x * 2;
```

### Classes and Interfaces
```typescript
// ✅ Good: PascalCase for classes and interfaces
class UserService {
  private readonly databaseConnection: DatabaseConnection;
}

interface PaymentProvider {
  processPayment(amount: number): Promise<PaymentResult>;
}

// ✅ Good: Use 'I' prefix for interfaces when needed to avoid conflicts
interface IPaymentGateway {
  charge(amount: number): Promise<boolean>;
}

class PaymentGateway implements IPaymentGateway {
  // Implementation
}
```

### Types and Enums
```typescript
// ✅ Good: PascalCase for types and enums
type UserStatus = 'active' | 'inactive' | 'pending';

enum OrderStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  SHIPPED = 'shipped',
  DELIVERED = 'delivered',
  CANCELLED = 'cancelled'
}

// ✅ Good: Use descriptive type aliases
type UserId = string;
type DatabaseId = number;
type TimestampMs = number;
```

### Constants
```typescript
// ✅ Good: SCREAMING_SNAKE_CASE for constants
const MAX_UPLOAD_SIZE = 10 * 1024 * 1024; // 10MB
const API_BASE_URL = 'https://api.example.com';
const DEFAULT_TIMEOUT_MS = 5000;

// ✅ Good: Use const assertions for literal types
const SUPPORTED_FORMATS = ['jpg', 'png', 'gif'] as const;
type SupportedFormat = typeof SUPPORTED_FORMATS[number];
```

## 🔷 Type Definitions

### Interface Design
```typescript
// ✅ Good: Prefer interfaces for object shapes
interface User {
  readonly id: string;
  name: string;
  email: string;
  createdAt: Date;
  preferences?: UserPreferences;
}

// ✅ Good: Use optional properties appropriately
interface CreateUserRequest {
  name: string;
  email: string;
  preferences?: Partial<UserPreferences>;
}

// ✅ Good: Extend interfaces for related types
interface AdminUser extends User {
  permissions: Permission[];
  lastLoginAt: Date;
}
```

### Type Unions and Intersections
```typescript
// ✅ Good: Use union types for specific value sets
type Theme = 'light' | 'dark' | 'auto';
type HttpMethod = 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH';

// ✅ Good: Use intersection types for combining types
type UserWithPermissions = User & {
  permissions: Permission[];
};

// ✅ Good: Use discriminated unions for polymorphic types
interface LoadingState {
  status: 'loading';
}

interface SuccessState {
  status: 'success';
  data: any;
}

interface ErrorState {
  status: 'error';
  error: string;
}

type AsyncState = LoadingState | SuccessState | ErrorState;
```

### Generic Types
```typescript
// ✅ Good: Use meaningful generic type names
interface Repository<TEntity, TId = string> {
  findById(id: TId): Promise<TEntity | null>;
  save(entity: TEntity): Promise<TEntity>;
  delete(id: TId): Promise<void>;
}

// ✅ Good: Constrain generics when appropriate
interface Serializable {
  serialize(): string;
}

function processSerializable<T extends Serializable>(item: T): string {
  return item.serialize();
}

// ✅ Good: Use utility types
interface UserUpdate {
  name?: string;
  email?: string;
}

// Better: Use Partial utility type
type UserUpdate = Partial<Pick<User, 'name' | 'email'>>;
```

### Function Types
```typescript
// ✅ Good: Use function type syntax for simple functions
type EventHandler = (event: Event) => void;
type Validator<T> = (value: T) => boolean;

// ✅ Good: Use interface for complex function signatures
interface ApiClient {
  get<T>(url: string, options?: RequestOptions): Promise<T>;
  post<T, U>(url: string, data: T, options?: RequestOptions): Promise<U>;
}

// ✅ Good: Use overloads for flexible function signatures
function createElement(tag: 'div'): HTMLDivElement;
function createElement(tag: 'span'): HTMLSpanElement;
function createElement(tag: string): HTMLElement;
function createElement(tag: string): HTMLElement {
  return document.createElement(tag);
}
```

## 🏗️ Code Structure

### Class Design
```typescript
// ✅ Good: Well-structured class with clear organization
class UserService {
  // 1. Static properties
  private static readonly DEFAULT_PAGE_SIZE = 20;

  // 2. Instance properties
  private readonly repository: UserRepository;
  private readonly logger: Logger;

  // 3. Constructor
  constructor(
    repository: UserRepository,
    logger: Logger
  ) {
    this.repository = repository;
    this.logger = logger;
  }

  // 4. Public methods
  async createUser(userData: CreateUserRequest): Promise<User> {
    this.validateUserData(userData);
    const user = await this.repository.create(userData);
    this.logger.info(`User created: ${user.id}`);
    return user;
  }

  // 5. Private methods
  private validateUserData(userData: CreateUserRequest): void {
    if (!userData.email.includes('@')) {
      throw new ValidationError('Invalid email format');
    }
  }
}
```

### Error Handling
```typescript
// ✅ Good: Custom error classes with proper typing
class ValidationError extends Error {
  constructor(
    message: string,
    public readonly field: string
  ) {
    super(message);
    this.name = 'ValidationError';
  }
}

class NotFoundError extends Error {
  constructor(resource: string, id: string) {
    super(`${resource} with id ${id} not found`);
    this.name = 'NotFoundError';
  }
}

// ✅ Good: Result type for error handling
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

async function safeParseJson<T>(json: string): Promise<Result<T>> {
  try {
    const data = JSON.parse(json) as T;
    return { success: true, data };
  } catch (error) {
    return {
      success: false,
      error: error instanceof Error ? error : new Error('Parse failed')
    };
  }
}
```

### Async/Await Patterns
```typescript
// ✅ Good: Proper async/await usage with error handling
class DataService {
  async fetchUserData(id: string): Promise<User> {
    try {
      const response = await this.apiClient.get<UserResponse>(`/users/${id}`);
      return this.mapResponseToUser(response);
    } catch (error) {
      this.logger.error(`Failed to fetch user ${id}`, error);
      throw new Error(`Unable to fetch user data for ${id}`);
    }
  }

  // ✅ Good: Concurrent operations with Promise.all
  async fetchMultipleUsers(ids: string[]): Promise<User[]> {
    const promises = ids.map(id => this.fetchUserData(id));
    return Promise.all(promises);
  }

  // ✅ Good: Sequential processing when needed
  async processUsersSequentially(users: User[]): Promise<void> {
    for (const user of users) {
      await this.processUser(user);
    }
  }
}
```

## ⭐ Best Practices

### Type Safety
```typescript
// ✅ Good: Use strict TypeScript configuration
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  }
}

// ✅ Good: Avoid 'any' type
// ❌ Bad
function processData(data: any): any {
  return data.map((item: any) => item.value);
}

// ✅ Good
function processData<T extends { value: unknown }>(data: T[]): unknown[] {
  return data.map(item => item.value);
}

// ✅ Good: Use type assertions carefully
const userElement = document.getElementById('user') as HTMLInputElement;

// Better: Use type guards
function isHTMLInputElement(element: Element): element is HTMLInputElement {
  return element instanceof HTMLInputElement;
}

const userElement = document.getElementById('user');
if (userElement && isHTMLInputElement(userElement)) {
  // TypeScript knows this is HTMLInputElement
  console.log(userElement.value);
}
```

### Immutability
```typescript
// ✅ Good: Use readonly for immutable data
interface ReadonlyUser {
  readonly id: string;
  readonly name: string;
  readonly email: string;
  readonly preferences: readonly string[];
}

// ✅ Good: Use const assertions
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
  retries: 3
} as const;

// ✅ Good: Immutable updates
function updateUser(user: User, updates: Partial<User>): User {
  return {
    ...user,
    ...updates,
    updatedAt: new Date()
  };
}
```

### Utility Types
```typescript
// ✅ Good: Leverage built-in utility types
interface User {
  id: string;
  name: string;
  email: string;
  password: string;
  role: string;
}

// Create types from existing interface
type PublicUser = Omit<User, 'password'>;
type UserUpdate = Partial<Pick<User, 'name' | 'email'>>;
type CreateUser = Omit<User, 'id'>;

// ✅ Good: Create reusable utility types
type ApiResponse<T> = {
  data: T;
  message: string;
  success: boolean;
};

type PaginatedResponse<T> = ApiResponse<T> & {
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
};
```

### Type Guards
```typescript
// ✅ Good: Create type guards for runtime type checking
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function isUser(obj: unknown): obj is User {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    typeof (obj as User).id === 'string' &&
    typeof (obj as User).name === 'string' &&
    typeof (obj as User).email === 'string'
  );
}

// ✅ Good: Use type guards in code
function processUserData(data: unknown): User {
  if (!isUser(data)) {
    throw new ValidationError('Invalid user data');
  }
  return data; // TypeScript knows this is User
}
```

## 🛠️ Tooling Configuration

### ESLint Configuration
```json
// .eslintrc.json
{
  "extends": [
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/prefer-const": "error",
    "@typescript-eslint/no-non-null-assertion": "error"
  }
}
```

### Prettier Configuration
```json
// .prettierrc
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

### TSConfig
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM"],
    "module": "commonjs",
    "moduleResolution": "node",
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
```

## 📝 Documentation

### JSDoc Comments
```typescript
/**
 * Represents a user in the system with authentication and profile information.
 *
 * @example
 * ```typescript
 * const user = new User({
 *   name: 'John Doe',
 *   email: 'john@example.com',
 *   role: UserRole.USER
 * });
 * ```
 */
interface User {
  /** Unique identifier for the user */
  readonly id: string;

  /** Full name of the user */
  name: string;

  /** Email address used for authentication */
  email: string;
}

/**
 * Creates a new user in the system.
 *
 * @param userData - The user data for creating a new user
 * @returns Promise that resolves to the created user
 * @throws {ValidationError} When user data is invalid
 * @throws {ConflictError} When email already exists
 *
 * @example
 * ```typescript
 * const user = await createUser({
 *   name: 'John Doe',
 *   email: 'john@example.com'
 * });
 * ```
 */
async function createUser(userData: CreateUserRequest): Promise<User> {
  // Implementation
}
```

## 🎯 Quick Reference Checklist

### Before Committing
- [ ] All functions have explicit return types
- [ ] No `any` types (unless absolutely necessary)
- [ ] Interfaces are used for object shapes
- [ ] Type guards are used for runtime checks
- [ ] Error types are properly defined
- [ ] JSDoc comments for public APIs
- [ ] ESLint passes without warnings
- [ ] All imports are properly typed

### Code Review Checklist
- [ ] Type safety is maintained throughout
- [ ] Generic types are properly constrained
- [ ] Error handling is comprehensive
- [ ] Immutability is preferred
- [ ] Utility types are used effectively
- [ ] Type definitions are reusable
- [ ] Documentation is clear and complete

This TypeScript style guide ensures type-safe, maintainable code that leverages TypeScript's powerful type system for better developer experience and runtime safety.