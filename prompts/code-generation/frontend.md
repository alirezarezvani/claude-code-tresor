# Frontend Code Generation Prompts 🎨

Battle-tested prompt templates for generating high-quality frontend code across various frameworks and libraries.

## React Component Generation

### Basic React Component
```
Create a React component named [COMPONENT_NAME] that:
- Accepts these props: [PROP_LIST]
- Implements [FUNCTIONALITY_DESCRIPTION]
- Uses TypeScript with proper type definitions
- Includes proper error boundaries and loading states
- Follows React best practices and hooks patterns
- Has accessible HTML structure (ARIA labels, semantic elements)
- Includes comprehensive JSDoc comments

Requirements:
- [SPECIFIC_REQUIREMENT_1]
- [SPECIFIC_REQUIREMENT_2]
- [STYLING_APPROACH] for styling (CSS modules, styled-components, Tailwind, etc.)

Please include:
1. The main component file
2. TypeScript interface definitions
3. Basic unit tests with React Testing Library
4. Usage example with sample data
```

**Variables:**
- `[COMPONENT_NAME]`: Name of your component (e.g., "UserProfile", "ProductCard")
- `[PROP_LIST]`: List of props (e.g., "userId: string, onUpdate: function, isEditable: boolean")
- `[FUNCTIONALITY_DESCRIPTION]`: What the component should do
- `[SPECIFIC_REQUIREMENT_X]`: Specific features or constraints
- `[STYLING_APPROACH]`: CSS approach (styled-components, Tailwind, CSS modules)

**Example:**
```
Create a React component named UserProfileCard that:
- Accepts these props: user: User, onEdit: () => void, isOwner: boolean
- Implements a profile display with avatar, name, bio, and edit functionality
- Uses TypeScript with proper type definitions
- Includes proper error boundaries and loading states
- Follows React best practices and hooks patterns
- Has accessible HTML structure (ARIA labels, semantic elements)
- Includes comprehensive JSDoc comments

Requirements:
- Show user avatar with fallback to initials
- Display edit button only when isOwner is true
- Handle long bio text with read more/less functionality
- styled-components for styling

Please include:
1. The main component file
2. TypeScript interface definitions
3. Basic unit tests with React Testing Library
4. Usage example with sample data
```

### React Hook Creation
```
Create a custom React hook named [HOOK_NAME] that:
- Manages [STATE_DESCRIPTION]
- Provides these methods: [METHOD_LIST]
- Handles [ERROR_CONDITIONS] gracefully
- Uses TypeScript with proper return types
- Includes cleanup for subscriptions/timers
- Follows React hooks conventions
- Has comprehensive error handling

Features to implement:
- [FEATURE_1]
- [FEATURE_2]
- [FEATURE_3]

Please include:
1. The hook implementation with TypeScript
2. Unit tests with React Hooks Testing Library
3. Usage example in a component
4. JSDoc documentation with examples
```

**Example:**
```
Create a custom React hook named useApiData that:
- Manages API data fetching and caching
- Provides these methods: fetch, refetch, clear, invalidate
- Handles network errors and loading states gracefully
- Uses TypeScript with proper return types
- Includes cleanup for ongoing requests
- Follows React hooks conventions
- Has comprehensive error handling

Features to implement:
- Automatic retry with exponential backoff
- Request deduplication for concurrent calls
- Local caching with TTL expiration
- Optimistic updates support

Please include:
1. The hook implementation with TypeScript
2. Unit tests with React Hooks Testing Library
3. Usage example in a component
4. JSDoc documentation with examples
```

### React Form Component
```
Create a React form component for [FORM_PURPOSE] that:
- Has these fields: [FIELD_LIST]
- Uses [FORM_LIBRARY] for form management (react-hook-form, formik, etc.)
- Implements client-side validation with [VALIDATION_RULES]
- Has proper error display and field highlighting
- Supports [SUBMISSION_BEHAVIOR] on form submission
- Includes accessibility features (labels, ARIA, keyboard navigation)
- Uses TypeScript with proper form data types

Validation requirements:
- [VALIDATION_REQUIREMENT_1]
- [VALIDATION_REQUIREMENT_2]

UI requirements:
- [UI_REQUIREMENT_1]
- [UI_REQUIREMENT_2]

Please include:
1. Form component with full TypeScript support
2. Validation schema
3. Error handling and display
4. Tests covering validation scenarios
5. Styling (using [STYLING_APPROACH])
```

## Vue.js Component Generation

### Vue 3 Composition API Component
```
Create a Vue 3 component named [COMPONENT_NAME] using Composition API that:
- Accepts these props: [PROP_LIST]
- Implements [FUNCTIONALITY_DESCRIPTION]
- Uses TypeScript with proper type definitions
- Has reactive data management with proper reactivity
- Includes lifecycle hooks: [LIFECYCLE_HOOKS]
- Has proper prop validation and default values
- Includes scoped slots for customization

Requirements:
- [SPECIFIC_REQUIREMENT_1]
- [SPECIFIC_REQUIREMENT_2]
- Use [STYLING_APPROACH] for styling

Please include:
1. Single File Component (.vue) with TypeScript
2. Proper prop definitions with validation
3. Unit tests with Vue Testing Library
4. Usage example with sample data
5. Documentation with prop descriptions
```

### Vue Composable (Custom Composition)
```
Create a Vue 3 composable named [COMPOSABLE_NAME] that:
- Manages [STATE_DESCRIPTION]
- Provides these reactive properties: [REACTIVE_PROPS]
- Includes these methods: [METHOD_LIST]
- Handles [SIDE_EFFECTS] with proper cleanup
- Uses TypeScript with proper return types
- Has comprehensive error handling

Features:
- [FEATURE_1]
- [FEATURE_2]

Please include:
1. Composable function with TypeScript
2. Unit tests with Vue Test Utils
3. Usage example in a component
4. Proper TypeScript interfaces
```

## Angular Component Generation

### Angular Component with Services
```
Create an Angular component named [COMPONENT_NAME] that:
- Implements [FUNCTIONALITY_DESCRIPTION]
- Uses these services: [SERVICE_LIST]
- Has these inputs: [INPUT_LIST]
- Has these outputs: [OUTPUT_LIST]
- Uses [CHANGE_DETECTION_STRATEGY] change detection
- Implements [LIFECYCLE_HOOKS] lifecycle hooks
- Has proper TypeScript interfaces
- Includes RxJS operators for data management

Requirements:
- [SPECIFIC_REQUIREMENT_1]
- [SPECIFIC_REQUIREMENT_2]
- Use [STYLING_APPROACH] for styling

Please include:
1. Component TypeScript file
2. Component template (HTML)
3. Component styles (SCSS/CSS)
4. Unit tests with TestBed
5. Service integration
```

## JavaScript/Vanilla JS Solutions

### Vanilla JavaScript Component
```
Create a vanilla JavaScript [COMPONENT_TYPE] that:
- Implements [FUNCTIONALITY_DESCRIPTION]
- Has these public methods: [METHOD_LIST]
- Supports these configuration options: [OPTIONS]
- Uses modern ES6+ features
- Has proper event handling and cleanup
- Includes accessibility features
- Works in modern browsers (ES2020+)

Requirements:
- [REQUIREMENT_1]
- [REQUIREMENT_2]
- No external dependencies
- Proper error handling

Please include:
1. Main component class/module
2. Usage examples
3. Configuration options documentation
4. Basic test suite (Jest or similar)
5. Browser compatibility notes
```

## UI Library Integration

### Material-UI/MUI Component
```
Create a React component using Material-UI that:
- Implements [COMPONENT_DESCRIPTION]
- Uses these MUI components: [MUI_COMPONENTS]
- Follows Material Design principles
- Has proper theme integration
- Supports dark/light mode switching
- Has responsive design for mobile/desktop
- Includes proper accessibility

Customizations:
- [CUSTOMIZATION_1]
- [CUSTOMIZATION_2]

Please include:
1. Component with MUI integration
2. Custom theme extensions if needed
3. Responsive breakpoint handling
4. TypeScript interfaces
5. Usage examples
```

### Tailwind CSS Component
```
Create a [COMPONENT_TYPE] component using Tailwind CSS that:
- Implements [FUNCTIONALITY_DESCRIPTION]
- Has these variants: [VARIANT_LIST]
- Uses Tailwind utility classes effectively
- Is fully responsive (mobile-first approach)
- Has proper hover/focus states
- Supports dark mode
- Has accessible color contrast

Design requirements:
- [DESIGN_REQUIREMENT_1]
- [DESIGN_REQUIREMENT_2]

Please include:
1. Component with Tailwind classes
2. Responsive design implementation
3. Dark mode support
4. Variant system
5. Usage examples with different variants
```

## State Management Integration

### Redux/Redux Toolkit Integration
```
Create a React component with Redux Toolkit integration that:
- Manages [STATE_DESCRIPTION] in Redux store
- Uses these RTK Query endpoints: [ENDPOINT_LIST]
- Has proper loading and error states
- Implements optimistic updates
- Has proper TypeScript integration
- Uses Redux Toolkit best practices

Store structure:
- [SLICE_NAME] slice with [STATE_PROPERTIES]
- Actions: [ACTION_LIST]
- Selectors: [SELECTOR_LIST]

Please include:
1. Redux slice with RTK
2. React component with hooks
3. TypeScript interfaces for state
4. Async thunks for side effects
5. Unit tests for reducer and component
```

### Context API Pattern
```
Create a React Context provider for [CONTEXT_PURPOSE] that:
- Manages [STATE_DESCRIPTION]
- Provides these values: [CONTEXT_VALUES]
- Has these actions: [ACTION_LIST]
- Includes proper TypeScript definitions
- Has error boundaries and fallbacks
- Uses useReducer for complex state logic

Requirements:
- [REQUIREMENT_1]
- [REQUIREMENT_2]

Please include:
1. Context provider component
2. Custom hook for consuming context
3. TypeScript interfaces
4. Example usage in components
5. Unit tests
```

## Performance Optimization Templates

### Optimized List Component
```
Create a performance-optimized list component that:
- Renders [ITEM_COUNT] items efficiently
- Uses virtual scrolling/windowing
- Has proper memoization with React.memo
- Implements lazy loading for items
- Has search/filter functionality
- Supports [ITEM_ACTIONS] on each item
- Uses TypeScript with proper generics

Performance requirements:
- Smooth scrolling with large datasets
- Minimal re-renders
- Memory efficient
- Fast search/filter

Please include:
1. Virtualized list component
2. Item component with memoization
3. Search/filter logic
4. Performance monitoring hooks
5. Usage examples with large datasets
```

### Code Splitting Example
```
Create a React application structure with:
- Route-based code splitting
- Component-based lazy loading
- Dynamic imports for [HEAVY_FEATURES]
- Loading states and error boundaries
- Proper TypeScript integration
- Bundle analysis optimization

Features to split:
- [FEATURE_1] - [SIZE_ESTIMATE]
- [FEATURE_2] - [SIZE_ESTIMATE]

Please include:
1. Router setup with lazy loading
2. Suspense and error boundaries
3. Loading components
4. Bundle optimization configuration
5. Performance measurement examples
```

## Testing Integration

### Component with Comprehensive Tests
```
Create a [COMPONENT_TYPE] component with comprehensive test coverage:
- Unit tests for all functionality
- Integration tests for user interactions
- Accessibility tests with jest-axe
- Visual regression tests setup
- Performance tests for rendering
- Mocking strategies for dependencies

Component requirements:
- [FUNCTIONALITY_DESCRIPTION]
- [PROP_LIST]
- [STATE_MANAGEMENT]

Testing requirements:
- 90%+ test coverage
- All user scenarios covered
- Error boundary testing
- Mobile interaction testing

Please include:
1. Main component implementation
2. Complete test suite
3. Mock factories for test data
4. Test utilities and helpers
5. Coverage report configuration
```

## Accessibility Focus Templates

### WCAG Compliant Component
```
Create an accessible [COMPONENT_TYPE] that:
- Meets WCAG 2.1 AA standards
- Has proper ARIA labels and roles
- Supports keyboard navigation
- Has sufficient color contrast
- Works with screen readers
- Has proper focus management
- Includes skip links where appropriate

Functionality:
- [CORE_FUNCTIONALITY]
- [INTERACTION_PATTERNS]

Accessibility requirements:
- [A11Y_REQUIREMENT_1]
- [A11Y_REQUIREMENT_2]

Please include:
1. Component with full accessibility features
2. ARIA implementation
3. Keyboard event handlers
4. Screen reader testing notes
5. Accessibility test suite
```

---

**Pro Tips for Frontend Code Generation:**
- Always specify the exact framework version
- Include TypeScript for better code quality
- Mention testing requirements upfront
- Specify styling approach clearly
- Include accessibility requirements
- Ask for comprehensive examples
- Request proper error handling
- Mention performance considerations