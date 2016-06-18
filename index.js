module.exports = {
  extends: ['eslint-config-airbnb'].map(require.resolve),
  parser: 'babel-eslint',
  rules: {
    'camelcase': 0,
    'import/no-unresolved': 0,
    'max-len': 0,
    'no-underscore-dangle': [2, { 'allowAfterThis': true }],
    'react/prefer-stateless-function': 0,
    'react/sort-comp': 0,
    'semi': [2, 'never'],
    "no-param-reassign": ["error", { "props": false }],
  },
};
