# Error Analysis & Debugging Prompts 🐛

Systematic prompt templates for diagnosing, understanding, and resolving errors across different programming languages and environments.

## General Error Analysis

### Comprehensive Error Diagnosis
```
Analyze this error in [LANGUAGE/FRAMEWORK] and provide a comprehensive diagnosis:

**Error Message:**
[ERROR_MESSAGE]

**Stack Trace:**
[STACK_TRACE]

**Context Information:**
- Environment: [ENVIRONMENT] (development/staging/production)
- Language/Framework: [TECH_STACK]
- Operating System: [OS_INFO]
- Related code: [CODE_SNIPPET]
- Steps to reproduce: [REPRODUCTION_STEPS]
- When it started occurring: [TIMELINE]

**Additional Context:**
[ADDITIONAL_CONTEXT]

Please provide:
1. **Root Cause Analysis**: What exactly is causing this error?
2. **Impact Assessment**: How severe is this error and what are the consequences?
3. **Immediate Fix**: Step-by-step solution to resolve the error
4. **Long-term Prevention**: How to prevent this error from occurring again
5. **Alternative Solutions**: Other ways to approach this problem
6. **Testing Strategy**: How to verify the fix works correctly
7. **Monitoring**: How to detect if this error happens again
```

**Variables:**
- `[LANGUAGE/FRAMEWORK]`: The technology stack (e.g., React, Node.js, Python Django)
- `[ERROR_MESSAGE]`: The actual error message
- `[STACK_TRACE]`: Complete stack trace if available
- `[ENVIRONMENT]`: Where the error occurs
- `[TECH_STACK]`: Full technology stack details
- `[CODE_SNIPPET]`: Relevant code causing the issue
- `[REPRODUCTION_STEPS]`: How to reproduce the error
- `[ADDITIONAL_CONTEXT]`: Any other relevant information

**Example:**
```
Analyze this error in React/TypeScript and provide a comprehensive diagnosis:

**Error Message:**
TypeError: Cannot read properties of undefined (reading 'map')

**Stack Trace:**
at UserList.render (UserList.tsx:15:23)
at finishClassComponent (react-dom.development.js:9648:31)
at updateClassComponent (react-dom.development.js:9598:24)

**Context Information:**
- Environment: development (but also happening in production)
- Language/Framework: React 18.2.0 with TypeScript 4.8
- Operating System: macOS 12.6 / Linux production servers
- Related code: UserList component that renders a list of users
- Steps to reproduce: Navigate to /users page, error appears randomly
- When it started occurring: After recent API endpoint changes last week

**Additional Context:**
The error happens intermittently, not on every page load. It seems related to the users data from our API endpoint /api/users. Sometimes the data loads fine, other times this error occurs.
```

### Language-Specific Error Analysis

#### JavaScript/TypeScript Errors
```
Debug this JavaScript/TypeScript error:

**Error Type:** [ERROR_TYPE] (TypeError, ReferenceError, SyntaxError, etc.)
**Error Message:** [ERROR_MESSAGE]
**Code Context:**
```javascript
[CODE_SNIPPET]
```

**Browser/Runtime:** [RUNTIME_INFO]
**Additional Details:**
- [DETAIL_1]
- [DETAIL_2]

Analyze for:
1. **Type-related issues** (if TypeScript)
2. **Scope and closure problems**
3. **Async/await and Promise handling**
4. **DOM manipulation issues** (if browser)
5. **Memory leaks or performance issues**
6. **Event handling problems**

Provide:
- Root cause explanation
- Fixed code with explanations
- Prevention strategies
- Testing recommendations
```

#### Python Error Analysis
```
Debug this Python error:

**Error Type:** [EXCEPTION_TYPE]
**Error Message:** [ERROR_MESSAGE]
**Traceback:**
```
[FULL_TRACEBACK]
```

**Code Context:**
```python
[CODE_SNIPPET]
```

**Environment:**
- Python version: [PYTHON_VERSION]
- Dependencies: [KEY_DEPENDENCIES]
- Operating system: [OS_INFO]

Analyze for:
1. **Import and module issues**
2. **Data type problems**
3. **Exception handling gaps**
4. **Memory and performance issues**
5. **Third-party library conflicts**
6. **Environment and configuration issues**

Provide:
- Detailed error explanation
- Step-by-step fix
- Better error handling
- Code improvement suggestions
```

#### Database Error Analysis
```
Debug this database error:

**Database:** [DATABASE_TYPE] (PostgreSQL, MySQL, MongoDB, etc.)
**Error Message:** [ERROR_MESSAGE]
**Query/Operation:**
```sql
[SQL_QUERY_OR_OPERATION]
```

**Context:**
- Database version: [DB_VERSION]
- ORM/Driver: [ORM_INFO]
- Data volume: [DATA_SCALE]
- When it occurs: [OCCURRENCE_PATTERN]

Analyze for:
1. **Query syntax and logic errors**
2. **Performance and optimization issues**
3. **Index and schema problems**
4. **Lock and concurrency issues**
5. **Data integrity constraints**
6. **Connection and timeout issues**

Provide:
- Query/operation fix
- Performance optimization
- Schema recommendations
- Monitoring suggestions
```

## Specific Error Categories

### Memory and Performance Issues
```
Analyze this memory/performance issue in [LANGUAGE]:

**Problem Description:** [PERFORMANCE_PROBLEM]
**Symptoms:** [SYMPTOMS_LIST]
**Performance Metrics:**
- Memory usage: [MEMORY_INFO]
- CPU usage: [CPU_INFO]
- Response time: [TIMING_INFO]
- Throughput: [THROUGHPUT_INFO]

**Code Under Investigation:**
```[language]
[CODE_SNIPPET]
```

**Profiling Data:** [PROFILING_INFO]

Analyze for:
1. **Memory leaks** and excessive memory usage
2. **CPU bottlenecks** and algorithmic inefficiencies
3. **I/O performance** issues
4. **Concurrency problems**
5. **Caching opportunities**
6. **Resource cleanup issues**

Provide:
- Performance bottleneck identification
- Optimized code solutions
- Monitoring and profiling setup
- Load testing recommendations
- Scaling strategies
```

### Security Vulnerabilities
```
Analyze this potential security vulnerability:

**Vulnerability Type:** [VULNERABILITY_CATEGORY]
**Risk Level:** [RISK_ASSESSMENT] (Critical/High/Medium/Low)
**Affected Code:**
```[language]
[VULNERABLE_CODE]
```

**Attack Vector:** [ATTACK_DESCRIPTION]
**Current Security Measures:** [EXISTING_SECURITY]

Analyze for:
1. **Input validation** vulnerabilities
2. **Authentication/authorization** bypasses
3. **SQL injection** and code injection risks
4. **XSS and CSRF** vulnerabilities
5. **Data exposure** risks
6. **Dependency vulnerabilities**

Provide:
- **Security impact** assessment
- **Immediate mitigation** steps
- **Secure code** implementation
- **Testing strategy** for security
- **Long-term security** improvements
- **Compliance considerations**
```

### API and Network Errors
```
Debug this API/network error:

**Error Type:** [ERROR_CATEGORY] (4xx, 5xx, timeout, connection, etc.)
**HTTP Status:** [STATUS_CODE]
**Error Response:**
```json
[ERROR_RESPONSE]
```

**Request Details:**
- Method: [HTTP_METHOD]
- URL: [ENDPOINT_URL]
- Headers: [REQUEST_HEADERS]
- Body: [REQUEST_BODY]

**Network Context:**
- Client: [CLIENT_INFO]
- Environment: [NETWORK_ENVIRONMENT]
- Timing: [REQUEST_TIMING]

Analyze for:
1. **HTTP status code** meanings and implications
2. **Request/response** format issues
3. **Authentication** problems
4. **Rate limiting** and throttling
5. **Network connectivity** issues
6. **CORS and security** policy problems

Provide:
- Error explanation and fix
- Request debugging steps
- Client-side error handling
- API improvement suggestions
- Monitoring and alerting setup
```

## Systematic Debugging Approaches

### Step-by-Step Debug Process
```
Guide me through debugging [PROBLEM_TYPE] using systematic approach:

**Problem Statement:** [PROBLEM_DESCRIPTION]
**Expected Behavior:** [EXPECTED_RESULT]
**Actual Behavior:** [ACTUAL_RESULT]
**Code/System:** [SYSTEM_INFO]

Walk me through:
1. **Problem Isolation**: How to narrow down the issue
2. **Data Collection**: What information to gather
3. **Hypothesis Formation**: Potential causes to investigate
4. **Testing Methods**: How to test each hypothesis
5. **Solution Implementation**: Step-by-step fix
6. **Verification**: How to confirm the fix works
7. **Prevention**: How to avoid this in the future

For each step, provide:
- Specific commands or tools to use
- What to look for in the output
- Decision points for next steps
- Common pitfalls to avoid
```

### Root Cause Analysis Template
```
Perform root cause analysis for [INCIDENT_TYPE]:

**Incident Summary:** [INCIDENT_DESCRIPTION]
**Timeline:** [INCIDENT_TIMELINE]
**Impact:** [IMPACT_ASSESSMENT]
**Initial Symptoms:** [SYMPTOM_LIST]

**Investigation Areas:**
1. **Code Changes**: [RECENT_CHANGES]
2. **Infrastructure**: [INFRASTRUCTURE_INFO]
3. **Dependencies**: [DEPENDENCY_CHANGES]
4. **Data**: [DATA_RELATED_INFO]
5. **Configuration**: [CONFIG_CHANGES]

Using 5 Whys methodology:
1. Why did [PROBLEM] happen?
2. Why did [UNDERLYING_CAUSE_1] occur?
3. Why did [UNDERLYING_CAUSE_2] happen?
4. Why did [UNDERLYING_CAUSE_3] occur?
5. Why did [ROOT_CAUSE] exist?

Provide:
- **Root cause identification**
- **Contributing factors**
- **Immediate fixes**
- **Long-term solutions**
- **Prevention measures**
- **Monitoring improvements**
```

## Testing and Reproduction

### Error Reproduction Guide
```
Create a reproduction guide for [ERROR_TYPE]:

**Error Description:** [ERROR_SUMMARY]
**Environment Requirements:**
- [REQUIREMENT_1]
- [REQUIREMENT_2]
- [REQUIREMENT_3]

Create:
1. **Minimal reproduction case**: Simplest code that triggers the error
2. **Step-by-step instructions**: Exact steps to reproduce
3. **Expected vs actual results**: Clear comparison
4. **Environment setup**: How to configure the test environment
5. **Variations**: Different scenarios that trigger the same error
6. **Test automation**: Automated test that reproduces the error

Include:
- Code examples
- Configuration files
- Sample data
- Screenshots/logs where helpful
- Troubleshooting for setup issues
```

### Error Prevention Testing
```
Design tests to prevent [ERROR_CATEGORY] errors:

**Error Pattern:** [ERROR_PATTERN_DESCRIPTION]
**Vulnerable Areas:** [VULNERABLE_CODE_AREAS]
**Risk Factors:** [RISK_FACTORS]

Create test strategy covering:
1. **Unit Tests**: For individual functions/components
2. **Integration Tests**: For system interactions
3. **Edge Case Tests**: For boundary conditions
4. **Stress Tests**: For performance limits
5. **Security Tests**: For vulnerability prevention
6. **Regression Tests**: To prevent reintroduction

For each test category, provide:
- Test case examples
- Testing framework setup
- Assertion strategies
- Mock/stub requirements
- CI/CD integration
```

## Monitoring and Prevention

### Error Monitoring Setup
```
Set up comprehensive error monitoring for [APPLICATION_TYPE]:

**Current Error Patterns:** [ERROR_PATTERNS]
**Critical Paths:** [CRITICAL_FUNCTIONALITY]
**Performance Requirements:** [PERFORMANCE_TARGETS]

Implement monitoring for:
1. **Application Errors**: Runtime exceptions and failures
2. **Performance Issues**: Response time and resource usage
3. **User Experience**: Frontend errors and user flows
4. **Infrastructure**: Server and network issues
5. **Security Events**: Authentication and access violations
6. **Business Logic**: Domain-specific error conditions

Include:
- Logging strategy and structured logs
- Metrics collection and dashboards
- Alerting rules and thresholds
- Error tracking and categorization
- Performance monitoring
- User experience monitoring
```

### Proactive Error Prevention
```
Design proactive measures to prevent [ERROR_TYPES]:

**Historical Error Data:** [ERROR_HISTORY]
**Common Failure Points:** [FAILURE_POINTS]
**Risk Assessment:** [RISK_ANALYSIS]

Implement prevention strategies:
1. **Input Validation**: Comprehensive data validation
2. **Error Handling**: Graceful failure handling
3. **Circuit Breakers**: Failure isolation patterns
4. **Retry Logic**: Resilient operation retry
5. **Fallback Systems**: Alternative code paths
6. **Health Checks**: System health monitoring

For each strategy, provide:
- Implementation examples
- Configuration guidelines
- Testing approaches
- Monitoring integration
- Maintenance procedures
```

## Documentation and Knowledge Sharing

### Error Documentation Template
```
Create comprehensive documentation for [ERROR_TYPE]:

**Error Overview:** [ERROR_DESCRIPTION]
**Frequency:** [OCCURRENCE_FREQUENCY]
**Impact:** [BUSINESS_IMPACT]

Document:
1. **Symptoms**: How to recognize this error
2. **Causes**: What triggers this error
3. **Diagnosis**: How to investigate and confirm
4. **Resolution**: Step-by-step fix procedures
5. **Prevention**: How to avoid in the future
6. **Escalation**: When and how to escalate

Include:
- Troubleshooting flowchart
- Common variations and edge cases
- Tools and commands for diagnosis
- Contact information for experts
- Links to related documentation
- Update history and version info
```

---

**Pro Tips for Error Analysis:**
- Always gather complete context before analyzing
- Use systematic approaches rather than random debugging
- Focus on prevention as much as resolution
- Document common errors for team knowledge
- Set up proper monitoring before issues occur
- Test your fixes thoroughly
- Share knowledge with the team
- Keep error logs and learn from patterns