import path from 'path';
module.exports = function(options = {}) {
  const {nodeEnv = process.env.NODE_ENV || 'development'} = options;
  return Object.assign({
    output: {
      filename: '[name].js',
      chunkFilename: '[id].js',
      pathinfo: true
    }
  }, require(path.join('..', 'config', 'webpack', nodeEnv)), options);
};
