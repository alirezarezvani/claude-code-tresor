# Test Engineer Agent 🧪

Expert testing specialist for comprehensive test creation, validation, and quality assurance across all levels of the testing pyramid.

## 🎯 Overview

The **@test-engineer** agent is your dedicated testing expert that creates comprehensive, maintainable test suites. With deep knowledge of testing methodologies, frameworks, and best practices, it ensures your code is thoroughly tested and reliable.

## ✨ Working with Skills (NEW!)

This agent works in coordination with the **test-generator skill** which provides automatic test scaffolding:

**test-generator Skill (Autonomous):**
- Detects untested code automatically
- Generates basic test scaffolding (3-5 tests per function)
- Suggests obvious test cases (happy path, null checks)
- Tools: Read, Write, Edit (lightweight)

**This Agent (Manual Expert):**
- Invoked explicitly for comprehensive test suites (`@test-engineer`)
- Advanced test patterns (mocking, fixtures, parameterized tests)
- Integration and E2E test design
- Test strategy and coverage analysis
- Tools: Read, Write, Edit, Bash, Grep, Glob, Task (full access)

### Typical Workflow

1. **Skill detects** → New function without tests, suggests basic scaffolding
2. **You invoke this agent** → `@test-engineer Create comprehensive test suite`
3. **Agent builds** → Expand skill's basic tests into full suite with edge cases
4. **Complementary, not duplicate** → Skip basic tests skill created, focus on complex scenarios

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Test Suite Generation
- **Unit tests** with comprehensive coverage and edge cases
- **Integration tests** for module interactions and APIs
- **End-to-end tests** for complete user workflows
- **Component tests** for UI components and interactions
- **Performance tests** for load and stress testing
- **Visual regression tests** for UI consistency

### Testing Methodologies
- **Test-Driven Development (TDD)** guidance
- **Behavior-Driven Development (BDD)** scenarios
- **Testing pyramid** implementation
- **Test coverage** analysis and optimization
- **Mock and stub** creation and management
- **Test data management** and fixtures

### Framework Expertise
- **Unit Testing**: Jest, Vitest, Mocha, Jasmine, pytest
- **Component Testing**: React Testing Library, Vue Test Utils, Angular Testing
- **Integration Testing**: Supertest, Testcontainers, Pact
- **E2E Testing**: Cypress, Playwright, Selenium WebDriver
- **API Testing**: Postman, REST Assured, Newman
- **Performance Testing**: k6, JMeter, Artillery

## 🛠️ Usage Examples

### Unit Test Generation
```javascript
@test-engineer Create comprehensive unit tests for this utility function:

function calculateTotal(items, taxRate = 0.1, discountCode = null) {
  if (!items || items.length === 0) {
    throw new Error('Items array cannot be empty');
  }

  const subtotal = items.reduce((sum, item) => sum + item.price, 0);
  let total = subtotal;

  // Apply discount
  if (discountCode) {
    const discount = getDiscount(discountCode);
    total = total * (1 - discount);
  }

  // Add tax
  total = total * (1 + taxRate);

  return {
    subtotal,
    discount: discountCode ? subtotal - (total / (1 + taxRate)) : 0,
    tax: total - (total / (1 + taxRate)),
    total
  };
}
```

**Agent Response:**
```javascript
// calculateTotal.test.js
import { calculateTotal, getDiscount } from './calculateTotal';

// Mock the getDiscount function
jest.mock('./discounts', () => ({
  getDiscount: jest.fn()
}));

describe('calculateTotal', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Happy Path Tests', () => {
    test('calculates total with default tax rate and no discount', () => {
      const items = [
        { price: 100 },
        { price: 50 }
      ];

      const result = calculateTotal(items);

      expect(result).toEqual({
        subtotal: 150,
        discount: 0,
        tax: expect.closeTo(13.64, 2),
        total: expect.closeTo(165, 2)
      });
    });

    test('calculates total with custom tax rate', () => {
      const items = [{ price: 100 }];
      const taxRate = 0.2; // 20%

      const result = calculateTotal(items, taxRate);

      expect(result.total).toBeCloseTo(120, 2);
      expect(result.tax).toBeCloseTo(20, 2);
    });

    test('applies discount correctly', () => {
      getDiscount.mockReturnValue(0.1); // 10% discount
      const items = [{ price: 100 }];

      const result = calculateTotal(items, 0.1, 'SAVE10');

      expect(getDiscount).toHaveBeenCalledWith('SAVE10');
      expect(result.discount).toBeGreaterThan(0);
      expect(result.total).toBeLessThan(110); // Should be less than 100 + 10% tax
    });
  });

  describe('Edge Cases', () => {
    test('handles empty items array', () => {
      expect(() => calculateTotal([])).toThrow('Items array cannot be empty');
    });

    test('handles null items', () => {
      expect(() => calculateTotal(null)).toThrow('Items array cannot be empty');
    });

    test('handles undefined items', () => {
      expect(() => calculateTotal(undefined)).toThrow('Items array cannot be empty');
    });

    test('handles zero-priced items', () => {
      const items = [
        { price: 0 },
        { price: 50 }
      ];

      const result = calculateTotal(items);

      expect(result.subtotal).toBe(50);
      expect(result.total).toBeCloseTo(55, 2);
    });

    test('handles negative prices', () => {
      const items = [
        { price: 100 },
        { price: -20 } // Refund or discount item
      ];

      const result = calculateTotal(items);

      expect(result.subtotal).toBe(80);
      expect(result.total).toBeCloseTo(88, 2);
    });
  });

  describe('Discount Edge Cases', () => {
    test('handles invalid discount codes', () => {
      getDiscount.mockReturnValue(0); // No discount for invalid code
      const items = [{ price: 100 }];

      const result = calculateTotal(items, 0.1, 'INVALID');

      expect(result.discount).toBe(0);
      expect(result.total).toBeCloseTo(110, 2);
    });

    test('handles maximum discount (100%)', () => {
      getDiscount.mockReturnValue(1); // 100% discount
      const items = [{ price: 100 }];

      const result = calculateTotal(items, 0.1, 'FREE100');

      expect(result.discount).toBe(100);
      expect(result.total).toBe(0);
    });

    test('handles partial discount', () => {
      getDiscount.mockReturnValue(0.25); // 25% discount
      const items = [{ price: 200 }];

      const result = calculateTotal(items, 0.08, 'SAVE25');

      expect(result.discount).toBeCloseTo(50, 2);
      expect(result.total).toBeCloseTo(162, 2); // (200 - 50) * 1.08
    });
  });

  describe('Tax Rate Edge Cases', () => {
    test('handles zero tax rate', () => {
      const items = [{ price: 100 }];

      const result = calculateTotal(items, 0);

      expect(result.tax).toBe(0);
      expect(result.total).toBe(100);
    });

    test('handles high tax rate', () => {
      const items = [{ price: 100 }];

      const result = calculateTotal(items, 0.5); // 50% tax

      expect(result.tax).toBeCloseTo(50, 2);
      expect(result.total).toBeCloseTo(150, 2);
    });
  });

  describe('Performance Tests', () => {
    test('handles large number of items efficiently', () => {
      const items = Array(10000).fill({ price: 1 });
      const startTime = Date.now();

      const result = calculateTotal(items);

      const duration = Date.now() - startTime;
      expect(duration).toBeLessThan(100); // Should complete in under 100ms
      expect(result.subtotal).toBe(10000);
    });
  });

  describe('Data Type Tests', () => {
    test('handles string prices by converting to numbers', () => {
      const items = [
        { price: '100' },
        { price: '50.50' }
      ];

      // This test will fail with current implementation
      // Suggesting to add price validation and conversion
      expect(() => calculateTotal(items)).not.toThrow();
    });

    test('validates price is a valid number', () => {
      const items = [
        { price: 'not-a-number' }
      ];

      // This should ideally throw an error or handle gracefully
      expect(() => calculateTotal(items)).toThrow('Invalid price value');
    });
  });
});

// Integration test with actual discount service
describe('calculateTotal Integration Tests', () => {
  test('integrates with real discount service', async () => {
    // Mock API call to discount service
    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve({ discount: 0.15 })
      })
    );

    const items = [{ price: 100 }];
    const result = await calculateTotalWithRealDiscounts(items, 0.1, 'SAVE15');

    expect(result.discount).toBeCloseTo(15, 2);
    expect(fetch).toHaveBeenCalledWith('/api/discounts/SAVE15');
  });
});
```

### React Component Testing
```jsx
@test-engineer Create comprehensive tests for this React component:

import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

const UserProfile = ({ userId, onUpdate }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({ name: '', email: '' });

  useEffect(() => {
    fetchUser();
  }, [userId]);

  const fetchUser = async () => {
    try {
      setLoading(true);
      const response = await fetch(`/api/users/${userId}`);
      const userData = await response.json();
      setUser(userData);
      setFormData({ name: userData.name, email: userData.email });
    } catch (error) {
      console.error('Failed to fetch user:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch(`/api/users/${userId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });
      const updatedUser = await response.json();
      setUser(updatedUser);
      setEditing(false);
      onUpdate?.(updatedUser);
    } catch (error) {
      console.error('Failed to update user:', error);
    }
  };

  if (loading) return <div data-testid="loading">Loading...</div>;
  if (!user) return <div data-testid="error">User not found</div>;

  return (
    <div data-testid="user-profile">
      {editing ? (
        <form onSubmit={handleSubmit} data-testid="edit-form">
          <input
            type="text"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            data-testid="name-input"
          />
          <input
            type="email"
            value={formData.email}
            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
            data-testid="email-input"
          />
          <button type="submit" data-testid="save-button">Save</button>
          <button type="button" onClick={() => setEditing(false)} data-testid="cancel-button">
            Cancel
          </button>
        </form>
      ) : (
        <div data-testid="view-mode">
          <h2 data-testid="user-name">{user.name}</h2>
          <p data-testid="user-email">{user.email}</p>
          <button onClick={() => setEditing(true)} data-testid="edit-button">
            Edit
          </button>
        </div>
      )}
    </div>
  );
};
```

**Agent Response:**
```jsx
// UserProfile.test.jsx
import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { jest } from '@jest/globals';
import UserProfile from './UserProfile';

// Mock fetch globally
global.fetch = jest.fn();

describe('UserProfile Component', () => {
  const mockUser = {
    id: '1',
    name: 'John Doe',
    email: 'john@example.com'
  };

  const mockOnUpdate = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
    fetch.mockClear();
  });

  describe('Loading State', () => {
    test('displays loading state initially', () => {
      fetch.mockImplementation(() => new Promise(() => {})); // Never resolves

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      expect(screen.getByTestId('loading')).toBeInTheDocument();
      expect(screen.getByText('Loading...')).toBeInTheDocument();
    });
  });

  describe('Data Fetching', () => {
    test('fetches user data on mount', async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(mockUser)
      });

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      expect(fetch).toHaveBeenCalledWith('/api/users/1');

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });
    });

    test('refetches user data when userId changes', async () => {
      fetch.mockResolvedValue({
        json: () => Promise.resolve(mockUser)
      });

      const { rerender } = render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });

      fetch.mockClear();
      rerender(<UserProfile userId="2" onUpdate={mockOnUpdate} />);

      expect(fetch).toHaveBeenCalledWith('/api/users/2');
    });

    test('handles fetch error gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation(() => {});
      fetch.mockRejectedValueOnce(new Error('Network error'));

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('error')).toBeInTheDocument();
      });

      expect(consoleSpy).toHaveBeenCalledWith('Failed to fetch user:', expect.any(Error));
      consoleSpy.mockRestore();
    });
  });

  describe('View Mode', () => {
    beforeEach(async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(mockUser)
      });

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });
    });

    test('displays user information in view mode', () => {
      expect(screen.getByTestId('view-mode')).toBeInTheDocument();
      expect(screen.getByTestId('user-name')).toHaveTextContent('John Doe');
      expect(screen.getByTestId('user-email')).toHaveTextContent('john@example.com');
      expect(screen.getByTestId('edit-button')).toBeInTheDocument();
    });

    test('switches to edit mode when edit button is clicked', async () => {
      const user = userEvent.setup();

      await user.click(screen.getByTestId('edit-button'));

      expect(screen.getByTestId('edit-form')).toBeInTheDocument();
      expect(screen.getByTestId('name-input')).toHaveValue('John Doe');
      expect(screen.getByTestId('email-input')).toHaveValue('john@example.com');
    });
  });

  describe('Edit Mode', () => {
    beforeEach(async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(mockUser)
      });

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });

      const user = userEvent.setup();
      await user.click(screen.getByTestId('edit-button'));
    });

    test('displays edit form with current user data', () => {
      expect(screen.getByTestId('edit-form')).toBeInTheDocument();
      expect(screen.getByTestId('name-input')).toHaveValue('John Doe');
      expect(screen.getByTestId('email-input')).toHaveValue('john@example.com');
      expect(screen.getByTestId('save-button')).toBeInTheDocument();
      expect(screen.getByTestId('cancel-button')).toBeInTheDocument();
    });

    test('updates form data when inputs change', async () => {
      const user = userEvent.setup();
      const nameInput = screen.getByTestId('name-input');
      const emailInput = screen.getByTestId('email-input');

      await user.clear(nameInput);
      await user.type(nameInput, 'Jane Doe');

      await user.clear(emailInput);
      await user.type(emailInput, 'jane@example.com');

      expect(nameInput).toHaveValue('Jane Doe');
      expect(emailInput).toHaveValue('jane@example.com');
    });

    test('cancels editing and returns to view mode', async () => {
      const user = userEvent.setup();

      await user.click(screen.getByTestId('cancel-button'));

      expect(screen.getByTestId('view-mode')).toBeInTheDocument();
      expect(screen.queryByTestId('edit-form')).not.toBeInTheDocument();
    });
  });

  describe('Form Submission', () => {
    beforeEach(async () => {
      fetch
        .mockResolvedValueOnce({
          json: () => Promise.resolve(mockUser)
        });

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });

      const user = userEvent.setup();
      await user.click(screen.getByTestId('edit-button'));
    });

    test('submits form with updated data successfully', async () => {
      const user = userEvent.setup();
      const updatedUser = { ...mockUser, name: 'Jane Doe', email: 'jane@example.com' };

      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(updatedUser)
      });

      const nameInput = screen.getByTestId('name-input');
      const emailInput = screen.getByTestId('email-input');

      await user.clear(nameInput);
      await user.type(nameInput, 'Jane Doe');

      await user.clear(emailInput);
      await user.type(emailInput, 'jane@example.com');

      await user.click(screen.getByTestId('save-button'));

      expect(fetch).toHaveBeenCalledWith('/api/users/1', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: 'Jane Doe', email: 'jane@example.com' })
      });

      await waitFor(() => {
        expect(screen.getByTestId('view-mode')).toBeInTheDocument();
      });

      expect(screen.getByTestId('user-name')).toHaveTextContent('Jane Doe');
      expect(mockOnUpdate).toHaveBeenCalledWith(updatedUser);
    });

    test('handles form submission error', async () => {
      const user = userEvent.setup();
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation(() => {});

      fetch.mockRejectedValueOnce(new Error('Update failed'));

      await user.click(screen.getByTestId('save-button'));

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Failed to update user:', expect.any(Error));
      });

      // Should stay in edit mode on error
      expect(screen.getByTestId('edit-form')).toBeInTheDocument();

      consoleSpy.mockRestore();
    });

    test('submits form using Enter key', async () => {
      const user = userEvent.setup();
      const updatedUser = { ...mockUser, name: 'Jane Doe' };

      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(updatedUser)
      });

      const nameInput = screen.getByTestId('name-input');
      await user.clear(nameInput);
      await user.type(nameInput, 'Jane Doe{enter}');

      await waitFor(() => {
        expect(fetch).toHaveBeenCalledWith('/api/users/1', expect.any(Object));
      });
    });
  });

  describe('Error Handling', () => {
    test('displays error message when user is not found', async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(null)
      });

      render(<UserProfile userId="999" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('error')).toBeInTheDocument();
        expect(screen.getByText('User not found')).toBeInTheDocument();
      });
    });

    test('handles network errors during initial fetch', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation(() => {});
      fetch.mockRejectedValueOnce(new Error('Network error'));

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('error')).toBeInTheDocument();
      });

      consoleSpy.mockRestore();
    });
  });

  describe('Accessibility', () => {
    test('has proper form labels and structure', async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(mockUser)
      });

      render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });

      const user = userEvent.setup();
      await user.click(screen.getByTestId('edit-button'));

      const nameInput = screen.getByTestId('name-input');
      const emailInput = screen.getByTestId('email-input');

      expect(nameInput).toHaveAttribute('type', 'text');
      expect(emailInput).toHaveAttribute('type', 'email');
    });
  });

  describe('PropTypes and Edge Cases', () => {
    test('handles missing onUpdate prop gracefully', async () => {
      fetch.mockResolvedValueOnce({
        json: () => Promise.resolve(mockUser)
      });

      render(<UserProfile userId="1" />); // No onUpdate prop

      await waitFor(() => {
        expect(screen.getByTestId('user-profile')).toBeInTheDocument();
      });

      // Should not crash when onUpdate is not provided
      expect(screen.getByTestId('view-mode')).toBeInTheDocument();
    });

    test('handles empty userId', async () => {
      render(<UserProfile userId="" onUpdate={mockOnUpdate} />);

      expect(fetch).toHaveBeenCalledWith('/api/users/');
    });
  });
});

// Integration test
describe('UserProfile Integration Tests', () => {
  test('complete user edit workflow', async () => {
    const user = userEvent.setup();

    // Mock successful fetch
    fetch.mockResolvedValueOnce({
      json: () => Promise.resolve(mockUser)
    });

    render(<UserProfile userId="1" onUpdate={mockOnUpdate} />);

    // Wait for component to load
    await waitFor(() => {
      expect(screen.getByTestId('user-profile')).toBeInTheDocument();
    });

    // Click edit button
    await user.click(screen.getByTestId('edit-button'));

    // Modify data
    await user.clear(screen.getByTestId('name-input'));
    await user.type(screen.getByTestId('name-input'), 'Updated Name');

    // Mock successful update
    const updatedUser = { ...mockUser, name: 'Updated Name' };
    fetch.mockResolvedValueOnce({
      json: () => Promise.resolve(updatedUser)
    });

    // Submit form
    await user.click(screen.getByTestId('save-button'));

    // Verify update
    await waitFor(() => {
      expect(screen.getByText('Updated Name')).toBeInTheDocument();
    });

    expect(mockOnUpdate).toHaveBeenCalledWith(updatedUser);
  });
});
```

### API Integration Testing
```javascript
@test-engineer Create integration tests for this Express.js API:

const express = require('express');
const User = require('../models/User');
const auth = require('../middleware/auth');

const router = express.Router();

// GET /api/users
router.get('/', auth, async (req, res) => {
  try {
    const users = await User.find().select('-password');
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/users
router.post('/', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(409).json({ error: 'User already exists' });
    }

    const user = new User({ name, email, password });
    await user.save();

    res.status(201).json({
      id: user._id,
      name: user.name,
      email: user.email
    });
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;
```

**Agent Response:**
```javascript
// users.integration.test.js
const request = require('supertest');
const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');
const app = require('../../app'); // Your Express app
const User = require('../models/User');
const jwt = require('jsonwebtoken');

describe('Users API Integration Tests', () => {
  let mongoServer;
  let authToken;
  let testUser;

  beforeAll(async () => {
    // Start in-memory MongoDB instance
    mongoServer = await MongoMemoryServer.create();
    const mongoUri = mongoServer.getUri();

    // Connect to the in-memory database
    await mongoose.connect(mongoUri);
  });

  afterAll(async () => {
    // Clean up and close connections
    await mongoose.disconnect();
    await mongoServer.stop();
  });

  beforeEach(async () => {
    // Clear database before each test
    await User.deleteMany({});

    // Create a test user for authenticated requests
    testUser = new User({
      name: 'Test User',
      email: 'test@example.com',
      password: 'hashedPassword'
    });
    await testUser.save();

    // Generate auth token
    authToken = jwt.sign(
      { userId: testUser._id },
      process.env.JWT_SECRET || 'test-secret'
    );
  });

  describe('GET /api/users', () => {
    describe('Authentication', () => {
      test('returns 401 when no token provided', async () => {
        const response = await request(app)
          .get('/api/users')
          .expect(401);

        expect(response.body).toHaveProperty('error');
      });

      test('returns 401 when invalid token provided', async () => {
        const response = await request(app)
          .get('/api/users')
          .set('Authorization', 'Bearer invalid-token')
          .expect(401);

        expect(response.body).toHaveProperty('error');
      });

      test('accepts valid token', async () => {
        await request(app)
          .get('/api/users')
          .set('Authorization', `Bearer ${authToken}`)
          .expect(200);
      });
    });

    describe('Successful Requests', () => {
      test('returns empty array when no users exist', async () => {
        await User.deleteMany({});

        const response = await request(app)
          .get('/api/users')
          .set('Authorization', `Bearer ${authToken}`)
          .expect(200);

        expect(response.body).toEqual([]);
      });

      test('returns all users without passwords', async () => {
        // Create additional test users
        await User.create([
          { name: 'User 1', email: 'user1@example.com', password: 'hash1' },
          { name: 'User 2', email: 'user2@example.com', password: 'hash2' }
        ]);

        const response = await request(app)
          .get('/api/users')
          .set('Authorization', `Bearer ${authToken}`)
          .expect(200);

        expect(response.body).toHaveLength(3); // Including the beforeEach user

        response.body.forEach(user => {
          expect(user).toHaveProperty('_id');
          expect(user).toHaveProperty('name');
          expect(user).toHaveProperty('email');
          expect(user).not.toHaveProperty('password');
        });
      });

      test('returns users in consistent format', async () => {
        const response = await request(app)
          .get('/api/users')
          .set('Authorization', `Bearer ${authToken}`)
          .expect(200);

        const user = response.body[0];
        expect(user).toMatchObject({
          _id: expect.any(String),
          name: expect.any(String),
          email: expect.any(String)
        });
      });
    });

    describe('Error Handling', () => {
      test('handles database connection errors', async () => {
        // Mock database error
        jest.spyOn(User, 'find').mockImplementationOnce(() => {
          throw new Error('Database connection failed');
        });

        const response = await request(app)
          .get('/api/users')
          .set('Authorization', `Bearer ${authToken}`)
          .expect(500);

        expect(response.body).toEqual({ error: 'Internal server error' });
      });
    });
  });

  describe('POST /api/users', () => {
    const validUserData = {
      name: 'New User',
      email: 'newuser@example.com',
      password: 'securePassword123'
    };

    describe('Successful User Creation', () => {
      test('creates user with valid data', async () => {
        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        expect(response.body).toMatchObject({
          id: expect.any(String),
          name: validUserData.name,
          email: validUserData.email
        });

        expect(response.body).not.toHaveProperty('password');

        // Verify user was saved to database
        const savedUser = await User.findById(response.body.id);
        expect(savedUser).toBeTruthy();
        expect(savedUser.name).toBe(validUserData.name);
        expect(savedUser.email).toBe(validUserData.email);
      });

      test('returns correct response format', async () => {
        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        expect(response.body).toEqual({
          id: expect.stringMatching(/^[0-9a-fA-F]{24}$/), // MongoDB ObjectId format
          name: validUserData.name,
          email: validUserData.email
        });
      });
    });

    describe('Validation Errors', () => {
      test('returns 400 when name is missing', async () => {
        const invalidData = { ...validUserData };
        delete invalidData.name;

        const response = await request(app)
          .post('/api/users')
          .send(invalidData)
          .expect(400);

        expect(response.body).toEqual({ error: 'Missing required fields' });
      });

      test('returns 400 when email is missing', async () => {
        const invalidData = { ...validUserData };
        delete invalidData.email;

        const response = await request(app)
          .post('/api/users')
          .send(invalidData)
          .expect(400);

        expect(response.body).toEqual({ error: 'Missing required fields' });
      });

      test('returns 400 when password is missing', async () => {
        const invalidData = { ...validUserData };
        delete invalidData.password;

        const response = await request(app)
          .post('/api/users')
          .send(invalidData)
          .expect(400);

        expect(response.body).toEqual({ error: 'Missing required fields' });
      });

      test('returns 400 when all fields are missing', async () => {
        const response = await request(app)
          .post('/api/users')
          .send({})
          .expect(400);

        expect(response.body).toEqual({ error: 'Missing required fields' });
      });

      test('returns 400 when fields are empty strings', async () => {
        const invalidData = {
          name: '',
          email: '',
          password: ''
        };

        const response = await request(app)
          .post('/api/users')
          .send(invalidData)
          .expect(400);

        expect(response.body).toEqual({ error: 'Missing required fields' });
      });
    });

    describe('Duplicate User Handling', () => {
      test('returns 409 when user already exists', async () => {
        // First user creation should succeed
        await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        // Second user creation with same email should fail
        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(409);

        expect(response.body).toEqual({ error: 'User already exists' });
      });

      test('allows users with same name but different email', async () => {
        const user1 = { ...validUserData };
        const user2 = { ...validUserData, email: 'different@example.com' };

        await request(app)
          .post('/api/users')
          .send(user1)
          .expect(201);

        await request(app)
          .post('/api/users')
          .send(user2)
          .expect(201);

        const users = await User.find({});
        expect(users).toHaveLength(3); // Including beforeEach user
      });

      test('email check is case insensitive', async () => {
        await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        const duplicateWithDifferentCase = {
          ...validUserData,
          email: validUserData.email.toUpperCase()
        };

        const response = await request(app)
          .post('/api/users')
          .send(duplicateWithDifferentCase)
          .expect(409);

        expect(response.body).toEqual({ error: 'User already exists' });
      });
    });

    describe('Database Error Handling', () => {
      test('handles database save errors', async () => {
        // Mock database error
        jest.spyOn(User.prototype, 'save').mockImplementationOnce(() => {
          throw new Error('Database save failed');
        });

        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(500);

        expect(response.body).toEqual({ error: 'Internal server error' });
      });

      test('handles database query errors during duplicate check', async () => {
        // Mock database error for findOne
        jest.spyOn(User, 'findOne').mockImplementationOnce(() => {
          throw new Error('Database query failed');
        });

        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(500);

        expect(response.body).toEqual({ error: 'Internal server error' });
      });
    });

    describe('Data Integrity', () => {
      test('user count increases correctly', async () => {
        const initialCount = await User.countDocuments();

        await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        const finalCount = await User.countDocuments();
        expect(finalCount).toBe(initialCount + 1);
      });

      test('user data is stored correctly', async () => {
        const response = await request(app)
          .post('/api/users')
          .send(validUserData)
          .expect(201);

        const storedUser = await User.findById(response.body.id);
        expect(storedUser.name).toBe(validUserData.name);
        expect(storedUser.email).toBe(validUserData.email);
        expect(storedUser.password).toBe(validUserData.password);
      });
    });
  });

  describe('API Integration Workflow Tests', () => {
    test('complete user creation and retrieval workflow', async () => {
      // Create multiple users
      const users = [
        { name: 'User 1', email: 'user1@test.com', password: 'pass1' },
        { name: 'User 2', email: 'user2@test.com', password: 'pass2' }
      ];

      const createdUsers = [];

      for (const userData of users) {
        const response = await request(app)
          .post('/api/users')
          .send(userData)
          .expect(201);

        createdUsers.push(response.body);
      }

      // Retrieve all users
      const getResponse = await request(app)
        .get('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      expect(getResponse.body).toHaveLength(3); // Including beforeEach user

      // Verify created users are in the response
      createdUsers.forEach(createdUser => {
        const foundUser = getResponse.body.find(user => user._id === createdUser.id);
        expect(foundUser).toBeTruthy();
        expect(foundUser.name).toBe(createdUser.name);
        expect(foundUser.email).toBe(createdUser.email);
      });
    });
  });

  describe('Performance Tests', () => {
    test('handles multiple concurrent requests', async () => {
      const requests = [];

      for (let i = 0; i < 10; i++) {
        const userData = {
          name: `User ${i}`,
          email: `user${i}@test.com`,
          password: 'password'
        };

        requests.push(
          request(app)
            .post('/api/users')
            .send(userData)
        );
      }

      const responses = await Promise.all(requests);

      responses.forEach(response => {
        expect(response.status).toBe(201);
      });

      const userCount = await User.countDocuments();
      expect(userCount).toBe(11); // 10 created + 1 from beforeEach
    });

    test('get users endpoint performance', async () => {
      // Create many users for performance test
      const users = [];
      for (let i = 0; i < 100; i++) {
        users.push({
          name: `Performance User ${i}`,
          email: `perf${i}@test.com`,
          password: 'password'
        });
      }

      await User.insertMany(users);

      const startTime = Date.now();

      const response = await request(app)
        .get('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      const duration = Date.now() - startTime;

      expect(response.body).toHaveLength(101); // 100 + 1 from beforeEach
      expect(duration).toBeLessThan(1000); // Should complete within 1 second
    });
  });
});

// Load Testing with Artillery (separate test file)
describe('Users API Load Tests', () => {
  // This would typically be run separately with artillery
  // artillery.yml configuration example:
  /*
  config:
    target: 'http://localhost:3000'
    phases:
      - duration: 60
        arrivalRate: 10
  scenarios:
    - name: 'Create and fetch users'
      flow:
        - post:
            url: '/api/users'
            json:
              name: 'Load Test User'
              email: 'loadtest{{$randomString()}}@test.com'
              password: 'password'
        - get:
            url: '/api/users'
            headers:
              Authorization: 'Bearer {{authToken}}'
  */
});
```

## 🎯 Test Strategy Recommendations

### Testing Pyramid Implementation
1. **70% Unit Tests** - Fast, isolated, comprehensive coverage
2. **20% Integration Tests** - API endpoints, database interactions
3. **10% E2E Tests** - Critical user journeys and workflows

### Coverage Targets
- **Statements**: 90%+
- **Branches**: 85%+
- **Functions**: 95%+
- **Lines**: 90%+

### Test Categories
- **Happy Path**: Normal usage scenarios
- **Edge Cases**: Boundary conditions and unusual inputs
- **Error Handling**: Failure scenarios and recovery
- **Performance**: Load testing and benchmarks
- **Security**: Input validation and vulnerability testing

## 🔧 Framework Integration

### Jest Configuration
```json
{
  "testEnvironment": "node",
  "collectCoverageFrom": [
    "src/**/*.{js,jsx,ts,tsx}",
    "!src/**/*.d.ts"
  ],
  "coverageThreshold": {
    "global": {
      "branches": 85,
      "functions": 95,
      "lines": 90,
      "statements": 90
    }
  }
}
```

### Cypress Configuration
```json
{
  "baseUrl": "http://localhost:3000",
  "viewportWidth": 1280,
  "viewportHeight": 720,
  "defaultCommandTimeout": 10000,
  "requestTimeout": 10000
}
```

---

**Ready to build bulletproof tests? 🧪**

Use `@test-engineer` followed by your code to get comprehensive test suites that catch bugs before they reach production!