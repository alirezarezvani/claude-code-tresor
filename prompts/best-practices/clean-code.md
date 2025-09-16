# Clean Code Best Practices Prompts ✨

Comprehensive prompt templates for improving code quality, readability, and maintainability following clean code principles.

## Code Review and Refactoring

### Comprehensive Code Quality Review
```
Review this [LANGUAGE] code for clean code principles and suggest improvements:

```[language]
[CODE_TO_REVIEW]
```

**Context:**
- Project type: [PROJECT_TYPE]
- Team size: [TEAM_SIZE]
- Maintenance requirements: [MAINTENANCE_SCOPE]
- Performance constraints: [PERFORMANCE_REQUIREMENTS]

Analyze the code for:
1. **Readability**: Variable naming, function clarity, comment quality
2. **Maintainability**: Code structure, modularity, coupling
3. **SOLID Principles**: Single responsibility, open/closed, etc.
4. **DRY Principle**: Code duplication and reusability
5. **Error Handling**: Exception management and edge cases
6. **Testing**: Testability and test coverage considerations
7. **Performance**: Efficiency and optimization opportunities
8. **Security**: Potential vulnerabilities and best practices

For each issue found, provide:
- **Problem description**: What's wrong and why
- **Impact assessment**: How it affects code quality
- **Refactored solution**: Improved code example
- **Explanation**: Why the change is better
- **Prevention**: How to avoid this in future code
```

**Variables:**
- `[LANGUAGE]`: Programming language (JavaScript, Python, Java, etc.)
- `[CODE_TO_REVIEW]`: The actual code to analyze
- `[PROJECT_TYPE]`: Type of project (web app, API, library, etc.)
- `[TEAM_SIZE]`: How many developers work on this
- `[MAINTENANCE_SCOPE]`: Long-term vs short-term project
- `[PERFORMANCE_REQUIREMENTS]`: Any specific performance needs

**Example:**
```
Review this JavaScript code for clean code principles and suggest improvements:

```javascript
function processUserData(data) {
    let result = [];
    for (let i = 0; i < data.length; i++) {
        if (data[i].active && data[i].role === 'admin') {
            let obj = {
                n: data[i].name,
                e: data[i].email,
                p: data[i].permissions || []
            };
            if (obj.p.length > 0) {
                result.push(obj);
            }
        }
    }
    return result;
}
```

**Context:**
- Project type: E-commerce web application
- Team size: 5 developers
- Maintenance requirements: Long-term project (3+ years)
- Performance constraints: Must handle 1000+ users efficiently

Analyze the code for:
1. **Readability**: Variable naming, function clarity, comment quality
2. **Maintainability**: Code structure, modularity, coupling
3. **SOLID Principles**: Single responsibility, open/closed, etc.
4. **DRY Principle**: Code duplication and reusability
5. **Error Handling**: Exception management and edge cases
6. **Testing**: Testability and test coverage considerations
7. **Performance**: Efficiency and optimization opportunities
8. **Security**: Potential vulnerabilities and best practices
```

### Function Refactoring
```
Refactor this [LANGUAGE] function to follow clean code principles:

**Current Function:**
```[language]
[FUNCTION_CODE]
```

**Function Purpose:** [FUNCTION_DESCRIPTION]
**Current Issues:** [KNOWN_PROBLEMS]
**Requirements:** [FUNCTIONAL_REQUIREMENTS]

Apply these clean code principles:
1. **Single Responsibility**: Each function should do one thing well
2. **Meaningful Names**: Clear, descriptive variable and function names
3. **Small Functions**: Keep functions short and focused
4. **Pure Functions**: Minimize side effects where possible
5. **Error Handling**: Proper exception handling and validation
6. **Documentation**: Clear comments and documentation
7. **Performance**: Efficient algorithms and data structures

Provide:
- **Refactored code** with improvements
- **Before/after comparison** highlighting changes
- **Explanation** of each improvement
- **Unit tests** for the refactored function
- **Usage examples** showing the improved API
```

### Class/Module Restructuring
```
Restructure this [LANGUAGE] class/module following SOLID principles:

**Current Implementation:**
```[language]
[CLASS_OR_MODULE_CODE]
```

**Domain Context:** [BUSINESS_DOMAIN]
**Responsibilities:** [CURRENT_RESPONSIBILITIES]
**Issues:** [ARCHITECTURAL_PROBLEMS]

Apply SOLID principles:
1. **Single Responsibility**: One reason to change
2. **Open/Closed**: Open for extension, closed for modification
3. **Liskov Substitution**: Substitutable derived classes
4. **Interface Segregation**: Specific interfaces over general ones
5. **Dependency Inversion**: Depend on abstractions, not concretions

Additionally ensure:
- **Clear separation of concerns**
- **Loose coupling between components**
- **High cohesion within components**
- **Proper abstraction levels**
- **Testable architecture**

Provide:
- **Restructured code** with proper separation
- **Interface definitions** where appropriate
- **Dependency injection** setup if needed
- **Unit tests** for each component
- **Architecture diagram** showing relationships
```

## Naming and Readability

### Naming Convention Review
```
Improve the naming conventions in this [LANGUAGE] code:

```[language]
[CODE_WITH_POOR_NAMES]
```

**Code Context:** [CODE_PURPOSE]
**Domain:** [BUSINESS_DOMAIN]
**Team Conventions:** [EXISTING_STANDARDS]

Review and improve:
1. **Variable Names**: Clear, descriptive, appropriate scope
2. **Function Names**: Verb-based, intention-revealing
3. **Class Names**: Noun-based, single responsibility indication
4. **Constants**: Meaningful, properly scoped
5. **Boolean Variables**: Predicate-based (is, has, can, should)
6. **Collections**: Plural nouns, meaningful contents
7. **Temporary Variables**: Even temps should be clear

For each naming improvement:
- **Original name** and why it's problematic
- **Improved name** with justification
- **Alternative options** considered
- **Context explanation** for domain-specific terms
- **Consistency** with existing codebase
```

### Comment and Documentation Cleanup
```
Improve the comments and documentation in this [LANGUAGE] code:

```[language]
[CODE_WITH_COMMENTS]
```

**Code Purpose:** [FUNCTIONALITY_DESCRIPTION]
**Audience:** [TARGET_AUDIENCE] (team members, external users, etc.)
**Complexity Level:** [COMPLEXITY_ASSESSMENT]

Improve documentation by:
1. **Removing redundant comments** that state the obvious
2. **Adding intent-revealing comments** for complex logic
3. **Documenting assumptions** and constraints
4. **Explaining business rules** and domain concepts
5. **Adding examples** for complex APIs
6. **Creating API documentation** with proper format
7. **Warning comments** for gotchas and edge cases

Provide:
- **Cleaned code** with improved comments
- **API documentation** in proper format
- **Usage examples** with explanations
- **Architecture notes** for complex decisions
- **TODO/FIXME** comments for known issues
```

## Architecture and Design Patterns

### Design Pattern Implementation
```
Implement the [DESIGN_PATTERN] pattern to solve [PROBLEM_DESCRIPTION]:

**Current Code Structure:**
```[language]
[EXISTING_CODE]
```

**Problems with Current Approach:**
- [PROBLEM_1]
- [PROBLEM_2]
- [PROBLEM_3]

**Pattern Requirements:**
- Pattern: [DESIGN_PATTERN] (Strategy, Observer, Factory, etc.)
- Context: [USAGE_CONTEXT]
- Constraints: [IMPLEMENTATION_CONSTRAINTS]

Implement the pattern by:
1. **Identifying participants** and their roles
2. **Creating abstractions** (interfaces/abstract classes)
3. **Implementing concrete classes** following the pattern
4. **Refactoring existing code** to use the pattern
5. **Adding proper error handling** and validation
6. **Creating usage examples** and documentation

Provide:
- **Pattern implementation** with clean code
- **UML diagram** or code structure explanation
- **Migration strategy** from old to new code
- **Unit tests** for pattern components
- **Performance considerations** and trade-offs
- **Alternative patterns** considered and why this was chosen
```

### Architectural Refactoring
```
Refactor this [SYSTEM_TYPE] architecture for better maintainability:

**Current Architecture:**
[ARCHITECTURE_DESCRIPTION or CODEBASE_STRUCTURE]

**Current Issues:**
- [ARCHITECTURAL_PROBLEM_1]
- [ARCHITECTURAL_PROBLEM_2]
- [ARCHITECTURAL_PROBLEM_3]

**Requirements:**
- Scalability: [SCALABILITY_NEEDS]
- Maintainability: [MAINTENANCE_REQUIREMENTS]
- Performance: [PERFORMANCE_GOALS]
- Team structure: [TEAM_ORGANIZATION]

Apply architectural principles:
1. **Separation of Concerns**: Clear layer boundaries
2. **Dependency Management**: Proper dependency flow
3. **Module Cohesion**: Related functionality grouped
4. **Interface Design**: Clear contracts between components
5. **Error Handling**: Consistent error management strategy
6. **Configuration**: Externalized configuration management

Provide:
- **New architecture design** with clear layers
- **Migration plan** with phases and steps
- **Interface definitions** between components
- **Configuration strategy** for different environments
- **Testing strategy** for architectural changes
- **Documentation** for the new architecture
```

## Error Handling and Robustness

### Error Handling Strategy
```
Improve error handling in this [LANGUAGE] code:

```[language]
[CODE_WITH_POOR_ERROR_HANDLING]
```

**Application Type:** [APPLICATION_TYPE]
**Error Scenarios:** [KNOWN_ERROR_SCENARIOS]
**User Experience Requirements:** [UX_REQUIREMENTS]

Implement comprehensive error handling:
1. **Input Validation**: Validate all inputs and parameters
2. **Exception Types**: Use appropriate exception hierarchies
3. **Error Recovery**: Implement fallback strategies where possible
4. **Logging Strategy**: Log errors with appropriate detail levels
5. **User Communication**: Provide meaningful error messages
6. **Resource Cleanup**: Ensure proper resource management
7. **Monitoring Integration**: Enable error tracking and alerting

For each error scenario:
- **Detection strategy**: How to catch the error
- **Recovery approach**: What to do when it occurs
- **User feedback**: How to inform users appropriately
- **Logging details**: What information to capture
- **Testing approach**: How to test error conditions
```

### Defensive Programming
```
Add defensive programming practices to this [LANGUAGE] code:

```[language]
[CODE_TO_HARDEN]
```

**Risk Assessment:** [RISK_FACTORS]
**Critical Paths:** [CRITICAL_FUNCTIONALITY]
**Data Sources:** [DATA_INPUT_SOURCES]

Implement defensive practices:
1. **Input Validation**: Validate all inputs thoroughly
2. **Null Safety**: Handle null/undefined values properly
3. **Boundary Checks**: Validate array bounds and ranges
4. **Type Safety**: Ensure proper type handling
5. **Resource Management**: Prevent memory leaks and resource exhaustion
6. **Configuration Validation**: Validate configuration values
7. **Assertion Usage**: Use assertions for debugging and validation

Provide:
- **Hardened code** with defensive practices
- **Validation functions** for reusable input checking
- **Error handling** for all identified risks
- **Unit tests** covering edge cases and failure scenarios
- **Performance impact** assessment of defensive measures
- **Documentation** of assumptions and constraints
```

## Performance and Optimization

### Performance Code Review
```
Review this [LANGUAGE] code for performance issues and optimization opportunities:

```[language]
[CODE_TO_OPTIMIZE]
```

**Performance Context:**
- Expected load: [LOAD_REQUIREMENTS]
- Current performance: [CURRENT_METRICS]
- Target performance: [PERFORMANCE_GOALS]
- Resource constraints: [RESOURCE_LIMITS]

Analyze for:
1. **Algorithm Efficiency**: Big O complexity and optimization
2. **Memory Usage**: Memory allocation and garbage collection
3. **I/O Operations**: Database queries, file operations, network calls
4. **Caching Opportunities**: Data caching and memoization
5. **Concurrency**: Parallel processing and async operations
6. **Resource Management**: Connection pooling, resource reuse
7. **Data Structures**: Optimal data structure choices

For each optimization:
- **Current bottleneck** identification
- **Optimized solution** with explanation
- **Performance impact** estimation
- **Trade-offs** and considerations
- **Measurement strategy** for validation
- **Regression prevention** approaches
```

### Memory Management Review
```
Review this [LANGUAGE] code for memory management issues:

```[language]
[CODE_WITH_MEMORY_CONCERNS]
```

**Memory Context:**
- Application type: [APPLICATION_TYPE]
- Memory constraints: [MEMORY_LIMITS]
- Usage patterns: [USAGE_PATTERNS]
- Current issues: [MEMORY_PROBLEMS]

Review for:
1. **Memory Leaks**: Unreferenced objects, event listeners, timers
2. **Memory Allocation**: Efficient object creation and reuse
3. **Data Structure Choice**: Memory-efficient data structures
4. **Garbage Collection**: GC-friendly coding patterns
5. **Resource Cleanup**: Proper disposal of resources
6. **Caching Strategy**: Memory vs performance trade-offs
7. **Memory Profiling**: Measurement and monitoring approaches

Provide:
- **Memory leak fixes** with explanations
- **Optimized data structures** and algorithms
- **Resource management** best practices
- **Memory profiling** setup and usage
- **Monitoring strategy** for production
- **Load testing** considerations for memory
```

## Testing and Maintainability

### Testability Improvement
```
Improve the testability of this [LANGUAGE] code:

```[language]
[HARD_TO_TEST_CODE]
```

**Current Testing Challenges:**
- [TESTING_CHALLENGE_1]
- [TESTING_CHALLENGE_2]
- [TESTING_CHALLENGE_3]

**Testing Requirements:**
- Test coverage target: [COVERAGE_TARGET]
- Testing framework: [TESTING_FRAMEWORK]
- CI/CD integration: [CI_REQUIREMENTS]

Improve testability by:
1. **Dependency Injection**: Make dependencies explicit and injectable
2. **Pure Functions**: Minimize side effects where possible
3. **Mocking Points**: Create clear interfaces for mocking
4. **State Management**: Make state changes predictable and testable
5. **Error Conditions**: Ensure error paths are testable
6. **Configuration**: Make configuration injectable for testing
7. **Timing Issues**: Remove or control time-dependent behavior

Provide:
- **Refactored code** with improved testability
- **Unit test examples** covering key scenarios
- **Mock/stub strategies** for dependencies
- **Test data factories** for consistent test setup
- **Integration test** approaches
- **Testing documentation** and guidelines
```

### Code Organization and Structure
```
Reorganize this [LANGUAGE] codebase for better maintainability:

**Current Structure:**
[CURRENT_CODE_ORGANIZATION]

**Maintenance Issues:**
- [MAINTENANCE_PROBLEM_1]
- [MAINTENANCE_PROBLEM_2]
- [MAINTENANCE_PROBLEM_3]

**Team Context:**
- Team size: [TEAM_SIZE]
- Development velocity: [VELOCITY_REQUIREMENTS]
- Feature complexity: [COMPLEXITY_LEVEL]

Reorganize using:
1. **Module Organization**: Logical grouping of related functionality
2. **Layer Separation**: Clear architectural layers
3. **Dependency Management**: Minimize coupling between modules
4. **Code Reusability**: Extract common functionality
5. **Configuration Management**: Centralize configuration
6. **Documentation Structure**: Organize documentation with code
7. **Build Organization**: Optimize build and deployment structure

Provide:
- **New code structure** with rationale
- **Migration plan** for reorganization
- **Dependency graph** showing relationships
- **Documentation strategy** for the new structure
- **Team workflow** considerations
- **Build and deployment** improvements
```

## Security and Code Safety

### Security Code Review
```
Review this [LANGUAGE] code for security vulnerabilities and best practices:

```[language]
[CODE_TO_SECURE]
```

**Security Context:**
- Application type: [APPLICATION_TYPE]
- Data sensitivity: [DATA_CLASSIFICATION]
- Threat model: [THREAT_ASSESSMENT]
- Compliance requirements: [COMPLIANCE_NEEDS]

Analyze for security issues:
1. **Input Validation**: SQL injection, XSS, command injection
2. **Authentication**: Proper user verification
3. **Authorization**: Appropriate access controls
4. **Data Protection**: Encryption, secure storage
5. **Session Management**: Secure session handling
6. **Error Information**: Information disclosure through errors
7. **Dependencies**: Third-party library vulnerabilities

For each security issue:
- **Vulnerability description** and risk level
- **Exploit scenario** and potential impact
- **Secure implementation** with code examples
- **Testing strategy** for security validation
- **Monitoring approach** for detection
- **Compliance considerations** if applicable
```

---

**Pro Tips for Clean Code Improvement:**
- Start with the most impactful changes first
- Focus on readability over cleverness
- Use meaningful names that explain intent
- Keep functions small and focused
- Eliminate code duplication systematically
- Add tests before and after refactoring
- Document architectural decisions
- Get team buy-in for coding standards
- Use static analysis tools for consistency
- Review and iterate on improvements