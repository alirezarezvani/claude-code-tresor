# React Style Guide ⚛️

A comprehensive React coding standard for modern React development with hooks, TypeScript, and performance best practices.

## 📋 Table of Contents

- [Component Design](#component-design)
- [Hooks Patterns](#hooks-patterns)
- [State Management](#state-management)
- [Performance Optimization](#performance-optimization)
- [Testing Patterns](#testing-patterns)
- [TypeScript Integration](#typescript-integration)

## 🧩 Component Design

### Function Components and JSX
```tsx
// ✅ Good: Use function components with TypeScript
interface UserProfileProps {
  user: User;
  onEdit?: (user: User) => void;
  className?: string;
}

export const UserProfile: React.FC<UserProfileProps> = ({
  user,
  onEdit,
  className = ''
}) => {
  const handleEditClick = () => {
    if (onEdit) {
      onEdit(user);
    }
  };

  return (
    <div className={`user-profile ${className}`}>
      <img
        src={user.avatar}
        alt={`${user.name}'s avatar`}
        className="user-profile__avatar"
      />
      <h2 className="user-profile__name">{user.name}</h2>
      <p className="user-profile__email">{user.email}</p>

      {onEdit && (
        <button
          type="button"
          onClick={handleEditClick}
          className="user-profile__edit-btn"
        >
          Edit Profile
        </button>
      )}
    </div>
  );
};

// ❌ Bad: Class components (avoid for new code)
class UserProfile extends React.Component<UserProfileProps> {
  render() {
    // Don't use class components for new code
  }
}
```

### Component Organization
```tsx
// ✅ Good: Well-organized component file
// UserCard.tsx
import React, { useState, useCallback, memo } from 'react';
import { User, UserRole } from '../../types/user';
import { formatDate } from '../../utils/date';
import { Button } from '../ui/Button';
import { Avatar } from '../ui/Avatar';
import './UserCard.styles.css';

// Types first
interface UserCardProps {
  user: User;
  showActions?: boolean;
  onEdit?: (user: User) => void;
  onDelete?: (userId: string) => void;
  className?: string;
}

// Helper functions
const getRoleColor = (role: UserRole): string => {
  const colors = {
    admin: 'red',
    moderator: 'orange',
    user: 'blue'
  };
  return colors[role] || 'gray';
};

// Main component
export const UserCard: React.FC<UserCardProps> = memo(({
  user,
  showActions = true,
  onEdit,
  onDelete,
  className = ''
}) => {
  const [isExpanded, setIsExpanded] = useState(false);

  const handleEdit = useCallback(() => {
    onEdit?.(user);
  }, [onEdit, user]);

  const handleDelete = useCallback(() => {
    if (window.confirm(`Delete user ${user.name}?`)) {
      onDelete?.(user.id);
    }
  }, [onDelete, user.id, user.name]);

  const toggleExpanded = useCallback(() => {
    setIsExpanded(prev => !prev);
  }, []);

  return (
    <div className={`user-card ${className} ${isExpanded ? 'expanded' : ''}`}>
      <div className="user-card__header">
        <Avatar src={user.avatar} alt={user.name} size="medium" />
        <div className="user-card__info">
          <h3 className="user-card__name">{user.name}</h3>
          <span
            className="user-card__role"
            style={{ color: getRoleColor(user.role) }}
          >
            {user.role}
          </span>
        </div>
        <button
          type="button"
          onClick={toggleExpanded}
          className="user-card__toggle"
          aria-label={isExpanded ? 'Collapse' : 'Expand'}
        >
          {isExpanded ? '−' : '+'}
        </button>
      </div>

      {isExpanded && (
        <div className="user-card__details">
          <p><strong>Email:</strong> {user.email}</p>
          <p><strong>Joined:</strong> {formatDate(user.createdAt)}</p>
          <p><strong>Last Login:</strong> {formatDate(user.lastLoginAt)}</p>

          {showActions && (
            <div className="user-card__actions">
              <Button variant="outline" onClick={handleEdit}>
                Edit
              </Button>
              <Button variant="danger" onClick={handleDelete}>
                Delete
              </Button>
            </div>
          )}
        </div>
      )}
    </div>
  );
});

UserCard.displayName = 'UserCard';

// Default export
export default UserCard;
```

### Prop Patterns
```tsx
// ✅ Good: Discriminated union props for different variants
interface BaseButtonProps {
  children: React.ReactNode;
  className?: string;
  disabled?: boolean;
}

interface PrimaryButtonProps extends BaseButtonProps {
  variant: 'primary';
  onClick: () => void;
}

interface LinkButtonProps extends BaseButtonProps {
  variant: 'link';
  href: string;
  target?: string;
}

interface SubmitButtonProps extends BaseButtonProps {
  variant: 'submit';
  type: 'submit';
}

type ButtonProps = PrimaryButtonProps | LinkButtonProps | SubmitButtonProps;

export const Button: React.FC<ButtonProps> = (props) => {
  const baseClasses = `button ${props.className || ''}`;

  if (props.variant === 'link') {
    return (
      <a
        href={props.href}
        target={props.target}
        className={`${baseClasses} button--link`}
      >
        {props.children}
      </a>
    );
  }

  if (props.variant === 'submit') {
    return (
      <button
        type="submit"
        disabled={props.disabled}
        className={`${baseClasses} button--submit`}
      >
        {props.children}
      </button>
    );
  }

  return (
    <button
      type="button"
      onClick={props.onClick}
      disabled={props.disabled}
      className={`${baseClasses} button--primary`}
    >
      {props.children}
    </button>
  );
};

// ✅ Good: Compound component pattern
interface TabsContextValue {
  activeTab: string;
  setActiveTab: (tab: string) => void;
}

const TabsContext = React.createContext<TabsContextValue | null>(null);

const useTabs = () => {
  const context = useContext(TabsContext);
  if (!context) {
    throw new Error('useTabs must be used within Tabs component');
  }
  return context;
};

export const Tabs = {
  Root: ({ children, defaultTab }: { children: React.ReactNode; defaultTab: string }) => {
    const [activeTab, setActiveTab] = useState(defaultTab);

    return (
      <TabsContext.Provider value={{ activeTab, setActiveTab }}>
        <div className="tabs">{children}</div>
      </TabsContext.Provider>
    );
  },

  List: ({ children }: { children: React.ReactNode }) => (
    <div className="tabs__list" role="tablist">
      {children}
    </div>
  ),

  Tab: ({ value, children }: { value: string; children: React.ReactNode }) => {
    const { activeTab, setActiveTab } = useTabs();
    const isActive = activeTab === value;

    return (
      <button
        type="button"
        role="tab"
        aria-selected={isActive}
        onClick={() => setActiveTab(value)}
        className={`tabs__tab ${isActive ? 'tabs__tab--active' : ''}`}
      >
        {children}
      </button>
    );
  },

  Panel: ({ value, children }: { value: string; children: React.ReactNode }) => {
    const { activeTab } = useTabs();
    if (activeTab !== value) return null;

    return (
      <div role="tabpanel" className="tabs__panel">
        {children}
      </div>
    );
  },
};

// Usage
<Tabs.Root defaultTab="profile">
  <Tabs.List>
    <Tabs.Tab value="profile">Profile</Tabs.Tab>
    <Tabs.Tab value="settings">Settings</Tabs.Tab>
  </Tabs.List>

  <Tabs.Panel value="profile">
    <UserProfile user={user} />
  </Tabs.Panel>

  <Tabs.Panel value="settings">
    <UserSettings user={user} />
  </Tabs.Panel>
</Tabs.Root>
```

## 🎣 Hooks Patterns

### Custom Hooks
```tsx
// ✅ Good: Custom hook for API calls
interface UseApiResult<T> {
  data: T | null;
  loading: boolean;
  error: Error | null;
  refetch: () => void;
}

export function useApi<T>(url: string): UseApiResult<T> {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetchData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const response = await fetch(url);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Unknown error'));
    } finally {
      setLoading(false);
    }
  }, [url]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const refetch = useCallback(() => {
    fetchData();
  }, [fetchData]);

  return { data, loading, error, refetch };
}

// ✅ Good: Custom hook for local storage
export function useLocalStorage<T>(
  key: string,
  initialValue: T
): [T, (value: T | ((val: T) => T)) => void] {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error('Error reading from localStorage:', error);
      return initialValue;
    }
  });

  const setValue = useCallback((value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error('Error writing to localStorage:', error);
    }
  }, [key, storedValue]);

  return [storedValue, setValue];
}

// ✅ Good: Custom hook for form handling
interface UseFormOptions<T> {
  initialValues: T;
  validate?: (values: T) => Partial<Record<keyof T, string>>;
  onSubmit: (values: T) => void | Promise<void>;
}

export function useForm<T extends Record<string, any>>({
  initialValues,
  validate,
  onSubmit
}: UseFormOptions<T>) {
  const [values, setValues] = useState<T>(initialValues);
  const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleChange = useCallback((name: keyof T, value: any) => {
    setValues(prev => ({ ...prev, [name]: value }));

    // Clear error when user starts typing
    if (errors[name]) {
      setErrors(prev => ({ ...prev, [name]: undefined }));
    }
  }, [errors]);

  const handleSubmit = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();

    if (validate) {
      const validationErrors = validate(values);
      if (Object.keys(validationErrors).length > 0) {
        setErrors(validationErrors);
        return;
      }
    }

    try {
      setIsSubmitting(true);
      await onSubmit(values);
    } catch (error) {
      console.error('Form submission error:', error);
    } finally {
      setIsSubmitting(false);
    }
  }, [values, validate, onSubmit]);

  const reset = useCallback(() => {
    setValues(initialValues);
    setErrors({});
    setIsSubmitting(false);
  }, [initialValues]);

  return {
    values,
    errors,
    isSubmitting,
    handleChange,
    handleSubmit,
    reset
  };
}
```

### useEffect Best Practices
```tsx
// ✅ Good: Proper dependency arrays
export const UserProfile: React.FC<{ userId: string }> = ({ userId }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(false);

  // Effect with proper dependencies
  useEffect(() => {
    const fetchUser = async () => {
      setLoading(true);
      try {
        const userData = await api.getUser(userId);
        setUser(userData);
      } catch (error) {
        console.error('Failed to fetch user:', error);
      } finally {
        setLoading(false);
      }
    };

    if (userId) {
      fetchUser();
    }
  }, [userId]); // Only re-run when userId changes

  // Cleanup effect
  useEffect(() => {
    const interval = setInterval(() => {
      // Periodic updates
      if (user?.id) {
        api.updateLastSeen(user.id);
      }
    }, 30000);

    return () => clearInterval(interval);
  }, [user?.id]);

  if (loading) return <LoadingSpinner />;
  if (!user) return <div>User not found</div>;

  return <UserCard user={user} />;
};

// ✅ Good: Avoiding infinite loops
export const SearchResults: React.FC = () => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResult[]>([]);

  // Memoize the search function to prevent infinite re-renders
  const searchFunction = useMemo(
    () => debounce(async (searchQuery: string) => {
      if (!searchQuery.trim()) {
        setResults([]);
        return;
      }

      try {
        const data = await api.search(searchQuery);
        setResults(data);
      } catch (error) {
        console.error('Search failed:', error);
        setResults([]);
      }
    }, 300),
    []
  );

  useEffect(() => {
    searchFunction(query);
  }, [query, searchFunction]);

  return (
    <div>
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search..."
      />
      <SearchResultsList results={results} />
    </div>
  );
};
```

## 🏪 State Management

### useState Patterns
```tsx
// ✅ Good: State organization
interface UserFormState {
  name: string;
  email: string;
  role: UserRole;
  preferences: UserPreferences;
}

export const UserForm: React.FC = () => {
  // Group related state
  const [formState, setFormState] = useState<UserFormState>({
    name: '',
    email: '',
    role: 'user',
    preferences: {
      theme: 'light',
      notifications: true
    }
  });

  const [formStatus, setFormStatus] = useState<{
    isSubmitting: boolean;
    error: string | null;
  }>({
    isSubmitting: false,
    error: null
  });

  // Functional state updates
  const updateFormField = useCallback(<K extends keyof UserFormState>(
    field: K,
    value: UserFormState[K]
  ) => {
    setFormState(prev => ({
      ...prev,
      [field]: value
    }));
  }, []);

  const updatePreference = useCallback(<K extends keyof UserPreferences>(
    preference: K,
    value: UserPreferences[K]
  ) => {
    setFormState(prev => ({
      ...prev,
      preferences: {
        ...prev.preferences,
        [preference]: value
      }
    }));
  }, []);

  return (
    <form onSubmit={handleSubmit}>
      {/* Form fields */}
    </form>
  );
};
```

### useReducer for Complex State
```tsx
// ✅ Good: useReducer for complex state logic
interface TodoState {
  todos: Todo[];
  filter: 'all' | 'active' | 'completed';
  editingId: string | null;
}

type TodoAction =
  | { type: 'ADD_TODO'; payload: { text: string } }
  | { type: 'TOGGLE_TODO'; payload: { id: string } }
  | { type: 'DELETE_TODO'; payload: { id: string } }
  | { type: 'EDIT_TODO'; payload: { id: string; text: string } }
  | { type: 'SET_FILTER'; payload: { filter: TodoState['filter'] } }
  | { type: 'START_EDITING'; payload: { id: string } }
  | { type: 'STOP_EDITING' };

function todoReducer(state: TodoState, action: TodoAction): TodoState {
  switch (action.type) {
    case 'ADD_TODO':
      return {
        ...state,
        todos: [
          ...state.todos,
          {
            id: generateId(),
            text: action.payload.text,
            completed: false,
            createdAt: new Date()
          }
        ]
      };

    case 'TOGGLE_TODO':
      return {
        ...state,
        todos: state.todos.map(todo =>
          todo.id === action.payload.id
            ? { ...todo, completed: !todo.completed }
            : todo
        )
      };

    case 'DELETE_TODO':
      return {
        ...state,
        todos: state.todos.filter(todo => todo.id !== action.payload.id)
      };

    case 'SET_FILTER':
      return {
        ...state,
        filter: action.payload.filter
      };

    case 'START_EDITING':
      return {
        ...state,
        editingId: action.payload.id
      };

    case 'STOP_EDITING':
      return {
        ...state,
        editingId: null
      };

    default:
      return state;
  }
}

export const TodoApp: React.FC = () => {
  const [state, dispatch] = useReducer(todoReducer, {
    todos: [],
    filter: 'all',
    editingId: null
  });

  const addTodo = useCallback((text: string) => {
    dispatch({ type: 'ADD_TODO', payload: { text } });
  }, []);

  const toggleTodo = useCallback((id: string) => {
    dispatch({ type: 'TOGGLE_TODO', payload: { id } });
  }, []);

  return (
    <div className="todo-app">
      <TodoInput onAdd={addTodo} />
      <TodoList
        todos={state.todos}
        filter={state.filter}
        editingId={state.editingId}
        onToggle={toggleTodo}
        onDelete={(id) => dispatch({ type: 'DELETE_TODO', payload: { id } })}
        onStartEdit={(id) => dispatch({ type: 'START_EDITING', payload: { id } })}
        onStopEdit={() => dispatch({ type: 'STOP_EDITING' })}
      />
      <TodoFilters
        currentFilter={state.filter}
        onFilterChange={(filter) => dispatch({ type: 'SET_FILTER', payload: { filter } })}
      />
    </div>
  );
};
```

## ⚡ Performance Optimization

### Memoization Patterns
```tsx
// ✅ Good: React.memo for preventing unnecessary re-renders
interface UserCardProps {
  user: User;
  onEdit: (user: User) => void;
}

export const UserCard = memo<UserCardProps>(({ user, onEdit }) => {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onEdit(user)}>Edit</button>
    </div>
  );
}, (prevProps, nextProps) => {
  // Custom comparison function
  return (
    prevProps.user.id === nextProps.user.id &&
    prevProps.user.name === nextProps.user.name &&
    prevProps.user.email === nextProps.user.email &&
    prevProps.onEdit === nextProps.onEdit
  );
});

// ✅ Good: useMemo for expensive calculations
export const UserStatistics: React.FC<{ users: User[] }> = ({ users }) => {
  const statistics = useMemo(() => {
    console.log('Calculating statistics...'); // Only runs when users change

    return {
      total: users.length,
      active: users.filter(u => u.isActive).length,
      byRole: users.reduce((acc, user) => {
        acc[user.role] = (acc[user.role] || 0) + 1;
        return acc;
      }, {} as Record<string, number>),
      averageAge: users.reduce((sum, u) => sum + u.age, 0) / users.length
    };
  }, [users]);

  return (
    <div className="user-statistics">
      <h3>User Statistics</h3>
      <p>Total Users: {statistics.total}</p>
      <p>Active Users: {statistics.active}</p>
      <p>Average Age: {statistics.averageAge.toFixed(1)}</p>

      <h4>By Role:</h4>
      {Object.entries(statistics.byRole).map(([role, count]) => (
        <p key={role}>{role}: {count}</p>
      ))}
    </div>
  );
};

// ✅ Good: useCallback for event handlers
export const UserList: React.FC<{ users: User[] }> = ({ users }) => {
  const [selectedUsers, setSelectedUsers] = useState<Set<string>>(new Set());

  const handleUserSelect = useCallback((userId: string, selected: boolean) => {
    setSelectedUsers(prev => {
      const next = new Set(prev);
      if (selected) {
        next.add(userId);
      } else {
        next.delete(userId);
      }
      return next;
    });
  }, []);

  const handleSelectAll = useCallback(() => {
    setSelectedUsers(new Set(users.map(u => u.id)));
  }, [users]);

  const handleDeselectAll = useCallback(() => {
    setSelectedUsers(new Set());
  }, []);

  return (
    <div>
      <div className="user-list__controls">
        <button onClick={handleSelectAll}>Select All</button>
        <button onClick={handleDeselectAll}>Deselect All</button>
        <span>{selectedUsers.size} selected</span>
      </div>

      {users.map(user => (
        <UserCard
          key={user.id}
          user={user}
          selected={selectedUsers.has(user.id)}
          onSelect={handleUserSelect}
        />
      ))}
    </div>
  );
};
```

### Lazy Loading and Code Splitting
```tsx
// ✅ Good: Lazy loading components
const UserDashboard = lazy(() => import('./UserDashboard'));
const AdminPanel = lazy(() => import('./AdminPanel'));
const Settings = lazy(() => import('./Settings'));

export const App: React.FC = () => {
  const { user } = useAuth();

  return (
    <Router>
      <Suspense fallback={<LoadingSpinner />}>
        <Routes>
          <Route path="/dashboard" element={<UserDashboard />} />
          {user?.role === 'admin' && (
            <Route path="/admin" element={<AdminPanel />} />
          )}
          <Route path="/settings" element={<Settings />} />
        </Routes>
      </Suspense>
    </Router>
  );
};

// ✅ Good: Lazy loading with error boundary
export const LazyComponentWrapper: React.FC<{
  importFunc: () => Promise<{ default: React.ComponentType<any> }>;
  fallback?: React.ReactNode;
}> = ({ importFunc, fallback = <LoadingSpinner /> }) => {
  const LazyComponent = lazy(importFunc);

  return (
    <ErrorBoundary>
      <Suspense fallback={fallback}>
        <LazyComponent />
      </Suspense>
    </ErrorBoundary>
  );
};
```

## 🧪 Testing Patterns

### Component Testing with React Testing Library
```tsx
// UserCard.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { UserCard } from './UserCard';
import { mockUser } from '../../__mocks__/user';

describe('UserCard', () => {
  const defaultProps = {
    user: mockUser,
    onEdit: jest.fn(),
    onDelete: jest.fn()
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders user information correctly', () => {
    render(<UserCard {...defaultProps} />);

    expect(screen.getByText(mockUser.name)).toBeInTheDocument();
    expect(screen.getByText(mockUser.email)).toBeInTheDocument();
    expect(screen.getByRole('img', { name: `${mockUser.name}'s avatar` }))
      .toHaveAttribute('src', mockUser.avatar);
  });

  it('calls onEdit when edit button is clicked', async () => {
    const user = userEvent.setup();
    render(<UserCard {...defaultProps} />);

    const editButton = screen.getByRole('button', { name: /edit/i });
    await user.click(editButton);

    expect(defaultProps.onEdit).toHaveBeenCalledWith(mockUser);
  });

  it('shows confirmation before deleting', async () => {
    const user = userEvent.setup();

    // Mock window.confirm
    const confirmSpy = jest.spyOn(window, 'confirm').mockReturnValue(true);

    render(<UserCard {...defaultProps} />);

    const deleteButton = screen.getByRole('button', { name: /delete/i });
    await user.click(deleteButton);

    expect(confirmSpy).toHaveBeenCalledWith(`Delete user ${mockUser.name}?`);
    expect(defaultProps.onDelete).toHaveBeenCalledWith(mockUser.id);

    confirmSpy.mockRestore();
  });

  it('does not delete when confirmation is cancelled', async () => {
    const user = userEvent.setup();
    const confirmSpy = jest.spyOn(window, 'confirm').mockReturnValue(false);

    render(<UserCard {...defaultProps} />);

    const deleteButton = screen.getByRole('button', { name: /delete/i });
    await user.click(deleteButton);

    expect(defaultProps.onDelete).not.toHaveBeenCalled();
    confirmSpy.mockRestore();
  });

  it('expands and collapses details', async () => {
    const user = userEvent.setup();
    render(<UserCard {...defaultProps} />);

    // Initially collapsed
    expect(screen.queryByText(/email:/i)).not.toBeInTheDocument();

    // Expand
    const toggleButton = screen.getByRole('button', { name: /expand/i });
    await user.click(toggleButton);

    expect(screen.getByText(/email:/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /collapse/i })).toBeInTheDocument();

    // Collapse
    await user.click(screen.getByRole('button', { name: /collapse/i }));
    expect(screen.queryByText(/email:/i)).not.toBeInTheDocument();
  });
});
```

### Hook Testing
```tsx
// useLocalStorage.test.ts
import { renderHook, act } from '@testing-library/react';
import { useLocalStorage } from './useLocalStorage';

describe('useLocalStorage', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('returns initial value when localStorage is empty', () => {
    const { result } = renderHook(() => useLocalStorage('test-key', 'initial'));

    expect(result.current[0]).toBe('initial');
  });

  it('returns stored value from localStorage', () => {
    localStorage.setItem('test-key', JSON.stringify('stored-value'));

    const { result } = renderHook(() => useLocalStorage('test-key', 'initial'));

    expect(result.current[0]).toBe('stored-value');
  });

  it('updates localStorage when value changes', () => {
    const { result } = renderHook(() => useLocalStorage('test-key', 'initial'));

    act(() => {
      result.current[1]('new-value');
    });

    expect(result.current[0]).toBe('new-value');
    expect(JSON.parse(localStorage.getItem('test-key')!)).toBe('new-value');
  });

  it('handles functional updates', () => {
    const { result } = renderHook(() => useLocalStorage('test-key', 0));

    act(() => {
      result.current[1](prev => prev + 1);
    });

    expect(result.current[0]).toBe(1);
  });
});
```

## 📝 Documentation

### Component Documentation
```tsx
/**
 * UserCard displays user information in a card format with optional actions.
 *
 * @example
 * ```tsx
 * <UserCard
 *   user={user}
 *   showActions={true}
 *   onEdit={(user) => console.log('Edit', user)}
 *   onDelete={(id) => console.log('Delete', id)}
 * />
 * ```
 */
export interface UserCardProps {
  /** The user object to display */
  user: User;

  /** Whether to show edit/delete actions. Defaults to true */
  showActions?: boolean;

  /** Callback fired when the edit button is clicked */
  onEdit?: (user: User) => void;

  /** Callback fired when the delete button is clicked */
  onDelete?: (userId: string) => void;

  /** Additional CSS class name */
  className?: string;
}

export const UserCard: React.FC<UserCardProps> = ({
  user,
  showActions = true,
  onEdit,
  onDelete,
  className = ''
}) => {
  // Implementation
};
```

## 🎯 Quick Reference Checklist

### Before Committing
- [ ] Components are properly typed with TypeScript
- [ ] All components have proper accessibility attributes
- [ ] Event handlers are memoized with useCallback
- [ ] Expensive calculations are memoized with useMemo
- [ ] Components are wrapped with React.memo when beneficial
- [ ] Tests cover main functionality and edge cases
- [ ] No console.log statements in production code

### Code Review Checklist
- [ ] Props are properly typed and documented
- [ ] State updates are pure (no mutations)
- [ ] Effects have proper dependency arrays
- [ ] Error boundaries are used for error handling
- [ ] Loading and error states are handled
- [ ] Accessibility standards are followed
- [ ] Performance optimizations are appropriate

This React style guide ensures modern, performant, and maintainable React applications with TypeScript and best practices.