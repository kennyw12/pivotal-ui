import puiAliases from '../../helpers/pui-aliases';
import webpack from 'webpack';

const dedupe = new webpack.optimize.DedupePlugin();
const uglify = new webpack.optimize.UglifyJsPlugin({compress: {warnings: false}});

export default {
  //devtool: 'source-map',
  output: {
    filename: '[name].js',
    chunkFilename: '[id].js'
  },
  externals: {
    'jquery': 'jQuery',
    'lodash': '_',
    'pui-prismjs': 'Prism',
    'react': 'React',
    'react/addons': 'React',
    'react-bootstrap': 'ReactBootstrap'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader?stage=0&optional[]=runtime&loose=true'
      },
      {
        test: /bootstrap/,
        loader: 'imports?jQuery=jquery'
      }
    ]
  },
  plugins: [dedupe, uglify],
  resolve: {
    alias: {
      bootstrap: `${__dirname}/../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js`,
      ...puiAliases
    }
  }
};
