const path = require('path');
const { merge } = require("webpack-merge");
const common = require("./webpack.common.js");
const { stylePaths } = require("./stylePaths");
const HOST = process.env.HOST || "localhost";
const PORT = process.env.PORT || "9000";
const GATEWAY_HOST = process.env.ENTERPRISE_APP_GATEWAY_URL || 'http://localhost:8080';

module.exports = merge(common('development'), {
  mode: "development",
  devtool: "eval-source-map",
  devServer: {
    contentBase: "./dist",
    host: HOST,
    port: PORT,
    compress: true,
    inline: true,
    historyApiFallback: true,
    overlay: true,
    open: true,
    proxy: [
      {
        context: ['/customers-api'],
        target: GATEWAY_HOST,
      },
      {
        context: ['/orders-api'],
        target: GATEWAY_HOST,
      },
      {
        context: ['/products-api'],
        target: GATEWAY_HOST,
      },
    ],
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        include: [
          ...stylePaths
        ],
        use: ["style-loader", "css-loader"]
      }
    ]
  }
});
