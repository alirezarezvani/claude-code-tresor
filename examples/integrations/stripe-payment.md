# Stripe Payment Integration 💳

A comprehensive guide for implementing secure Stripe payment processing using Claude Code Tresor utilities. This integration demonstrates best practices for handling payments, webhooks, and financial data security.

## 📋 Overview

This integration covers the complete Stripe payment implementation from initial setup to production deployment, utilizing Claude Code Tresor's specialized utilities for security, testing, and code quality.

### 🎯 Integration Goals

- **Security First**: PCI DSS compliance and secure payment handling
- **Robust Error Handling**: Comprehensive error scenarios and recovery
- **Webhook Reliability**: Secure and reliable webhook processing
- **Testing Coverage**: Complete test coverage including edge cases
- **Monitoring**: Real-time payment monitoring and alerting

### 🔧 Utilities Used

- **Commands**: `/scaffold`, `/review`, `/test-gen`, `/docs-gen`
- **Agents**: `@security-auditor`, `@code-reviewer`, `@test-engineer`, `@docs-writer`

## 🏗️ Phase 1: Project Setup & Architecture

### Step 1: Initial Project Scaffolding

```bash
/scaffold payment-integration stripe-payments --features webhooks,subscriptions,marketplace --security pci-dss --testing comprehensive --docs api-reference
```

**Generated Structure:**
```
stripe-payments/
├── src/
│   ├── controllers/
│   │   ├── paymentController.js
│   │   ├── subscriptionController.js
│   │   └── webhookController.js
│   ├── services/
│   │   ├── stripeService.js
│   │   ├── paymentProcessor.js
│   │   └── webhookValidator.js
│   ├── models/
│   │   ├── payment.js
│   │   ├── subscription.js
│   │   └── customer.js
│   ├── middleware/
│   │   ├── auth.js
│   │   ├── validation.js
│   │   └── rateLimiting.js
│   └── utils/
│       ├── encryption.js
│       └── logging.js
├── tests/
├── docs/
└── webhooks/
```

### Step 2: Security Architecture Review

```bash
@security-auditor Design security architecture for Stripe payment integration focusing on:
- PCI DSS compliance requirements
- Secure API key management
- Webhook signature verification
- Customer data protection
- Payment tokenization
- Fraud prevention patterns
- Audit logging requirements
- HTTPS/TLS configuration
```

## 💰 Phase 2: Core Payment Implementation

### Step 3: Stripe Service Implementation

```javascript
// src/services/stripeService.js
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const { logger } = require('../utils/logging');
const { encrypt, decrypt } = require('../utils/encryption');

class StripeService {
  constructor() {
    this.stripe = stripe;
  }

  /**
   * Create a payment intent
   * @param {Object} paymentData - Payment information
   * @returns {Promise<Object>} Payment intent
   */
  async createPaymentIntent({
    amount,
    currency = 'usd',
    customerId,
    metadata = {},
    paymentMethodTypes = ['card']
  }) {
    try {
      // Validate amount (minimum $0.50 for USD)
      if (amount < 50) {
        throw new Error('Amount must be at least $0.50 USD');
      }

      const paymentIntent = await this.stripe.paymentIntents.create({
        amount,
        currency,
        customer: customerId,
        metadata: {
          ...metadata,
          created_by: 'api',
          timestamp: new Date().toISOString()
        },
        payment_method_types: paymentMethodTypes,
        capture_method: 'automatic'
      });

      logger.info('Payment intent created', {
        paymentIntentId: paymentIntent.id,
        amount,
        currency,
        customerId
      });

      return {
        id: paymentIntent.id,
        client_secret: paymentIntent.client_secret,
        amount: paymentIntent.amount,
        currency: paymentIntent.currency,
        status: paymentIntent.status
      };
    } catch (error) {
      logger.error('Failed to create payment intent', {
        error: error.message,
        amount,
        currency,
        customerId
      });
      throw this.handleStripeError(error);
    }
  }

  /**
   * Confirm a payment intent
   * @param {string} paymentIntentId - Payment intent ID
   * @param {string} paymentMethodId - Payment method ID
   * @returns {Promise<Object>} Confirmed payment intent
   */
  async confirmPaymentIntent(paymentIntentId, paymentMethodId) {
    try {
      const paymentIntent = await this.stripe.paymentIntents.confirm(
        paymentIntentId,
        {
          payment_method: paymentMethodId,
          return_url: process.env.PAYMENT_RETURN_URL
        }
      );

      logger.info('Payment intent confirmed', {
        paymentIntentId,
        status: paymentIntent.status
      });

      return paymentIntent;
    } catch (error) {
      logger.error('Failed to confirm payment intent', {
        error: error.message,
        paymentIntentId
      });
      throw this.handleStripeError(error);
    }
  }

  /**
   * Create a customer
   * @param {Object} customerData - Customer information
   * @returns {Promise<Object>} Stripe customer
   */
  async createCustomer({ email, name, phone, address }) {
    try {
      const customer = await this.stripe.customers.create({
        email,
        name,
        phone,
        address,
        metadata: {
          created_via: 'api',
          created_at: new Date().toISOString()
        }
      });

      logger.info('Customer created', {
        customerId: customer.id,
        email
      });

      return customer;
    } catch (error) {
      logger.error('Failed to create customer', {
        error: error.message,
        email
      });
      throw this.handleStripeError(error);
    }
  }

  /**
   * Create a subscription
   * @param {Object} subscriptionData - Subscription information
   * @returns {Promise<Object>} Stripe subscription
   */
  async createSubscription({
    customerId,
    priceId,
    paymentMethodId,
    trialPeriodDays = 0
  }) {
    try {
      // Attach payment method to customer
      await this.stripe.paymentMethods.attach(paymentMethodId, {
        customer: customerId
      });

      // Set as default payment method
      await this.stripe.customers.update(customerId, {
        invoice_settings: {
          default_payment_method: paymentMethodId
        }
      });

      const subscription = await this.stripe.subscriptions.create({
        customer: customerId,
        items: [{ price: priceId }],
        trial_period_days: trialPeriodDays,
        expand: ['latest_invoice.payment_intent'],
        metadata: {
          created_via: 'api',
          created_at: new Date().toISOString()
        }
      });

      logger.info('Subscription created', {
        subscriptionId: subscription.id,
        customerId,
        priceId
      });

      return subscription;
    } catch (error) {
      logger.error('Failed to create subscription', {
        error: error.message,
        customerId,
        priceId
      });
      throw this.handleStripeError(error);
    }
  }

  /**
   * Handle Stripe errors with proper error mapping
   * @param {Error} error - Stripe error
   * @returns {Error} Formatted error
   */
  handleStripeError(error) {
    if (error.type === 'StripeCardError') {
      return new Error(`Card error: ${error.message}`);
    } else if (error.type === 'StripeRateLimitError') {
      return new Error('Too many requests. Please try again later.');
    } else if (error.type === 'StripeInvalidRequestError') {
      return new Error(`Invalid request: ${error.message}`);
    } else if (error.type === 'StripeAPIError') {
      return new Error('Payment service temporarily unavailable.');
    } else if (error.type === 'StripeConnectionError') {
      return new Error('Network error. Please check your connection.');
    } else if (error.type === 'StripeAuthenticationError') {
      return new Error('Authentication failed.');
    } else {
      return new Error('An unexpected error occurred.');
    }
  }
}

module.exports = StripeService;
```

### Step 4: Payment Controller Implementation

```javascript
// src/controllers/paymentController.js
const StripeService = require('../services/stripeService');
const Payment = require('../models/payment');
const { validatePaymentRequest } = require('../middleware/validation');
const { logger } = require('../utils/logging');

class PaymentController {
  constructor() {
    this.stripeService = new StripeService();
  }

  /**
   * Create payment intent
   */
  async createPaymentIntent(req, res) {
    try {
      const { amount, currency, customerId, metadata } = req.body;

      // Validate request
      const validation = validatePaymentRequest(req.body);
      if (!validation.isValid) {
        return res.status(400).json({
          error: 'Validation failed',
          details: validation.errors
        });
      }

      // Create payment intent
      const paymentIntent = await this.stripeService.createPaymentIntent({
        amount,
        currency,
        customerId,
        metadata
      });

      // Store payment record
      await Payment.create({
        stripePaymentIntentId: paymentIntent.id,
        amount,
        currency,
        customerId,
        status: 'pending',
        metadata
      });

      res.status(201).json({
        success: true,
        data: paymentIntent
      });
    } catch (error) {
      logger.error('Create payment intent failed', {
        error: error.message,
        userId: req.user?.id
      });

      res.status(500).json({
        error: 'Failed to create payment intent',
        message: error.message
      });
    }
  }

  /**
   * Confirm payment
   */
  async confirmPayment(req, res) {
    try {
      const { paymentIntentId, paymentMethodId } = req.body;

      // Confirm payment with Stripe
      const paymentIntent = await this.stripeService.confirmPaymentIntent(
        paymentIntentId,
        paymentMethodId
      );

      // Update payment record
      await Payment.update(
        {
          status: paymentIntent.status,
          confirmedAt: new Date()
        },
        {
          where: { stripePaymentIntentId: paymentIntentId }
        }
      );

      res.json({
        success: true,
        data: {
          status: paymentIntent.status,
          id: paymentIntent.id
        }
      });
    } catch (error) {
      logger.error('Confirm payment failed', {
        error: error.message,
        paymentIntentId: req.body.paymentIntentId
      });

      res.status(500).json({
        error: 'Failed to confirm payment',
        message: error.message
      });
    }
  }

  /**
   * Get payment status
   */
  async getPaymentStatus(req, res) {
    try {
      const { paymentIntentId } = req.params;

      const payment = await Payment.findOne({
        where: { stripePaymentIntentId: paymentIntentId },
        include: ['customer']
      });

      if (!payment) {
        return res.status(404).json({
          error: 'Payment not found'
        });
      }

      res.json({
        success: true,
        data: {
          id: payment.stripePaymentIntentId,
          status: payment.status,
          amount: payment.amount,
          currency: payment.currency,
          createdAt: payment.createdAt
        }
      });
    } catch (error) {
      logger.error('Get payment status failed', {
        error: error.message,
        paymentIntentId: req.params.paymentIntentId
      });

      res.status(500).json({
        error: 'Failed to get payment status'
      });
    }
  }
}

module.exports = PaymentController;
```

### Step 5: Security Review

```bash
@security-auditor Review the payment implementation for security vulnerabilities:
- API key exposure prevention
- Input validation completeness
- SQL injection protection
- XSS prevention in payment forms
- Rate limiting on payment endpoints
- Audit logging for financial transactions
- Error message sanitization
- HTTPS enforcement
- PCI DSS compliance requirements
```

### Step 6: Code Quality Review

```bash
@code-reviewer Review the payment service and controller for:
- Error handling patterns and consistency
- Async/await usage and error propagation
- Database transaction handling
- Logging implementation quality
- Code organization and maintainability
- TypeScript type safety (if applicable)
- Documentation completeness
- Performance considerations
```

## 🔔 Phase 3: Webhook Implementation

### Step 7: Webhook Handler Implementation

```javascript
// src/controllers/webhookController.js
const crypto = require('crypto');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Payment = require('../models/payment');
const Subscription = require('../models/subscription');
const { logger } = require('../utils/logging');

class WebhookController {
  constructor() {
    this.endpointSecret = process.env.STRIPE_WEBHOOK_SECRET;
  }

  /**
   * Handle Stripe webhooks
   */
  async handleWebhook(req, res) {
    const sig = req.headers['stripe-signature'];
    let event;

    try {
      // Verify webhook signature
      event = stripe.webhooks.constructEvent(
        req.body,
        sig,
        this.endpointSecret
      );

      logger.info('Webhook received', {
        eventType: event.type,
        eventId: event.id
      });
    } catch (error) {
      logger.error('Webhook signature verification failed', {
        error: error.message
      });

      return res.status(400).json({
        error: 'Webhook signature verification failed'
      });
    }

    try {
      // Handle the event
      await this.processWebhookEvent(event);

      res.json({ received: true });
    } catch (error) {
      logger.error('Webhook processing failed', {
        error: error.message,
        eventType: event.type,
        eventId: event.id
      });

      res.status(500).json({
        error: 'Webhook processing failed'
      });
    }
  }

  /**
   * Process webhook events
   * @param {Object} event - Stripe webhook event
   */
  async processWebhookEvent(event) {
    switch (event.type) {
      case 'payment_intent.succeeded':
        await this.handlePaymentSucceeded(event.data.object);
        break;

      case 'payment_intent.payment_failed':
        await this.handlePaymentFailed(event.data.object);
        break;

      case 'invoice.payment_succeeded':
        await this.handleInvoicePaymentSucceeded(event.data.object);
        break;

      case 'customer.subscription.created':
        await this.handleSubscriptionCreated(event.data.object);
        break;

      case 'customer.subscription.updated':
        await this.handleSubscriptionUpdated(event.data.object);
        break;

      case 'customer.subscription.deleted':
        await this.handleSubscriptionDeleted(event.data.object);
        break;

      default:
        logger.info('Unhandled webhook event type', {
          eventType: event.type
        });
    }
  }

  /**
   * Handle successful payment
   * @param {Object} paymentIntent - Stripe payment intent
   */
  async handlePaymentSucceeded(paymentIntent) {
    try {
      await Payment.update(
        {
          status: 'succeeded',
          succeededAt: new Date(),
          stripeChargeId: paymentIntent.charges?.data[0]?.id
        },
        {
          where: { stripePaymentIntentId: paymentIntent.id }
        }
      );

      logger.info('Payment succeeded', {
        paymentIntentId: paymentIntent.id,
        amount: paymentIntent.amount
      });

      // Trigger post-payment actions (email, fulfillment, etc.)
      await this.triggerPostPaymentActions(paymentIntent);
    } catch (error) {
      logger.error('Failed to handle payment success', {
        error: error.message,
        paymentIntentId: paymentIntent.id
      });
      throw error;
    }
  }

  /**
   * Handle failed payment
   * @param {Object} paymentIntent - Stripe payment intent
   */
  async handlePaymentFailed(paymentIntent) {
    try {
      await Payment.update(
        {
          status: 'failed',
          failedAt: new Date(),
          failureReason: paymentIntent.last_payment_error?.message
        },
        {
          where: { stripePaymentIntentId: paymentIntent.id }
        }
      );

      logger.warn('Payment failed', {
        paymentIntentId: paymentIntent.id,
        reason: paymentIntent.last_payment_error?.message
      });

      // Trigger failure notifications
      await this.triggerPaymentFailureActions(paymentIntent);
    } catch (error) {
      logger.error('Failed to handle payment failure', {
        error: error.message,
        paymentIntentId: paymentIntent.id
      });
      throw error;
    }
  }

  /**
   * Trigger actions after successful payment
   * @param {Object} paymentIntent - Stripe payment intent
   */
  async triggerPostPaymentActions(paymentIntent) {
    // Send confirmation email
    // Update inventory
    // Trigger fulfillment
    // Update analytics

    logger.info('Post-payment actions triggered', {
      paymentIntentId: paymentIntent.id
    });
  }

  /**
   * Trigger actions after payment failure
   * @param {Object} paymentIntent - Stripe payment intent
   */
  async triggerPaymentFailureActions(paymentIntent) {
    // Send failure notification
    // Log for fraud analysis
    // Update analytics

    logger.info('Payment failure actions triggered', {
      paymentIntentId: paymentIntent.id
    });
  }
}

module.exports = WebhookController;
```

## 🧪 Phase 4: Testing Implementation

### Step 8: Comprehensive Test Generation

```bash
/test-gen --file src/services/stripeService.js --framework jest --type unit,integration --coverage 95 --scenarios happy-path,edge-cases,error-conditions,security

/test-gen --file src/controllers/webhookController.js --framework jest --type unit,integration --scenarios webhook-verification,event-processing,error-handling

/test-gen --api-endpoints /payments/intent,/payments/confirm,/webhooks/stripe --framework supertest --type api --include-auth --security-testing
```

### Step 9: Generated Test Examples

```javascript
// tests/services/stripeService.test.js
const StripeService = require('../../src/services/stripeService');
const stripe = require('stripe');

// Mock Stripe
jest.mock('stripe');

describe('StripeService', () => {
  let stripeService;
  let mockStripe;

  beforeEach(() => {
    mockStripe = {
      paymentIntents: {
        create: jest.fn(),
        confirm: jest.fn()
      },
      customers: {
        create: jest.fn(),
        update: jest.fn()
      },
      subscriptions: {
        create: jest.fn()
      },
      paymentMethods: {
        attach: jest.fn()
      }
    };

    stripe.mockReturnValue(mockStripe);
    stripeService = new StripeService();
  });

  describe('createPaymentIntent', () => {
    it('should create payment intent successfully', async () => {
      const mockPaymentIntent = {
        id: 'pi_test123',
        client_secret: 'pi_test123_secret',
        amount: 2000,
        currency: 'usd',
        status: 'requires_payment_method'
      };

      mockStripe.paymentIntents.create.mockResolvedValue(mockPaymentIntent);

      const result = await stripeService.createPaymentIntent({
        amount: 2000,
        currency: 'usd',
        customerId: 'cus_test123'
      });

      expect(result).toEqual({
        id: 'pi_test123',
        client_secret: 'pi_test123_secret',
        amount: 2000,
        currency: 'usd',
        status: 'requires_payment_method'
      });

      expect(mockStripe.paymentIntents.create).toHaveBeenCalledWith({
        amount: 2000,
        currency: 'usd',
        customer: 'cus_test123',
        metadata: expect.objectContaining({
          created_by: 'api',
          timestamp: expect.any(String)
        }),
        payment_method_types: ['card'],
        capture_method: 'automatic'
      });
    });

    it('should reject amounts below minimum', async () => {
      await expect(
        stripeService.createPaymentIntent({
          amount: 25, // Below $0.50 minimum
          currency: 'usd'
        })
      ).rejects.toThrow('Amount must be at least $0.50 USD');
    });

    it('should handle Stripe card errors', async () => {
      const stripeError = new Error('Your card was declined.');
      stripeError.type = 'StripeCardError';

      mockStripe.paymentIntents.create.mockRejectedValue(stripeError);

      await expect(
        stripeService.createPaymentIntent({
          amount: 2000,
          currency: 'usd'
        })
      ).rejects.toThrow('Card error: Your card was declined.');
    });

    it('should handle rate limiting errors', async () => {
      const stripeError = new Error('Too many requests');
      stripeError.type = 'StripeRateLimitError';

      mockStripe.paymentIntents.create.mockRejectedValue(stripeError);

      await expect(
        stripeService.createPaymentIntent({
          amount: 2000,
          currency: 'usd'
        })
      ).rejects.toThrow('Too many requests. Please try again later.');
    });
  });

  describe('confirmPaymentIntent', () => {
    it('should confirm payment intent successfully', async () => {
      const mockConfirmedPayment = {
        id: 'pi_test123',
        status: 'succeeded'
      };

      mockStripe.paymentIntents.confirm.mockResolvedValue(mockConfirmedPayment);

      const result = await stripeService.confirmPaymentIntent(
        'pi_test123',
        'pm_test456'
      );

      expect(result).toEqual(mockConfirmedPayment);
      expect(mockStripe.paymentIntents.confirm).toHaveBeenCalledWith(
        'pi_test123',
        {
          payment_method: 'pm_test456',
          return_url: process.env.PAYMENT_RETURN_URL
        }
      );
    });
  });
});

// tests/controllers/webhookController.test.js
const request = require('supertest');
const express = require('express');
const crypto = require('crypto');
const WebhookController = require('../../src/controllers/webhookController');

describe('WebhookController', () => {
  let app;
  let webhookController;

  beforeEach(() => {
    app = express();
    app.use(express.raw({ type: 'application/json' }));

    webhookController = new WebhookController();
    app.post('/webhook', (req, res) => webhookController.handleWebhook(req, res));
  });

  describe('webhook signature verification', () => {
    it('should verify valid webhook signature', async () => {
      const payload = JSON.stringify({
        type: 'payment_intent.succeeded',
        data: { object: { id: 'pi_test123' } }
      });

      const signature = crypto
        .createHmac('sha256', process.env.STRIPE_WEBHOOK_SECRET)
        .update(payload)
        .digest('hex');

      const response = await request(app)
        .post('/webhook')
        .set('stripe-signature', `t=${Date.now()},v1=${signature}`)
        .send(payload)
        .expect(200);

      expect(response.body).toEqual({ received: true });
    });

    it('should reject invalid webhook signature', async () => {
      const payload = JSON.stringify({
        type: 'payment_intent.succeeded',
        data: { object: { id: 'pi_test123' } }
      });

      const response = await request(app)
        .post('/webhook')
        .set('stripe-signature', 'invalid_signature')
        .send(payload)
        .expect(400);

      expect(response.body).toEqual({
        error: 'Webhook signature verification failed'
      });
    });
  });
});
```

### Step 10: Test Engineering Review

```bash
@test-engineer Review and enhance the payment integration tests:
- Add edge cases for webhook processing
- Include tests for concurrent payment scenarios
- Add security tests for injection attacks
- Include load testing for high payment volume
- Test webhook retry mechanisms
- Add integration tests with real Stripe test mode
- Include tests for subscription lifecycle
- Add chaos engineering tests for payment failures
```

## 📚 Phase 5: Documentation & Deployment

### Step 11: API Documentation Generation

```bash
/docs-gen api --format openapi --output docs/stripe-api.yml --include-examples --auth-flows --error-codes

@docs-writer Create comprehensive payment integration documentation including:
- Quick start guide for developers
- Stripe webhook setup instructions
- Payment flow diagrams
- Error handling guide
- Security best practices
- Testing guide with Stripe test cards
- Troubleshooting common issues
- PCI compliance requirements
```

### Step 12: Environment Configuration

```javascript
// config/stripe.js
module.exports = {
  development: {
    publishableKey: process.env.STRIPE_PUBLISHABLE_KEY_DEV,
    secretKey: process.env.STRIPE_SECRET_KEY_DEV,
    webhookSecret: process.env.STRIPE_WEBHOOK_SECRET_DEV,
    apiVersion: '2023-10-16'
  },
  test: {
    publishableKey: process.env.STRIPE_PUBLISHABLE_KEY_TEST,
    secretKey: process.env.STRIPE_SECRET_KEY_TEST,
    webhookSecret: process.env.STRIPE_WEBHOOK_SECRET_TEST,
    apiVersion: '2023-10-16'
  },
  production: {
    publishableKey: process.env.STRIPE_PUBLISHABLE_KEY_PROD,
    secretKey: process.env.STRIPE_SECRET_KEY_PROD,
    webhookSecret: process.env.STRIPE_WEBHOOK_SECRET_PROD,
    apiVersion: '2023-10-16'
  }
};
```

### Step 13: Final Security Audit

```bash
@security-auditor Perform comprehensive security audit of Stripe integration:
- Environment variable security
- API key rotation procedures
- Webhook endpoint security
- Payment data encryption
- Audit logging completeness
- Rate limiting effectiveness
- Error message sanitization
- Production security hardening
- PCI DSS compliance verification
```

## 🔄 Phase 6: Advanced Features

### Step 14: Subscription Management

```javascript
// src/services/subscriptionService.js
class SubscriptionService extends StripeService {
  /**
   * Create subscription with trial
   */
  async createSubscriptionWithTrial(customerId, priceId, trialDays = 14) {
    try {
      const subscription = await this.stripe.subscriptions.create({
        customer: customerId,
        items: [{ price: priceId }],
        trial_period_days: trialDays,
        payment_behavior: 'default_incomplete',
        payment_settings: { save_default_payment_method: 'on_subscription' },
        expand: ['latest_invoice.payment_intent']
      });

      await this.notifySubscriptionCreated(subscription);

      return subscription;
    } catch (error) {
      logger.error('Subscription creation failed', { error: error.message });
      throw this.handleStripeError(error);
    }
  }

  /**
   * Handle subscription lifecycle events
   */
  async handleSubscriptionUpdated(subscription) {
    const { id, status, current_period_end, customer } = subscription;

    await Subscription.update(
      {
        status,
        currentPeriodEnd: new Date(current_period_end * 1000),
        updatedAt: new Date()
      },
      { where: { stripeSubscriptionId: id } }
    );

    // Handle status-specific logic
    switch (status) {
      case 'active':
        await this.activateSubscriptionFeatures(customer, subscription);
        break;
      case 'past_due':
        await this.handlePastDueSubscription(customer, subscription);
        break;
      case 'canceled':
        await this.deactivateSubscriptionFeatures(customer, subscription);
        break;
    }
  }
}
```

### Step 15: Fraud Prevention

```javascript
// src/middleware/fraudPrevention.js
class FraudPrevention {
  /**
   * Check for suspicious payment patterns
   */
  async checkSuspiciousActivity(req, res, next) {
    const { amount, customerId } = req.body;
    const clientIP = req.ip;

    try {
      // Check for unusual payment amounts
      if (amount > 10000000) { // $100,000
        await this.flagForReview(customerId, 'high_amount', { amount });
      }

      // Check for rapid successive payments
      const recentPayments = await this.getRecentPayments(customerId, 3600); // 1 hour
      if (recentPayments.length > 5) {
        await this.flagForReview(customerId, 'rapid_payments', { count: recentPayments.length });
      }

      // Check IP reputation
      const ipRisk = await this.checkIPReputation(clientIP);
      if (ipRisk === 'high') {
        await this.flagForReview(customerId, 'suspicious_ip', { ip: clientIP });
      }

      next();
    } catch (error) {
      logger.error('Fraud check failed', { error: error.message });
      next(error);
    }
  }

  async flagForReview(customerId, reason, metadata) {
    // Log suspicious activity
    logger.warn('Suspicious payment activity detected', {
      customerId,
      reason,
      metadata
    });

    // Store in fraud detection database
    // Trigger manual review workflow
    // Send alert to fraud team
  }
}
```

## 📊 Monitoring & Analytics

### Step 16: Payment Monitoring

```javascript
// src/services/paymentMonitoring.js
class PaymentMonitoring {
  /**
   * Track payment metrics
   */
  async trackPaymentMetrics(payment) {
    const metrics = {
      totalAmount: payment.amount,
      currency: payment.currency,
      status: payment.status,
      processingTime: payment.processingTime,
      paymentMethod: payment.paymentMethod,
      timestamp: new Date()
    };

    // Send to analytics service
    await this.sendToAnalytics('payment_processed', metrics);

    // Update real-time dashboard
    await this.updateDashboard(metrics);

    // Check for anomalies
    await this.checkForAnomalies(metrics);
  }

  /**
   * Generate payment reports
   */
  async generateDailyReport() {
    const today = new Date();
    const payments = await Payment.findAll({
      where: {
        createdAt: {
          [Op.gte]: startOfDay(today),
          [Op.lte]: endOfDay(today)
        }
      }
    });

    const report = {
      date: today.toISOString().split('T')[0],
      totalTransactions: payments.length,
      totalAmount: payments.reduce((sum, p) => sum + p.amount, 0),
      successRate: (payments.filter(p => p.status === 'succeeded').length / payments.length) * 100,
      averageAmount: payments.reduce((sum, p) => sum + p.amount, 0) / payments.length
    };

    return report;
  }
}
```

## 🎯 Best Practices Implemented

### Security
- **PCI DSS Compliance**: Never store card data, use Stripe tokenization
- **Webhook Verification**: Always verify webhook signatures
- **API Key Security**: Secure key storage and rotation
- **Audit Logging**: Comprehensive payment audit trails

### Error Handling
- **Graceful Degradation**: Handle Stripe service outages
- **Retry Logic**: Implement exponential backoff for retries
- **User-Friendly Messages**: Clear error messages for users
- **Monitoring**: Real-time error tracking and alerting

### Performance
- **Async Processing**: Non-blocking webhook processing
- **Caching**: Cache customer and product data
- **Database Optimization**: Indexed payment queries
- **Connection Pooling**: Efficient database connections

### Testing
- **Unit Testing**: 95%+ code coverage
- **Integration Testing**: Test with Stripe test mode
- **Load Testing**: Handle high payment volumes
- **Security Testing**: Vulnerability assessments

## 📈 Success Metrics

### Payment Performance
- **Success Rate**: >99% payment success rate
- **Processing Time**: <2 seconds average processing
- **Uptime**: 99.9% payment system availability
- **Error Rate**: <0.1% payment errors

### Security Metrics
- **Zero Breaches**: No security incidents
- **PCI Compliance**: 100% compliance score
- **Fraud Detection**: >95% fraud prevention rate
- **Audit Trail**: 100% payment audit coverage

This comprehensive Stripe payment integration demonstrates how Claude Code Tresor utilities ensure secure, reliable, and maintainable payment processing systems.