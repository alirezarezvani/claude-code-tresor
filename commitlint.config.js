module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',      // New feature
        'fix',       // Bug fix
        'docs',      // Documentation changes
        'style',     // Code style changes (formatting, no logic change)
        'refactor',  // Code refactoring
        'perf',      // Performance improvements
        'test',      // Test additions or fixes
        'build',     // Build system changes
        'ci',        // CI/CD changes
        'chore',     // Maintenance tasks
        'revert',    // Revert previous commit
      ],
    ],
    'subject-case': [0], // Disable subject case checking
    'body-max-line-length': [0], // Disable body line length (GitHub squash merges often exceed 100 chars)
  },
};
