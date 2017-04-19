module.exports = {
  extends: ['eslint-config-airbnb'].map(require.resolve),
  parser: 'babel-eslint',
  rules: {
    'arrow-body-style': 0,
    'arrow-parens': ['error', 'as-needed'],
    'camelcase': ['error'],
    'import/no-unresolved': 0,
    'max-len': 0,
    'no-param-reassign': 0,
    'no-underscore-dangle': [2, { 'allowAfterThis': true }],
    'no-unused-vars': ["error", { "vars": "all", "args": "after-used" }],
    'react/jsx-no-bind': 0,
    'react/prefer-stateless-function': 0,
    'react/sort-comp': 0,
    'semi': [2, 'never'],
  },
};
