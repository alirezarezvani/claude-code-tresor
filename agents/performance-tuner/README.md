# Performance Tuner Agent ⚡

Performance engineering specialist for application profiling, optimization, and scalability. Data-driven performance improvements and systematic bottleneck elimination.

## 🎯 Overview

The **@performance-tuner** agent provides expert performance optimization based on profiling data and metrics. From micro-optimizations to architectural improvements, this agent helps you build fast, scalable applications.

## ✨ Working with Skills (NEW!)

While no skill handles performance tuning, this agent benefits from skills maintaining code quality:

**Skills Maintain Quality (Autonomous):**
- code-reviewer skill flags obvious inefficiencies (N+1 queries, nested loops)
- security-auditor skill detects expensive operations (crypto without caching)
- test-generator skill enables performance regression testing

**This Agent (Expert):**
- System-level profiling and bottleneck analysis
- Database query optimization and indexing strategy
- Caching architecture and implementation
- Load testing and capacity planning

**Complementary Approach:** Skills prevent obvious performance anti-patterns during development. When performance issues arise or optimization is needed, this agent provides data-driven profiling, systematic bottleneck elimination, and scalability improvements.

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Performance Profiling
- **CPU profiling** - Identify hot code paths and optimization opportunities
- **Memory profiling** - Detect leaks and optimize allocations
- **I/O profiling** - Analyze file system and network performance
- **Database profiling** - Query execution plans and index usage
- **Frontend profiling** - Rendering, bundle size, loading performance

### Optimization Strategies
- **Algorithmic optimization** - Better algorithms and data structures
- **Database optimization** - Query tuning, indexing, connection pooling
- **Caching strategies** - Redis, CDN, browser caching, memoization
- **Asynchronous patterns** - Non-blocking I/O, parallel processing
- **Resource optimization** - Memory, CPU, network bandwidth

### Scalability Engineering
- **Horizontal scaling** - Load balancing, stateless design
- **Vertical scaling** - Resource allocation, capacity planning
- **Database scaling** - Replication, sharding, read replicas
- **Caching layers** - Multi-tier caching strategies
- **CDN integration** - Static asset delivery optimization

## 🛠️ Usage Examples

### Slow API Response

```bash
@performance-tuner Optimize this endpoint - response time is 3-5 seconds

GET /api/users/:id/posts

Current implementation:
async function getUserPosts(userId) {
  const user = await User.findById(userId);
  const posts = await Post.find({ userId });

  for (const post of posts) {
    post.comments = await Comment.find({ postId: post.id });
    post.author = await User.findById(post.authorId);
  }

  return posts;
}
```

**Agent Response:**
```markdown
## Performance Analysis ⚡

### Current Performance
- Response time: 3-5 seconds
- Database queries: 1 + 1 + (N × 2) = **2 + 2N queries**
- For 50 posts: **102 database queries**

### Identified Issues

#### 🔴 Critical: N+1 Query Problem
**Issue**: Fetching comments and authors in a loop
- Each post triggers 2 additional queries
- 50 posts = 100 extra queries
- Database round-trip overhead compounds

#### 🟡 Missing Indexes
**Issue**: Full table scans likely occurring
- `posts.userId` needs index
- `comments.postId` needs index

#### 🟡 No Caching
**Issue**: Same data fetched repeatedly
- User data not cached
- Post data not cached

### Optimized Solution

```javascript
async function getUserPosts(userId) {
  // Single query with JOINs
  const posts = await Post.find({ userId })
    .populate('author')              // Eager load authors
    .populate('comments')            // Eager load comments
    .lean()                          // Return plain objects (faster)
    .cache(300);                     // Cache for 5 minutes

  return posts;
}
```

### Alternative: Optimized Multi-Query

```javascript
async function getUserPosts(userId) {
  // Fetch posts
  const posts = await Post.find({ userId }).lean();

  if (posts.length === 0) return [];

  // Batch fetch comments (1 query instead of N)
  const postIds = posts.map(p => p.id);
  const comments = await Comment.find({
    postId: { $in: postIds }
  }).lean();

  // Batch fetch unique authors (1 query)
  const authorIds = [...new Set(posts.map(p => p.authorId))];
  const authors = await User.find({
    _id: { $in: authorIds }
  }).select('id name avatar').lean();

  // Map to posts
  const commentsByPost = groupBy(comments, 'postId');
  const authorsById = keyBy(authors, 'id');

  return posts.map(post => ({
    ...post,
    comments: commentsByPost[post.id] || [],
    author: authorsById[post.authorId]
  }));
}
```

### Required Indexes

```javascript
// MongoDB indexes
db.posts.createIndex({ userId: 1, createdAt: -1 });
db.comments.createIndex({ postId: 1 });
```

### Performance Improvement
- **Queries**: 102 → 3 (97% reduction)
- **Response time**: 3-5s → 50-100ms (95-98% reduction)
- **Database load**: 97% reduction
- **Scalability**: Supports 10x more concurrent users

### Monitoring

```javascript
// Add performance metrics
const startTime = Date.now();
const posts = await getUserPosts(userId);
const duration = Date.now() - startTime;

if (duration > 200) {
  logger.warn('Slow query', { userId, duration, postCount: posts.length });
}
```
```

### React Performance

```bash
@performance-tuner React app is slow - initial load 8 seconds, interactions laggy

Component: UserDashboard
- Renders list of 1000 items
- Each item has image, text, buttons
- State updates cause full re-renders
```

**Agent Response:**
```markdown
## React Performance Analysis ⚛️

### Identified Issues

#### 🔴 Critical: Unnecessary Re-renders
```javascript
function UserDashboard() {
  const [users, setUsers] = useState([]);

  // ⚠️ Creates new function on every render
  const handleClick = (id) => { /* ... */ };

  return (
    <div>
      {users.map(user => (
        // ⚠️ All items re-render when any state changes
        <UserCard key={user.id} user={user} onClick={handleClick} />
      ))}
    </div>
  );
}
```

#### 🟡 No Virtualization for Long Lists
- Rendering 1000 DOM nodes
- Each with images and buttons
- Massive DOM size

#### 🟡 Large Bundle Size
- No code splitting
- All components in main bundle
- Heavy dependencies

### Optimized Solution

```typescript
import { memo, useCallback, useMemo } from 'react';
import { FixedSizeList } from 'react-window';

// 1. Memoize expensive components
const UserCard = memo(({ user, onClick }) => {
  return (
    <div className="user-card">
      <img src={user.avatar} alt={user.name} loading="lazy" />
      <h3>{user.name}</h3>
      <button onClick={() => onClick(user.id)}>View</button>
    </div>
  );
});

function UserDashboard() {
  const [users, setUsers] = useState([]);

  // 2. Memoize callbacks
  const handleClick = useCallback((id) => {
    // Handle click
  }, []); // Only created once

  // 3. Virtualize long list
  const Row = ({ index, style }) => (
    <div style={style}>
      <UserCard user={users[index]} onClick={handleClick} />
    </div>
  );

  return (
    <FixedSizeList
      height={600}
      itemCount={users.length}
      itemSize={80}
      width="100%"
    >
      {Row}
    </FixedSizeList>
  );
}
```

### Bundle Optimization

```javascript
// Dynamic imports for code splitting
const UserDashboard = lazy(() => import('./UserDashboard'));
const AdminPanel = lazy(() => import('./AdminPanel'));

// In router
<Suspense fallback={<Loading />}>
  <Routes>
    <Route path="/dashboard" element={<UserDashboard />} />
    <Route path="/admin" element={<AdminPanel />} />
  </Routes>
</Suspense>
```

### Performance Metrics

**Before:**
- Initial load: 8 seconds
- Bundle size: 2.4 MB
- DOM nodes: 1000+
- Interaction latency: 500ms

**After:**
- Initial load: 1.2 seconds (85% improvement)
- Bundle size: 380 KB (84% reduction)
- DOM nodes: ~20 (98% reduction)
- Interaction latency: 16ms (97% improvement)

### Monitoring

```javascript
// React DevTools Profiler
import { Profiler } from 'react';

<Profiler id="UserDashboard" onRender={onRenderCallback}>
  <UserDashboard />
</Profiler>

function onRenderCallback(id, phase, actualDuration) {
  if (actualDuration > 16) {
    console.warn('Slow render', { id, phase, actualDuration });
  }
}
```
```

### Database Query Optimization

```bash
@performance-tuner This query takes 15 seconds on 10M rows

SELECT u.name, COUNT(o.id) as order_count, SUM(o.total) as total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.created_at > '2023-01-01'
GROUP BY u.id
ORDER BY total_spent DESC
LIMIT 100;
```

**Agent Response:**
```markdown
## Database Performance Analysis 🗄️

### Current Performance
- Execution time: 15 seconds
- Rows scanned: 10M users + 50M orders
- Full table scans on both tables

### Execution Plan Analysis

```sql
EXPLAIN ANALYZE
-- Shows:
-- Seq Scan on users (cost=0..250000)
-- Seq Scan on orders (cost=0..1000000)
-- No indexes used
```

### Required Indexes

```sql
-- 1. Index on users.created_at for WHERE clause
CREATE INDEX idx_users_created_at ON users(created_at);

-- 2. Index on orders.user_id for JOIN
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- 3. Composite index for sorting
CREATE INDEX idx_orders_user_total ON orders(user_id, total);
```

### Optimized Query

```sql
-- Use CTE for better optimization
WITH user_stats AS (
  SELECT
    u.id,
    u.name,
    COUNT(o.id) as order_count,
    SUM(o.total) as total_spent
  FROM users u
  LEFT JOIN orders o ON u.id = o.user_id
  WHERE u.created_at > '2023-01-01'
    AND u.id IN (
      -- Pre-filter top users by order volume
      SELECT DISTINCT user_id
      FROM orders
      WHERE created_at > '2023-01-01'
      ORDER BY total DESC
      LIMIT 1000
    )
  GROUP BY u.id, u.name
)
SELECT * FROM user_stats
ORDER BY total_spent DESC
LIMIT 100;
```

### Further Optimization: Materialized View

```sql
-- Create materialized view for expensive aggregation
CREATE MATERIALIZED VIEW user_order_stats AS
SELECT
  u.id,
  u.name,
  COUNT(o.id) as order_count,
  SUM(o.total) as total_spent,
  MAX(o.created_at) as last_order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Refresh periodically (e.g., every hour)
REFRESH MATERIALIZED VIEW CONCURRENTLY user_order_stats;

-- Query becomes instant
SELECT * FROM user_order_stats
WHERE last_order_date > '2023-01-01'
ORDER BY total_spent DESC
LIMIT 100;
```

### Performance Improvement
- **Execution time**: 15s → 50ms (99.7% improvement)
- **Rows scanned**: 60M → 1000 (99.998% reduction)
- **CPU usage**: 95% reduction
- **Memory**: 70% reduction

### Monitoring

```sql
-- Track slow queries
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
WHERE mean_exec_time > 1000  -- Queries > 1 second
ORDER BY mean_exec_time DESC
LIMIT 20;
```
```

## 🔧 Profiling Tools

### Backend Profiling
- **Node.js**: node --prof, clinic.js, 0x
- **Python**: cProfile, py-spy, memory_profiler
- **Java**: JProfiler, VisualVM, YourKit

### Frontend Profiling
- **Chrome DevTools**: Performance tab, Coverage
- **Lighthouse**: Performance audits
- **Web Vitals**: LCP, FID, CLS monitoring
- **Bundle analysis**: webpack-bundle-analyzer

### Database Profiling
- **PostgreSQL**: EXPLAIN ANALYZE, pg_stat_statements
- **MongoDB**: explain(), profiler
- **MySQL**: EXPLAIN, slow query log

## 🎯 Best Practices

### Performance Optimization Process
1. **Measure first** - Profile before optimizing
2. **Identify bottlenecks** - Focus on biggest impact
3. **Optimize incrementally** - Test each change
4. **Measure again** - Verify improvements
5. **Monitor continuously** - Prevent regressions

### When to Optimize
✅ **Optimize when:**
- Users reporting slowness
- Performance metrics degrading
- Preparing for traffic spike
- Before hitting resource limits

❌ **Don't optimize when:**
- No performance issues
- Premature optimization
- Without profiling data
- Minor improvements (<10%)

---

**Need performance optimization? ⚡**

Use `@performance-tuner` with profiling data and metrics for expert analysis and data-driven improvements!
