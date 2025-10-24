# CSS Style Guide 🎨

A comprehensive CSS coding standard for modern web development with best practices for maintainability, performance, and scalability.

## 📋 Table of Contents

- [Formatting and Syntax](#formatting-and-syntax)
- [Naming Conventions](#naming-conventions)
- [Architecture and Organization](#architecture-and-organization)
- [Responsive Design](#responsive-design)
- [Performance Optimization](#performance-optimization)
- [Modern CSS Features](#modern-css-features)

## 📐 Formatting and Syntax

### Basic Formatting
```css
/* ✅ Good: Consistent formatting */
.user-card {
  display: flex;
  flex-direction: column;
  padding: 1rem;
  margin-bottom: 1rem;
  background-color: #ffffff;
  border: 1px solid #e1e5e9;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: box-shadow 0.2s ease-in-out;
}

.user-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.user-card__header {
  display: flex;
  align-items: center;
  margin-bottom: 0.75rem;
}

.user-card__avatar {
  width: 3rem;
  height: 3rem;
  margin-right: 1rem;
  border-radius: 50%;
  object-fit: cover;
}

.user-card__info {
  flex: 1;
}

.user-card__name {
  margin: 0 0 0.25rem 0;
  font-size: 1.125rem;
  font-weight: 600;
  color: #1a202c;
}

.user-card__role {
  margin: 0;
  font-size: 0.875rem;
  color: #718096;
  text-transform: capitalize;
}

/* ❌ Bad: Inconsistent formatting */
.user-card{display:flex;padding:16px;margin-bottom:16px;background:#fff;border:1px solid #ccc;}
.user-card:hover{box-shadow:0 4px 8px rgba(0,0,0,.15);}
```

### Property Organization
```css
/* ✅ Good: Logical property order */
.component {
  /* Positioning */
  position: relative;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 10;

  /* Display & Box Model */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: auto;
  padding: 1rem;
  margin: 0 auto;
  overflow: hidden;

  /* Border */
  border: 1px solid #e1e5e9;
  border-radius: 0.5rem;

  /* Background */
  background-color: #ffffff;
  background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

  /* Typography */
  font-family: 'Inter', sans-serif;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #2d3748;
  text-align: center;

  /* Visual Effects */
  opacity: 1;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transform: translateY(0);

  /* Animation */
  transition: all 0.2s ease-in-out;
}
```

### Selectors and Specificity
```css
/* ✅ Good: Low specificity, reusable classes */
.btn {
  display: inline-flex;
  align-items: center;
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  font-weight: 500;
  text-decoration: none;
  border: 1px solid transparent;
  border-radius: 0.375rem;
  cursor: pointer;
  transition: all 0.15s ease-in-out;
}

.btn--primary {
  color: #ffffff;
  background-color: #3182ce;
  border-color: #3182ce;
}

.btn--primary:hover {
  background-color: #2c5aa0;
  border-color: #2c5aa0;
}

.btn--secondary {
  color: #4a5568;
  background-color: #ffffff;
  border-color: #e2e8f0;
}

.btn--large {
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
}

.btn--small {
  padding: 0.25rem 0.75rem;
  font-size: 0.75rem;
}

/* ❌ Bad: High specificity, hard to override */
div.sidebar ul.navigation li.nav-item a.nav-link.active {
  color: #3182ce;
}
```

## 🏷️ Naming Conventions

### BEM Methodology
```css
/* ✅ Good: BEM naming convention */
/* Block */
.search-form {
  display: flex;
  padding: 1rem;
  background-color: #f7fafc;
  border-radius: 0.5rem;
}

/* Elements */
.search-form__input {
  flex: 1;
  padding: 0.5rem;
  border: 1px solid #e2e8f0;
  border-radius: 0.25rem;
  margin-right: 0.5rem;
}

.search-form__button {
  padding: 0.5rem 1rem;
  background-color: #3182ce;
  color: #ffffff;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
}

/* Modifiers */
.search-form--compact {
  padding: 0.5rem;
}

.search-form__input--error {
  border-color: #e53e3e;
  background-color: #fed7d7;
}

.search-form__button--disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* State classes */
.search-form.is-loading .search-form__button {
  opacity: 0.7;
}

.search-form.is-loading .search-form__button::after {
  content: '';
  display: inline-block;
  width: 1rem;
  height: 1rem;
  margin-left: 0.5rem;
  border: 2px solid transparent;
  border-top: 2px solid currentColor;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
```

### Utility Classes
```css
/* ✅ Good: Atomic utility classes */
/* Spacing */
.m-0 { margin: 0; }
.m-1 { margin: 0.25rem; }
.m-2 { margin: 0.5rem; }
.m-3 { margin: 0.75rem; }
.m-4 { margin: 1rem; }

.mt-0 { margin-top: 0; }
.mt-1 { margin-top: 0.25rem; }
.mt-2 { margin-top: 0.5rem; }

.p-0 { padding: 0; }
.p-1 { padding: 0.25rem; }
.p-2 { padding: 0.5rem; }

/* Display */
.d-none { display: none; }
.d-block { display: block; }
.d-flex { display: flex; }
.d-grid { display: grid; }

/* Flexbox */
.flex-row { flex-direction: row; }
.flex-col { flex-direction: column; }
.justify-start { justify-content: flex-start; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }
.items-start { align-items: flex-start; }
.items-center { align-items: center; }

/* Text */
.text-left { text-align: left; }
.text-center { text-align: center; }
.text-right { text-align: right; }

.text-xs { font-size: 0.75rem; }
.text-sm { font-size: 0.875rem; }
.text-base { font-size: 1rem; }
.text-lg { font-size: 1.125rem; }
.text-xl { font-size: 1.25rem; }

.font-normal { font-weight: 400; }
.font-medium { font-weight: 500; }
.font-semibold { font-weight: 600; }
.font-bold { font-weight: 700; }

/* Colors */
.text-gray-500 { color: #718096; }
.text-gray-700 { color: #4a5568; }
.text-gray-900 { color: #1a202c; }
.text-blue-500 { color: #3182ce; }
.text-red-500 { color: #e53e3e; }

.bg-white { background-color: #ffffff; }
.bg-gray-50 { background-color: #f7fafc; }
.bg-gray-100 { background-color: #edf2f7; }
.bg-blue-500 { background-color: #3182ce; }

/* Borders */
.border { border: 1px solid #e2e8f0; }
.border-t { border-top: 1px solid #e2e8f0; }
.border-gray-200 { border-color: #e2e8f0; }
.border-gray-300 { border-color: #cbd5e0; }

.rounded { border-radius: 0.25rem; }
.rounded-md { border-radius: 0.375rem; }
.rounded-lg { border-radius: 0.5rem; }
.rounded-full { border-radius: 9999px; }
```

## 🏗️ Architecture and Organization

### File Structure
```
styles/
├── abstracts/
│   ├── _variables.scss
│   ├── _functions.scss
│   ├── _mixins.scss
│   └── _placeholders.scss
├── base/
│   ├── _reset.scss
│   ├── _typography.scss
│   └── _base.scss
├── components/
│   ├── _buttons.scss
│   ├── _forms.scss
│   ├── _cards.scss
│   └── _navigation.scss
├── layout/
│   ├── _header.scss
│   ├── _footer.scss
│   ├── _sidebar.scss
│   └── _grid.scss
├── pages/
│   ├── _home.scss
│   ├── _dashboard.scss
│   └── _profile.scss
├── themes/
│   ├── _light.scss
│   └── _dark.scss
├── utilities/
│   ├── _spacing.scss
│   ├── _typography.scss
│   └── _colors.scss
└── main.scss
```

### CSS Variables (Custom Properties)
```css
/* ✅ Good: CSS custom properties for theming */
:root {
  /* Color palette */
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;
  --color-primary-600: #2563eb;
  --color-primary-700: #1d4ed8;

  --color-gray-50: #f9fafb;
  --color-gray-100: #f3f4f6;
  --color-gray-500: #6b7280;
  --color-gray-700: #374151;
  --color-gray-900: #111827;

  --color-success: #10b981;
  --color-warning: #f59e0b;
  --color-error: #ef4444;

  /* Typography */
  --font-family-sans: 'Inter', ui-sans-serif, system-ui, sans-serif;
  --font-family-mono: 'JetBrains Mono', ui-monospace, 'Courier New', monospace;

  --font-size-xs: 0.75rem;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;

  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;

  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;

  /* Spacing */
  --spacing-0: 0;
  --spacing-1: 0.25rem;
  --spacing-2: 0.5rem;
  --spacing-3: 0.75rem;
  --spacing-4: 1rem;
  --spacing-6: 1.5rem;
  --spacing-8: 2rem;
  --spacing-12: 3rem;
  --spacing-16: 4rem;

  /* Border radius */
  --radius-sm: 0.125rem;
  --radius-base: 0.25rem;
  --radius-md: 0.375rem;
  --radius-lg: 0.5rem;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-base: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);

  /* Transitions */
  --transition-fast: 0.15s ease-in-out;
  --transition-base: 0.2s ease-in-out;
  --transition-slow: 0.3s ease-in-out;

  /* Z-index scale */
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-modal-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}

/* Dark theme */
[data-theme="dark"] {
  --color-primary-50: #1e3a8a;
  --color-primary-500: #60a5fa;

  --color-gray-50: #1f2937;
  --color-gray-100: #374151;
  --color-gray-500: #9ca3af;
  --color-gray-700: #d1d5db;
  --color-gray-900: #f9fafb;
}

/* Usage */
.button {
  padding: var(--spacing-3) var(--spacing-6);
  font-family: var(--font-family-sans);
  font-size: var(--font-size-base);
  font-weight: var(--font-weight-medium);
  color: white;
  background-color: var(--color-primary-500);
  border: none;
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-base);
  transition: all var(--transition-base);
}

.button:hover {
  background-color: var(--color-primary-600);
  box-shadow: var(--shadow-lg);
}
```

### SCSS Mixins and Functions
```scss
// ✅ Good: Reusable mixins
@mixin button-variant($color, $bg-color, $border-color) {
  color: $color;
  background-color: $bg-color;
  border-color: $border-color;

  &:hover,
  &:focus {
    color: $color;
    background-color: darken($bg-color, 7.5%);
    border-color: darken($border-color, 10%);
  }

  &:active {
    background-color: darken($bg-color, 15%);
    border-color: darken($border-color, 20%);
  }
}

@mixin button-size($padding-y, $padding-x, $font-size, $border-radius) {
  padding: $padding-y $padding-x;
  font-size: $font-size;
  border-radius: $border-radius;
}

@mixin visually-hidden {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  padding: 0 !important;
  margin: -1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
  white-space: nowrap !important;
  border: 0 !important;
}

@mixin clearfix {
  &::after {
    content: '';
    display: block;
    clear: both;
  }
}

// Media query mixins
@mixin media-up($breakpoint) {
  @media (min-width: map-get($breakpoints, $breakpoint)) {
    @content;
  }
}

@mixin media-down($breakpoint) {
  @media (max-width: map-get($breakpoints, $breakpoint) - 1px) {
    @content;
  }
}

// Usage
.btn {
  @include button-size(0.5rem, 1rem, 0.875rem, 0.375rem);
  @include button-variant(#ffffff, #3182ce, #3182ce);

  &--large {
    @include button-size(0.75rem, 1.5rem, 1rem, 0.5rem);
  }

  &--small {
    @include button-size(0.25rem, 0.75rem, 0.75rem, 0.25rem);
  }
}
```

## 📱 Responsive Design

### Mobile-First Approach
```css
/* ✅ Good: Mobile-first responsive design */
.grid {
  display: grid;
  gap: 1rem;
  padding: 1rem;
}

/* Mobile (default) */
.grid {
  grid-template-columns: 1fr;
}

/* Tablet */
@media (min-width: 768px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    padding: 1.5rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    padding: 2rem;
  }
}

/* Large desktop */
@media (min-width: 1280px) {
  .grid {
    grid-template-columns: repeat(4, 1fr);
    max-width: 1200px;
    margin: 0 auto;
  }
}

/* Container queries for component-based responsive design */
.card-grid {
  container-type: inline-size;
  display: grid;
  gap: 1rem;
}

@container (min-width: 400px) {
  .card-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@container (min-width: 600px) {
  .card-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

### Fluid Typography
```css
/* ✅ Good: Fluid typography with clamp() */
.heading {
  font-size: clamp(1.5rem, 4vw, 3rem);
  line-height: 1.2;
}

.body-text {
  font-size: clamp(0.875rem, 2vw, 1.125rem);
  line-height: 1.6;
}

/* Fluid spacing */
.section {
  padding: clamp(2rem, 8vw, 6rem) clamp(1rem, 4vw, 2rem);
}

/* ✅ Good: Responsive utility classes */
@media (min-width: 768px) {
  .md\:text-left { text-align: left; }
  .md\:text-center { text-align: center; }
  .md\:flex { display: flex; }
  .md\:hidden { display: none; }
  .md\:block { display: block; }

  .md\:w-1\/2 { width: 50%; }
  .md\:w-1\/3 { width: 33.333333%; }
  .md\:w-2\/3 { width: 66.666667%; }
}

@media (min-width: 1024px) {
  .lg\:text-left { text-align: left; }
  .lg\:grid-cols-3 { grid-template-columns: repeat(3, 1fr); }
  .lg\:px-8 { padding-left: 2rem; padding-right: 2rem; }
}
```

## ⚡ Performance Optimization

### Efficient Selectors
```css
/* ✅ Good: Efficient selectors */
.nav-item { }
.nav-item.is-active { }
.btn--primary { }

/* ❌ Bad: Inefficient selectors */
* { } /* Universal selector */
.nav ul li a { } /* Descendant selectors */
#sidebar .nav ul li a:hover { } /* Complex nested selectors */
[class^="nav-"] { } /* Attribute selectors with wildcards */
```

### CSS Loading Strategy
```css
/* ✅ Good: Critical CSS inline */
/* Inline critical styles for above-the-fold content */
.header,
.hero,
.navigation {
  /* Critical styles here */
}

/* ✅ Good: Non-critical CSS */
/* Load non-critical styles asynchronously */
```

```html
<!-- Critical CSS inline -->
<style>
  .header { /* critical styles */ }
  .hero { /* critical styles */ }
</style>

<!-- Non-critical CSS -->
<link rel="preload" href="styles.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="styles.css"></noscript>
```

### CSS Containment
```css
/* ✅ Good: CSS containment for performance */
.card {
  contain: layout style paint;
}

.sidebar {
  contain: layout;
}

.animation-container {
  contain: layout style paint;
  will-change: transform;
}

.animation-container.animating {
  transform: translateX(100px);
}

.animation-container:not(.animating) {
  will-change: auto;
}
```

## 🚀 Modern CSS Features

### CSS Grid Layouts
```css
/* ✅ Good: CSS Grid for complex layouts */
.dashboard {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main aside"
    "footer footer footer";
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 250px 1fr 300px;
  min-height: 100vh;
  gap: 1rem;
}

.dashboard__header {
  grid-area: header;
  background-color: var(--color-gray-100);
  padding: 1rem;
}

.dashboard__sidebar {
  grid-area: sidebar;
  background-color: var(--color-gray-50);
  padding: 1rem;
}

.dashboard__main {
  grid-area: main;
  padding: 1rem;
}

.dashboard__aside {
  grid-area: aside;
  background-color: var(--color-gray-50);
  padding: 1rem;
}

.dashboard__footer {
  grid-area: footer;
  background-color: var(--color-gray-100);
  padding: 1rem;
}

/* Responsive grid */
@media (max-width: 768px) {
  .dashboard {
    grid-template-areas:
      "header"
      "main"
      "sidebar"
      "aside"
      "footer";
    grid-template-columns: 1fr;
  }
}

/* CSS Subgrid */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1rem;
}

.card {
  display: grid;
  grid-template-rows: subgrid;
  grid-row: span 3;
}
```

### CSS Logical Properties
```css
/* ✅ Good: Logical properties for internationalization */
.content {
  margin-inline-start: 1rem;
  margin-inline-end: 1rem;
  padding-block-start: 2rem;
  padding-block-end: 2rem;
  border-inline-start: 1px solid var(--color-gray-300);
}

.text {
  text-align: start; /* Instead of left */
}

.floating-element {
  float: inline-start; /* Instead of left */
}
```

### Modern Animations
```css
/* ✅ Good: Hardware-accelerated animations */
@keyframes slideIn {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(1rem);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.slide-in {
  animation: slideIn 0.3s ease-out forwards;
}

.fade-in {
  animation: fadeIn 0.5s ease-out forwards;
}

/* Reduced motion support */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}

/* View transitions */
@view-transition {
  navigation: auto;
}

.page-transition {
  view-transition-name: page-content;
}
```

### CSS Nesting
```css
/* ✅ Good: CSS nesting (where supported) */
.card {
  padding: 1rem;
  border: 1px solid var(--color-gray-300);
  border-radius: var(--radius-lg);

  & .card__header {
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid var(--color-gray-200);
  }

  & .card__title {
    margin: 0;
    font-size: var(--font-size-lg);
    font-weight: var(--font-weight-semibold);
  }

  & .card__content {
    color: var(--color-gray-700);
    line-height: var(--line-height-relaxed);
  }

  &:hover {
    box-shadow: var(--shadow-lg);
  }

  &.card--featured {
    border-color: var(--color-primary-500);
    background-color: var(--color-primary-50);
  }
}
```

## 🧪 Testing and Quality Assurance

### CSS Testing
```css
/* ✅ Good: Test utility classes */
.test-border {
  border: 2px solid red !important;
}

.test-bg {
  background-color: yellow !important;
}

.test-outline {
  outline: 2px solid blue !important;
}

/* Debug styles for development */
.debug * {
  outline: 1px solid red;
}

.debug *:nth-child(2n) {
  outline-color: green;
}

.debug *:nth-child(3n) {
  outline-color: orange;
}
```

## 🎯 Quick Reference Checklist

### Before Committing
- [ ] CSS is formatted consistently
- [ ] Class names follow BEM convention
- [ ] No unused CSS rules
- [ ] CSS variables used for theming
- [ ] Mobile-first responsive design
- [ ] Performance optimizations applied
- [ ] Accessibility considerations included

### Code Review Checklist
- [ ] Selectors have low specificity
- [ ] No inline styles in HTML
- [ ] Animations respect reduced motion preferences
- [ ] Color contrast meets WCAG standards
- [ ] Focus states are visible
- [ ] CSS is organized logically
- [ ] Modern CSS features used appropriately

This CSS style guide ensures maintainable, performant, and accessible styles for modern web applications.