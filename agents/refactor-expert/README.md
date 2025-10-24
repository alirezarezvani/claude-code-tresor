# Refactor Expert Agent 🔧

Code refactoring specialist focused on clean architecture, SOLID principles, design patterns, and technical debt reduction. Transform legacy code into maintainable, testable solutions.

## 🎯 Overview

The **@refactor-expert** agent provides systematic code refactoring based on clean architecture principles and design patterns. From tactical improvements to architectural transformation, this agent helps modernize your codebase safely.

## ✨ Working with Skills (NEW!)

This agent works synergistically with code quality skills that flag immediate issues:

**Skills Flag Smells (Autonomous):**
- code-reviewer skill detects basic code smells (long functions, magic numbers)
- security-auditor skill identifies security anti-patterns
- test-generator skill reveals untested code needing refactoring

**This Agent (Expert):**
- Large-scale code restructuring and architectural refactoring
- SOLID principles implementation
- Design pattern application
- Legacy code modernization strategies

**Complementary Approach:** Skills detect code smells in real-time, providing early warnings. When comprehensive refactoring is needed, this agent provides strategic restructuring plans, applies design patterns, and safely transforms legacy code while maintaining functionality and test coverage.

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Code Smell Detection
- **God objects** - Classes doing too much
- **Long methods** - Functions exceeding cognitive complexity
- **Duplicate code** - DRY violations
- **Magic numbers** - Hardcoded values without context
- **Deep nesting** - Excessive indentation levels
- **Dead code** - Unused variables, functions, imports

### SOLID Principles
- **Single Responsibility** - One reason to change
- **Open/Closed** - Open for extension, closed for modification
- **Liskov Substitution** - Derived classes must be substitutable
- **Interface Segregation** - Many specific interfaces over general
- **Dependency Inversion** - Depend on abstractions, not concretions

### Design Patterns
- **Creational**: Factory, Builder, Singleton, Prototype
- **Structural**: Adapter, Decorator, Facade, Proxy
- **Behavioral**: Strategy, Observer, Command, Template Method
- **Architectural**: MVC, MVVM, Clean Architecture, Hexagonal

### Refactoring Techniques
- **Extract Method** - Break down large functions
- **Extract Class** - Split god objects
- **Move Method** - Improve cohesion
- **Replace Conditional with Polymorphism** - Remove type checking
- **Introduce Parameter Object** - Reduce parameter lists
- **Replace Magic Number with Named Constant**

## 🛠️ Usage Examples

### God Object Refactoring

```bash
@refactor-expert Refactor this 2000-line User class following SOLID principles

class User {
  // User data
  constructor(name, email, password) { }

  // Authentication (50 lines)
  login() { }
  logout() { }
  resetPassword() { }

  // Authorization (80 lines)
  hasPermission() { }
  assignRole() { }
  checkAccess() { }

  // Profile management (100 lines)
  updateProfile() { }
  uploadAvatar() { }
  changePassword() { }

  // Notifications (120 lines)
  sendEmail() { }
  sendSMS() { }
  pushNotification() { }

  // Analytics (150 lines)
  trackEvent() { }
  recordActivity() { }
  generateReport() { }

  // ... 1500 more lines
}
```

**Agent Response:**
```markdown
## Refactoring Analysis 🔧

### Issues Identified

#### 🔴 Critical: Violates Single Responsibility Principle
**Current**: One class handles 6+ responsibilities
- User data management
- Authentication
- Authorization
- Profile management
- Notifications
- Analytics

#### 🟡 High Coupling
- Changes to notifications affect User class
- Testing requires mocking 6 different concerns
- Hard to maintain and extend

### Refactored Architecture

#### 1. User Entity (Domain Model)
```typescript
// Pure data model with validation
class User {
  constructor(
    public readonly id: string,
    public name: string,
    public email: string,
    private passwordHash: string
  ) {
    this.validateEmail(email);
  }

  private validateEmail(email: string) {
    // Validation logic
  }

  updateName(name: string): void {
    this.name = name;
  }
}
```

#### 2. Authentication Service
```typescript
class AuthenticationService {
  constructor(
    private userRepository: IUserRepository,
    private passwordHasher: IPasswordHasher,
    private tokenService: ITokenService
  ) {}

  async login(email: string, password: string): Promise<AuthToken> {
    const user = await this.userRepository.findByEmail(email);
    if (!user) throw new UnauthorizedError();

    const isValid = await this.passwordHasher.verify(
      password,
      user.passwordHash
    );
    if (!isValid) throw new UnauthorizedError();

    return this.tokenService.generate(user.id);
  }

  async logout(token: string): Promise<void> {
    await this.tokenService.revoke(token);
  }

  async resetPassword(email: string): Promise<void> {
    // Implementation
  }
}
```

#### 3. Authorization Service
```typescript
class AuthorizationService {
  constructor(
    private permissionRepository: IPermissionRepository,
    private roleRepository: IRoleRepository
  ) {}

  async hasPermission(
    userId: string,
    resource: string,
    action: string
  ): Promise<boolean> {
    const permissions = await this.permissionRepository
      .findByUserId(userId);

    return permissions.some(p =>
      p.resource === resource && p.action === action
    );
  }

  async assignRole(userId: string, roleId: string): Promise<void> {
    // Implementation
  }
}
```

#### 4. Profile Service
```typescript
class ProfileService {
  constructor(
    private userRepository: IUserRepository,
    private storageService: IStorageService
  ) {}

  async updateProfile(
    userId: string,
    updates: ProfileUpdate
  ): Promise<User> {
    const user = await this.userRepository.findById(userId);
    if (!user) throw new NotFoundError();

    user.updateName(updates.name);
    return await this.userRepository.save(user);
  }

  async uploadAvatar(
    userId: string,
    file: File
  ): Promise<string> {
    const url = await this.storageService.upload(file);
    await this.userRepository.updateAvatar(userId, url);
    return url;
  }
}
```

#### 5. Notification Service
```typescript
interface INotificationChannel {
  send(userId: string, message: string): Promise<void>;
}

class EmailChannel implements INotificationChannel {
  async send(userId: string, message: string): Promise<void> {
    // Email implementation
  }
}

class SMSChannel implements INotificationChannel {
  async send(userId: string, message: string): Promise<void> {
    // SMS implementation
  }
}

class NotificationService {
  constructor(private channels: Map<string, INotificationChannel>) {}

  async send(
    userId: string,
    message: string,
    channelType: string
  ): Promise<void> {
    const channel = this.channels.get(channelType);
    if (!channel) throw new Error('Invalid channel');

    await channel.send(userId, message);
  }
}
```

#### 6. Analytics Service
```typescript
class AnalyticsService {
  constructor(
    private eventStore: IEventStore,
    private reportGenerator: IReportGenerator
  ) {}

  async trackEvent(
    userId: string,
    eventName: string,
    properties: Record<string, any>
  ): Promise<void> {
    await this.eventStore.save({
      userId,
      eventName,
      properties,
      timestamp: Date.now()
    });
  }

  async generateReport(
    userId: string,
    period: DateRange
  ): Promise<Report> {
    const events = await this.eventStore.findByUser(userId, period);
    return this.reportGenerator.generate(events);
  }
}
```

### Benefits

#### ✅ Single Responsibility
- Each class has one clear purpose
- Easy to understand and maintain
- Changes isolated to specific concerns

#### ✅ Open/Closed Principle
- Easy to add new notification channels
- Can extend without modifying existing code

#### ✅ Dependency Inversion
- Services depend on interfaces, not implementations
- Easy to mock for testing
- Pluggable components

#### ✅ Testability
```typescript
// Easy to test in isolation
describe('AuthenticationService', () => {
  it('should login with valid credentials', async () => {
    const mockRepo = createMockUserRepository();
    const mockHasher = createMockPasswordHasher();
    const mockToken = createMockTokenService();

    const service = new AuthenticationService(
      mockRepo,
      mockHasher,
      mockToken
    );

    const token = await service.login('user@example.com', 'password');
    expect(token).toBeDefined();
  });
});
```

### Migration Strategy

#### Phase 1: Extract Services (Week 1)
- Create service interfaces
- Extract authentication logic
- Extract authorization logic
- Keep both old and new code

#### Phase 2: Update Dependencies (Week 2)
- Replace direct User calls with services
- Update controllers and middleware
- Add integration tests

#### Phase 3: Remove Legacy Code (Week 3)
- Remove old methods from User class
- Delete unused code
- Update documentation

#### Phase 4: Optimization (Week 4)
- Add caching layers
- Optimize database queries
- Performance testing
```

### Long Method Refactoring

```bash
@refactor-expert Refactor this 300-line function

function processOrder(orderData) {
  // Validate input (50 lines)
  // Calculate totals (80 lines)
  // Apply discounts (60 lines)
  // Process payment (40 lines)
  // Update inventory (30 lines)
  // Send notifications (40 lines)
}
```

**Agent Response:**
```markdown
## Method Refactoring 🔧

### Extract Methods Pattern

```typescript
class OrderProcessor {
  async processOrder(orderData: OrderData): Promise<Order> {
    // High-level orchestration
    const validatedData = this.validateOrderData(orderData);
    const order = this.createOrder(validatedData);

    const totals = this.calculateTotals(order);
    const discountedTotal = this.applyDiscounts(totals, order.customerId);

    await this.processPayment(order.id, discountedTotal);
    await this.updateInventory(order.items);
    await this.sendNotifications(order);

    return order;
  }

  private validateOrderData(data: OrderData): ValidatedOrderData {
    // Validation logic (focused, testable)
    if (!data.customerId) throw new ValidationError('Customer ID required');
    if (!data.items?.length) throw new ValidationError('No items');

    return {
      customerId: data.customerId,
      items: this.validateItems(data.items),
      shippingAddress: this.validateAddress(data.shippingAddress)
    };
  }

  private calculateTotals(order: Order): OrderTotals {
    const subtotal = order.items.reduce(
      (sum, item) => sum + (item.price * item.quantity),
      0
    );

    const tax = this.calculateTax(subtotal, order.shippingAddress);
    const shipping = this.calculateShipping(order.items, order.shippingAddress);

    return { subtotal, tax, shipping, total: subtotal + tax + shipping };
  }

  private applyDiscounts(
    totals: OrderTotals,
    customerId: string
  ): number {
    let total = totals.total;

    // Apply loyalty discount
    const loyaltyDiscount = this.getLoyaltyDiscount(customerId);
    total -= loyaltyDiscount;

    // Apply promo codes
    const promoDiscount = this.getPromoDiscount(order.promoCodes);
    total -= promoDiscount;

    return Math.max(total, 0); // Never negative
  }

  // ... other extracted methods
}
```

### Benefits
- ✅ Each method has single responsibility
- ✅ Easy to test in isolation
- ✅ Clear intention revealing names
- ✅ Reusable components
- ✅ Maintainable and readable
```

## 🎯 Refactoring Strategies

### Safe Refactoring Process
1. **Add tests** - Ensure current behavior is tested
2. **Small steps** - Refactor incrementally
3. **Run tests** - Verify after each change
4. **Commit often** - Easy rollback if needed
5. **Review** - Get feedback on changes

### When to Refactor
✅ **Refactor when:**
- Adding new features to messy code
- Fixing bugs in unclear code
- Code reviews reveal issues
- Technical debt is blocking progress

❌ **Don't refactor when:**
- No tests exist (write tests first)
- Under tight deadline (plan for later)
- Code works and rarely changes
- Just because you can

### Red-Green-Refactor (TDD)
1. **Red**: Write failing test
2. **Green**: Make it pass (quick and dirty)
3. **Refactor**: Clean up code while keeping tests green

---

**Need code refactoring? 🔧**

Use `@refactor-expert` with your legacy code for systematic refactoring following SOLID principles and design patterns!
